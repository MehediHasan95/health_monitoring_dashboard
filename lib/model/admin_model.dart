class AdminModel {
  String? name;
  String? gender;
  String? email;

  AdminModel({
    this.name,
    this.gender,
    this.email,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'gender': gender,
        'email': email,
      };

  factory AdminModel.fromMap(Map<String, dynamic> map) => AdminModel(
        name: map['name'],
        gender: map['gender'],
        email: map['email'],
      );
}
