import 'package:intl/intl.dart';

class TaskModel {
  String id;
  String title;
  String description;
  String status;
  String createdDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      status: json["status"],
      createdDate: DateFormat().format(DateTime.parse(json["createdDate"])),
    );
  }
}
