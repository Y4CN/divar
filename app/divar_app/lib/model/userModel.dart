class UserModel {
  int id;
  String userName;
  String name;
  String email;

  UserModel({
    required this.id,
    required this.userName,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['ID'],
      userName: json['user_name'],
      name: json['name'],
      email: json['email'],
    );
  }
}