import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/modules/toDoList/cubit/cubit.dart';
import 'package:todolist/modules/toDoList/cubit/status.dart';
import 'package:todolist/shared/components/components.dart';


class doneTasks extends StatelessWidget {
  const doneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      builder: (context,state){
        var tasks = AppCubit.get(context).doneTaskMap ;
        return taskBuilder(tasks: tasks);
      },
      listener: (context , state) {},
    );
  }
}
