import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
final formKey = GlobalKey<FormState>();
IconData cibIcon = Icons.edit;
// List<Map> taskMap =[];
// int currentIndex = 0;
// List <String> pageTitle = [
//   'New Tasks',
//   'Done Tasks',
//   'Archive Tasks',
// ];
// List <Color> ScreenColors = [
//   Colors.blueAccent,
//   Colors.green,
//   Colors.orange
// ];
// List <Widget> Screens = [
//   tasks(),
//   doneTasks(),
//   archiveTask(),
// ];
// List <Icon> todoIcons =[
//   Icon(Icons.list_outlined),
//   Icon(Icons.done),
//   Icon(Icons.archive),
// ];
// late Database database;
// bool isBottomSheetShown = false;
// IconData fabIcon = Icons.edit;