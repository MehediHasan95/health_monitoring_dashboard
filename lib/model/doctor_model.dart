class DoctorModel {
  String? uniqueId;
  String? uid;
  String? name;
  String? gender;
  String? email;
  String? specialist;
  String? hospital;

  DoctorModel(
      {this.uniqueId,
      this.uid,
      this.name,
      this.gender,
      this.email,
      this.specialist,
      this.hospital});

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uniqueId': uniqueId,
        'uid': uid,
        'name': name,
        'gender': gender,
        'email': email,
        'specialist': specialist,
        'hospital': hospital,
      };

  factory DoctorModel.fromMap(Map<String, dynamic> map) => DoctorModel(
        uniqueId: map['uniqueId'],
        uid: map['uid'],
        name: map['name'],
        gender: map['gender'],
        email: map['email'],
        specialist: map['specialist'],
        hospital: map['hospital'],
      );
}
