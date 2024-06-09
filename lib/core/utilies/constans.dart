class AppConstants {
  static const String baseUrl = "https://dummyjson.com/";

  static const String login = "${baseUrl}auth/login";

  static String allTodoUrl({required int limit, required int skip}) {
    return '${baseUrl}todos?limit=$limit&skip=$skip';
  }
  static String ownTodoUrl({required int userId}) {
    return '${baseUrl}todos/user/$userId';
  }
}