import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_flutter/utilities/constants.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  final Function checkBoxCallBack, deleteTask;
  final SlidableController slidableController;

  TaskTile({
    this.taskTitle = '',
    this.isChecked,
    this.checkBoxCallBack,
    this.deleteTask,
    this.slidableController,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: GestureDetector(
        onTap: checkBoxCallBack,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                isChecked
                    ? FontAwesomeIcons.checkCircle
                    : FontAwesomeIcons.circle,
                color: isChecked ? Colors.green.withOpacity(0.4) : kBlackColor,
                size: 19,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$taskTitle',
                style: TextStyle(
                  color: isChecked ? kBlackColor.withOpacity(0.4) : kBlackColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: deleteTask,
        ),
      ],
    );
  }
}
