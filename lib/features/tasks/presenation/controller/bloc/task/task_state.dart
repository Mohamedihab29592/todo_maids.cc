part of 'task_bloc.dart';




class TaskState extends Equatable {
  final List<TodoEntity> allTodoTasks;
  final RequestState allTodoStates;
  final String allTodoMessage;
  final int currentPage;
  final bool hasReachedMax;
  final bool isFetchingMore;

  final List<TodoEntity> ownTodoTasks;
  final RequestState ownTodoStates;
  final String ownTodoMessage;

  // New properties for update and delete states
  final RequestState isUpdatingStates;


  final String updateErrorMessage;
  final RequestState isDeletingStates;

  final String deleteErrorMessage;

  const TaskState( {
    this.allTodoTasks = const [],
    this.allTodoStates = RequestState.loading,
    this.allTodoMessage = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.isFetchingMore = false,
    this.ownTodoTasks = const [],
    this.ownTodoStates = RequestState.loading,
    this.ownTodoMessage = '',
    this.updateErrorMessage = '',
    this.deleteErrorMessage = '',
    this.isUpdatingStates = RequestState.loading,
    this.isDeletingStates=RequestState.loading,
  });

  TaskState copyWith({
    List<TodoEntity>? allTodoTasks,
    RequestState? allTodoStates,
    String? allTodoMessage,
    int? currentPage,
    bool? hasReachedMax,
    bool? isFetchingMore,
    List<TodoEntity>? ownTodoTasks,
    RequestState? ownTodoStates,
    String? ownTodoMessage,
    String? updateErrorMessage,
    RequestState? isUpdatingStates,
    RequestState? isDeletingStates,

    String? deleteErrorMessage,
  }) {
    return TaskState(
      allTodoTasks: allTodoTasks ?? this.allTodoTasks,
      allTodoStates: allTodoStates ?? this.allTodoStates,
      allTodoMessage: allTodoMessage ?? this.allTodoMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      ownTodoTasks: ownTodoTasks ?? this.ownTodoTasks,
      ownTodoStates: ownTodoStates ?? this.ownTodoStates,
      ownTodoMessage: ownTodoMessage ?? this.ownTodoMessage,
      updateErrorMessage: updateErrorMessage ?? this.updateErrorMessage,
      deleteErrorMessage: deleteErrorMessage ?? this.deleteErrorMessage,
      isDeletingStates: isDeletingStates ?? this.isDeletingStates,
      isUpdatingStates: isUpdatingStates ?? this.isUpdatingStates,
    );
  }

  @override
  List<Object?> get props => [
    allTodoTasks,
    allTodoStates,
    allTodoMessage,
    currentPage,
    hasReachedMax,
    isFetchingMore,
    ownTodoTasks,
    ownTodoStates,
    ownTodoMessage,
    updateErrorMessage,
    deleteErrorMessage,
    isDeletingStates,
    isUpdatingStates,
  ];
}
