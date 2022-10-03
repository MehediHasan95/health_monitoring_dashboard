class UserModel {
  String? uid;
  String? username;
  String? gender;
  String? email;

  UserModel({
    this.uid,
    this.username,
    this.gender,
    this.email,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uid': uid,
        'username': username,
        'gender': gender,
        'email': email,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map['uid'],
        username: map['username'],
        gender: map['gender'],
        email: map['email'],
      );
}
