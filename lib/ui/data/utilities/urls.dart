class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";

  static const String login = "$_baseUrl/login";
  static const String createTask = "$_baseUrl/createTask";

  static const String newTaskList = "$_baseUrl/listTaskByStatus/New";
  static const String completedTaskList = "$_baseUrl/listTaskByStatus/Completed";
  static const String inProgressTaskList = "$_baseUrl/listTaskByStatus/InProgress";
  static const String cancelledTaskList = "$_baseUrl/listTaskByStatus/Cancelled";
  static const String taskStatusCount = "$_baseUrl/taskStatusCount";

  static String deleteTask(String id) => "$_baseUrl/deleteTask/$id";
  static String editTask(String id,String value) => "$_baseUrl/updateTaskStatus/$id/$value";

  static String updateProfile = "$_baseUrl/profileUpdate";
  static String verifyEmail(String email) => "$_baseUrl/RecoverVerifyEmail/$email";
}