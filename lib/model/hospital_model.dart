class HospitalModel {
  String? id;
  String? hospital;

  HospitalModel({
    this.id,
    this.hospital,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'hospital': hospital,
      };

  factory HospitalModel.fromMap(Map<String, dynamic> map) => HospitalModel(
        id: map['id'],
        hospital: map['hospital'],
      );
}
