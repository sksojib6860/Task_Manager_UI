class Url {
  static final String _baseUrl = "http://35.73.30.144:2005/api/v1";
  static final String registerUrl = "$_baseUrl/Registration";
  static final String signInUrl = "$_baseUrl/Login";
  static final String createTaskUrl = "$_baseUrl/createTask";
  static final String newTaskUrl = "$_baseUrl/listTaskByStatus/New";
  static final String completeTaskUrl = "$_baseUrl/listTaskByStatus/Completed";
  static final String cancelTaskUrl = "$_baseUrl/listTaskByStatus/Canceled";
  static final String progressTaskUrl = "$_baseUrl/listTaskByStatus/Progress";
  static final String taskCountUrl = "$_baseUrl/taskStatusCount";
  static final String updateProfileUrl = "$_baseUrl/ProfileUpdate";
  static final String resetPasswordUrl = "$_baseUrl/RecoverResetPassword";
  static  String deleteUrl (id) => "$_baseUrl/deleteTask/$id";
  static  String updateUrl (id,status)=> "$_baseUrl/updateTaskStatus/$id/$status";
  static  String recoveryEmailUrl (email)=> "$_baseUrl/RecoverVerifyEmail/$email";
  static  String verifyOtpUrl (email,code)=> "$_baseUrl/RecoverVerifyOtp/$email/$code";
}
