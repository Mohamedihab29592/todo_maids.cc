import 'package:flutter/material.dart';
import 'package:todo_task/features/tasks/domain/entities/todo_entity.dart';
import '../../../../core/app_router/app_router.dart';
import '../../../../core/utilies/strings.dart';
import '../controller/bloc/task/task_bloc.dart';
import '../controller/bloc/task/task_event.dart';
import 'primary_task_item.dart';



class TasksWidget extends StatefulWidget {
  final List<TodoEntity> tasks;
  final TaskBloc taskBloc;

  const TasksWidget({
    super.key,
    required this.tasks,
    required this.taskBloc,
  });

  @override
  TasksWidgetState createState() => TasksWidgetState();
}

class TasksWidgetState extends State<TasksWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    cacheHelper.clearTodos(AppStrings.allTodosKey);
    cacheHelper.clearTodos(AppStrings.ownTodosKey);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll &&
        !widget.taskBloc.state.isFetchingMore ) {
      widget.taskBloc.add(FetchNextPageEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.tasks.isNotEmpty
        ? Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.tasks.length + (widget.taskBloc.state.isFetchingMore ? 1 : 0), // Add 1 for loading indicator
        itemBuilder: (context, index) {
          if (index == widget.tasks.length && widget.taskBloc.state.isFetchingMore) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          return PrimaryTaskItem(
            isCompleted: widget.tasks[index].completed,
            task: widget.tasks[index],
          );
        },
              ),
            )
        :  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.edit,
            size: 50,
            color: Colors.grey,
          ),
          Text(
            AppStrings.noTasks,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}







