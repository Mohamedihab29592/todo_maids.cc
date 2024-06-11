import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_task/core/components/toast.dart';
import 'package:todo_task/core/utilies/enum.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import 'package:todo_task/features/tasks/presenation/controller/bloc/task/task_event.dart';
import '../../../../core/utilies/strings.dart';
import '../controller/bloc/task/task_bloc.dart';

class PrimaryTaskItem extends StatefulWidget {
  final TodoEntity task;
  final bool isCompleted;

  const PrimaryTaskItem({
    super.key,
    required this.task,
    required this.isCompleted,
  });

  @override
  PrimaryTaskItemState createState() => PrimaryTaskItemState();
}

class PrimaryTaskItemState extends State<PrimaryTaskItem> {
  late bool _isCompleted;

  @override
  void initState() {
    _isCompleted = widget.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
         if (state.isUpdatingStates == RequestState.error) {
          showToast(text: state.updateErrorMessage, state: ToastStates.error);
        } else if (state.isDeletingStates == RequestState.error) {
          showToast(text: state.deleteErrorMessage, state: ToastStates.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                BlocProvider.of<TaskBloc>(context).add(UpdateTaskEvent(todoId: widget.task.id, completed: !_isCompleted));
                setState(() {
                  _isCompleted = !_isCompleted;
                });
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: _isCompleted ? Colors.blue : Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _isCompleted
                    ? const Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 18.0,
                )
                    : const SizedBox(),
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
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: InkWell(
                    onTap: () async {
                      GoRouter.of(context).pop();
                      BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(todoId: widget.task.id));

                    },
                    child:  Row(
                      children: [
                        const Icon(Icons.delete),
                        Text(AppStrings.delete),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

