class SpecialistModel {
  String? id;
  String? specialist;

  SpecialistModel({
    this.id,
    this.specialist,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'specialist': specialist,
      };

  factory SpecialistModel.fromMap(Map<String, dynamic> map) => SpecialistModel(
        id: map['id'],
        specialist: map['specialist'],
      );
}
