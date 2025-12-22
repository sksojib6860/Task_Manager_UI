class UserModel {
  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String? photo;

  UserModel({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      mobile: json["mobile"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
    };
  }
}
