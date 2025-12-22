class TaskCountModel {
  String id;
  int sum;

  TaskCountModel({required this.id, required this.sum});

  factory TaskCountModel.fromJson(Map<String, dynamic> json) {
    return TaskCountModel(id: json["_id"], sum: json["sum"]);
  }
}
