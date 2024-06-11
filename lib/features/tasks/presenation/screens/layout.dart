import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_task/core/app_router/app_router.dart';
import '../../../../core/components/button.dart';
import '../../../../core/utilies/enum.dart';
import '../../../../core/utilies/strings.dart';
import '../../../../core/components/divider.dart';
import '../../../../core/components/toast.dart';
import '../controller/bloc/task/task_bloc.dart';
import '../widgets/tasks_widget.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              TabBar(
                labelPadding: const EdgeInsets.all(6),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                tabs: [
                  Tab(text: AppStrings.allTasks),
                  Tab(text: AppStrings.ownTasks),

                ],
              ),
              const MyDivider(),
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    var bloc = context.read<TaskBloc>();
                    if (state.allTodoStates == RequestState.loading ||
                        state.ownTodoStates == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state.allTodoStates == RequestState.error ||
                        state.ownTodoStates == RequestState.error) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showToast(text: state.allTodoMessage, state: ToastStates.error);
                      });
                    }

                    return TabBarView(
                      children: [
                        TasksWidget(tasks: state.allTodoTasks, taskBloc: bloc),
                        TasksWidget(tasks: state.ownTodoTasks, taskBloc: bloc),

                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PublicButton(
                    backgroundColor: Colors.blue,
                    function: () {
                      GoRouter.of(context).push(AppRouter.kAdd);
                    },
                    text: AppStrings.addTask,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
