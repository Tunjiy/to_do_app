import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskname;
  final bool taskcompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile(
      {super.key,
      required this.taskname,
      required this.onChanged,
      required this.taskcompleted,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade400,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                  value: taskcompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black),

              //taskname and also check if task is completed or not
              Text(taskname,
                  style: TextStyle(
                      decoration: taskcompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none)),
            ],
          ),
        ),
      ),
    );
  }
}
