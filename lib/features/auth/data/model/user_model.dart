class UserModel {
  String? userName;
  String? email;
  String? id;
  UserModel({this.userName, this.email, this.id});



  UserModel.fromJson(Map<String, dynamic> json)
    : userName = json['userName'] as String?,
      email = json['email'] as String?,
      id = json['id'] as String?;

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'email': email, 'id': id};
  }
}
