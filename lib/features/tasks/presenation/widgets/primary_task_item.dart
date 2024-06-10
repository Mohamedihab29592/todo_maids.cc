import 'package:flutter/material.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';


class PrimaryTaskItem extends StatefulWidget {
  final TodoEntity task;
  final bool isCompleted;

  const PrimaryTaskItem({
    super.key,
    required this.task,
    required this.isCompleted,
  });

  @override
  State<PrimaryTaskItem> createState() => _PrimaryTaskItemState();
}

class _PrimaryTaskItemState extends State<PrimaryTaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          InkWell(
            onTap: () async {},
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: widget.task.completed ? Colors.blue : Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: widget.task.completed
                  ?  const Icon(
                Icons.check,
                color: Colors.black,
                size: 18.0,
              ):const SizedBox()

            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Text(
              widget.task.todo,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
