import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_flutter/models/taskData.dart';
import 'package:todo_flutter/screens/addTask.dart';
import 'package:todo_flutter/utilities/constants.dart';
import 'package:todo_flutter/widgets/horizontalDivider.dart';
import 'package:todo_flutter/widgets/taskTile.dart';

class TaskScreen extends StatelessWidget {
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          showModalBottomSheet<dynamic>(
            backgroundColor: Color(0xff737373),
            context: context,
            isScrollControlled: true,
            builder: (context) => AddTask(),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              pinned: true,
              floating: false,
              expandedHeight: 70.0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 12,
                ),
                title: Text(
                  'Todo List',
                ),
              ),
            ),
            Consumer<TaskData>(
              builder: (context, taskData, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final task = taskData.tasks[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TaskTile(
                            taskTitle: task.name,
                            isChecked: task.isDone,
                            checkBoxCallBack: () {
                              taskData.updateTask(task);
                            },
                            deleteTask: () {
                              taskData.deleteTask(task);
                            },
                            slidableController: slidableController,
                          ),
                          HorizontalDivider(),
                        ],
                      );
                    },
                    childCount: taskData.taskCount,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
