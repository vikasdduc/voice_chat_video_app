class UserModel {
  final String name;
  final String username;
  final String phoneNumber;
  final String? emailId;

  UserModel({
    required this.name,
    required this.username,
    required this.phoneNumber,
    this.emailId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      emailId: json['emailId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'phoneNumber': phoneNumber,
      'emailId': emailId,
    };
  }
}
