import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todolist/modules/toDoList/cubit/cubit.dart';


Widget defaultTextField({
  required  TextEditingController controller,
  required  TextInputType type,
  IconData? prefix,
  required  String label,
  String hintText = 'Enter your email',
  Function? onSubmit ,
  Function? onChange ,
  Function? onTap ,
  Function? validate ,
  Function? suffixPressed ,
  bool  isPassword = false,
  IconData? suffix ,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: (value){
    onSubmit!(value);
  },
  onChanged: (value){
    onChange!(value);
  },
  validator: (value){
   return validate!(value);
  },
  onTap: (){
    onTap!();
  },
  decoration: InputDecoration(
    hintText: hintText,
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(
      onPressed: ()
      {
        suffixPressed!();
      },
      icon: Icon(suffix),
    ),
    border: OutlineInputBorder(),
  ),
);

Widget defaultButton({
  double width = double.maxFinite,
  double height = 50,
  double radius = 10,
  Color backGround = Colors.brown,
  required Function function,
  required String text,
  bool  isUpperCase = false,
}) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: backGround,
      borderRadius: BorderRadius.circular(radius),
    ),
  child: MaterialButton(
    onPressed: (){
      function ();
    },
    child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
  ) ,
));


Widget defaultIconButton({
  double width = double.maxFinite,
  double height = 50,
  double radius = 10,
  Color iconColor = Colors.white,
  Color backGround = Colors.brown,
  IconData Iconbtn = Icons.add,
  required Function function,
  String? text,
  bool  isUpperCase = false,
}) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: backGround,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: IconButton(
      onPressed: (){
        function();
      },
      icon: Icon(Iconbtn),
      color: iconColor,
    )
);

Widget buildTaskItem(Map model , context) => Dismissible( // updating , remove , nav to UI
  key: Key(model['id'].toString()),
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            "${model['time']}" ,
          ),
        ),
        SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model['title']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${model['date']}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(width: 20,),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status:'done', id: model['id'],); // update data
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.orangeAccent,
            )
        ),
        IconButton(
          onPressed: (){
            AppCubit.get(context).updateData(status: 'archive', id:model['id'],); // update data
          },
          icon: Icon(
            Icons.archive,
            color: Colors.orangeAccent,
          ),
        ),
      ],
    ),
  ),
  onDismissed: (direction){ // for deleting
    AppCubit.get(context).deleteData(id: model['id']);
    },
);
Widget taskBuilder({
  required List<Map> tasks ,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context , index ) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context , index ) => SizedBox(height: 20),
    itemCount: tasks.length ,
  ),
  fallback: (context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet , Please add some tasks',
            style: TextStyle(
              fontSize: 50,
            ),
          )

        ],
      ),
    ),
  ),
);



void navigateTo(context , widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget,));