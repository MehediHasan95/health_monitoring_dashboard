class VerifiedModel {
  String? id;
  String? verified;

  VerifiedModel({
    this.id,
    this.verified,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'verified': verified,
      };

  factory VerifiedModel.fromMap(Map<String, dynamic> map) => VerifiedModel(
        id: map['id'],
        verified: map['verified'],
      );
}
