part of 'task_bloc.dart';




class TaskState extends Equatable{
  final List<TodoEntity> allTodoTasks;
  final RequestState allTodoStates;
  final String allTodoMessage;
  final int currentPage;
  final bool hasReachedMax;
  final bool isFetchingMore;


  final List<TodoEntity> ownTodoTasks;
  final List<TodoEntity> completedTodoTasks;
  final List<TodoEntity> unCompletedTodoTasks;
  final RequestState ownTodoStates;
  final String ownTodoMessage;







  const TaskState({
    this.allTodoTasks = const [],
    this.completedTodoTasks = const [],
    this.unCompletedTodoTasks = const [],
    this.allTodoStates= RequestState.loading,
    this.allTodoMessage='',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.isFetchingMore = false,

    this.ownTodoTasks = const [],
    this.ownTodoStates= RequestState.loading,
    this.ownTodoMessage='',



  });
  TaskState copyWith({
    List<TodoEntity>? allTodoTasks,
    RequestState? allTodoStates,
    String? allTodoMessage,

    int? allTodoCurrentPage,
    int? currentPage,
    bool? hasReachedMax,
    bool? isFetchingMore,

    List<TodoEntity>? ownTodoTasks,
    List<TodoEntity>? completedTodoTasks,
    List<TodoEntity>? unCompletedTodoTasks,
    RequestState? ownTodoStates,
    String? ownTodoMessage,

  }){
    return TaskState(
      allTodoTasks: allTodoTasks ?? this.allTodoTasks,
      allTodoStates: allTodoStates ?? this.allTodoStates,
      allTodoMessage: allTodoMessage ?? this.allTodoMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,

      ownTodoTasks: ownTodoTasks ?? this.ownTodoTasks,
      completedTodoTasks: completedTodoTasks ?? this.completedTodoTasks,
      unCompletedTodoTasks: unCompletedTodoTasks ?? this.unCompletedTodoTasks,
      ownTodoStates: ownTodoStates ?? this.ownTodoStates,
      ownTodoMessage: ownTodoMessage ?? this.ownTodoMessage,


    );
  }

  @override
  List<Object?> get props =>[allTodoTasks,allTodoStates,allTodoMessage,ownTodoTasks,ownTodoStates,ownTodoMessage,
    currentPage,
    hasReachedMax,isFetchingMore,completedTodoTasks,unCompletedTodoTasks];

}
