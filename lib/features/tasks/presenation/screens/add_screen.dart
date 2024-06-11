import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import '../../../../core/app_router/app_router.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/toast.dart';

import '../../../../core/utilies/strings.dart';
import '../../../auth/presenation/widgets/form_field.dart';
import '../../../auth/presenation/widgets/loading_manager.dart';

import '../controller/bloc/task_manager/manager_cubit.dart';
import '../controller/bloc/task_manager/manager_state.dart';



class AddScreen extends StatefulWidget {
  final int userId;

  const AddScreen({super.key, required this.userId});

  @override
  AddScreenState createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  bool _completed = false;
  final TextEditingController todoController = TextEditingController();
  bool isLoading = false;
  TodoEntity? task;

  @override
  void initState() {
    super.initState();
    _loadCachedTask();
  }

  Future<void> _loadCachedTask() async {
    final cachedTasks = await cacheHelper.readTodos(AppStrings.ownAddTodosKey);
    if (cachedTasks != null && cachedTasks.isNotEmpty) {
      setState(() {
        task = cachedTasks.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppStrings.addTask),
      ),
      body: BlocListener<ManagerCubit, ManagerStates>(
        listener: (context, state) {
          if (state is AddTaskLoadingState ) {
            setState(() {
              isLoading = true;
            });
          } else if (state is AddTaskSuccessState) {
            showToast(text: AppStrings.taskAdded, state: ToastStates.success);
            setState(() {
              isLoading = false;
              task = state.task;
              todoController.clear();
              _completed = false;
              _cacheTask(state.task);
            });
          }  else if (state is AddTaskErrorState ) {
            showToast(text: state.error, state: ToastStates.error);
            setState(() {
              isLoading = false;
            });
          }
        },
        child: LoadingManager(
          isLoading: isLoading,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyFormField(
                  controller: todoController,
                  hint: AppStrings.taskName,
                  type: TextInputType.text,
                  maxLines: 1,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterTaskNAme;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _completed,
                      onChanged: (newValue) {
                        setState(() {
                          _completed = newValue ?? false;
                        });
                      },
                    ),
                     Text(AppStrings.completed),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: PublicButton(
                      backgroundColor: Colors.blue,
                      function: () {
                        if (_validate()) {
                          ManagerCubit.of(context).addTask(
                            todo: todoController.text,
                            userId: widget.userId,
                            completed: _completed,
                          );
                        }
                      },
                      text: AppStrings.addTask,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                 Text(
                  AppStrings.task,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (task != null) ...[
                  ListTile(
                    title: Text(task!.todo),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          task!.completed ? Icons.check_circle : Icons.circle_outlined,
                          color: task!.completed ? Colors.green : Colors.red,
                        ),

                      ],
                    ),
                  ),
                ] else ...[
                   Text(AppStrings.noTasks),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validate() {
    if (todoController.text.isEmpty) {
      showToast(text: AppStrings.emptyTask, state: ToastStates.error);
      return false;
    }
    return true;
  }

  Future<void> _cacheTask(TodoEntity task) async {
    await cacheHelper.writeAddTodos(AppStrings.ownAddTodosKey, [task]);
  }


}







