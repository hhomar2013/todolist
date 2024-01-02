import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/modules/toDoList/TasksScreen.dart';
import 'package:todolist/modules/toDoList/archiveTasks.dart';
import 'package:todolist/modules/toDoList/cubit/status.dart';
import 'package:todolist/modules/toDoList/doneTasks.dart';
import 'package:todolist/shared/components/constant.dart';

class AppCubit extends Cubit<AppStatus>{
  AppCubit() : super(AppInitialStat());
  //to make it global in application to see it in all of screens
  static AppCubit get(context) => BlocProvider.of(context);
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  late Database database;
  List<Map> taskMap =[];
  List<Map> doneTaskMap =[];
  List<Map> archiveTaskMap =[];
  int currentIndex = 0;
  List <String> pageTitle = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];
  List <Color> ScreenColors = [
    Colors.blueAccent,
    Colors.green,
    Colors.orange
  ];
  List <Widget> Screens = [
    TasksScreen(),
    doneTasks(),
    archiveTask(),
  ];
  List <Icon> todoIcons =[
    Icon(Icons.list_outlined),
    Icon(Icons.done),
    Icon(Icons.archive),
  ];
  void changeIndex (int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  //Create database
  void createDatabase() async{
    database = await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database , version) {
          database.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT ,date TEXT ,time TEXT ,status TEXT)").then((value) {
            print('Table Created');
          }).catchError((error){
            print('Error in create this table ${error.toString()}');
          });
        },
        onOpen: (database){
          getDataFromDatabase(database);
          print('DB Opened');
        }
    ).then((value) {
      emit(AppCreateDataBaseState());
      return database = value;
    });
  }

  void formClear(){
    titleController.clear();
    dateController.clear();
    timeController.clear();
  }

  Future insertDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database.transaction((txn) {
      return  txn.rawInsert("INSERT INTO tasks(title,date,time,status)"
          " VALUES('$title','$date','$time','new')")
          .then((value) {
        print('$value Inserted.');
        emit(AppInsertDataBaseState());
        formClear();
        getDataFromDatabase(database);
      }).catchError((onError) {
        print('Error in $onError');
      });
    });
  }

   void  getDataFromDatabase(database)  {
    taskMap = [];
    doneTaskMap = [];
    archiveTaskMap = [];
    emit(AppGetDataBaseLoadingState());
      database.rawQuery('SELECT * FROM tasks').then((value){
          value.forEach((element){
            if(element['status'] == 'new'){
              taskMap.add(element);
            }else if (element['status'] == 'done'){
              doneTaskMap.add(element);
            }else if (element['status'] == 'archive'){
              archiveTaskMap.add(element);
            }
          });
        emit(AppGetDataBaseState());
      });//calling

  }

  void changeBottomSheetState ({
    required bool isShow ,
    required IconData icon ,
  }){
    isBottomSheetShown = isShow ;
    fabIcon = icon ;
    emit(AppChangeBottomSheetState());
    }


    void updateData({
      required String status,
      required int id,
    })async{
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?' , ['$status',id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
    }


    void deleteData({
      required id,
    })async{
      database.rawDelete('DELETE FROM tasks WHERE id = $id');
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    }


}