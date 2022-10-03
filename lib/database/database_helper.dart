import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_monitoring_dashboard/model/hospital_model.dart';
import 'package:health_monitoring_dashboard/model/specialist_model.dart';
import 'package:health_monitoring_dashboard/model/verified_model.dart';

class DatabaseHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  // static final _userID = AuthService.currentUser?.uid;

  static const _adminCollection = 'admin';
  static const _doctorCollection = 'doctor';
  static const _userCollection = 'userProfileInfo';
  static const _specialistCollection = 'Specialist';
  static const _hospitalCollection = 'Hospital';
  static const _verifiedCollection = 'verifiedDoctor';

  // Admin login method
  static Future<bool> isAdmin(String email) async {
    final snapshot = await db
        .collection(_adminCollection)
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  // get all doctor list
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllDoctorList() =>
      db.collection(_doctorCollection).snapshots();

  // get all user list
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUserList() =>
      db.collection(_userCollection).snapshots();

  // get all specialist
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllSpecialist() =>
      db.collection(_specialistCollection).snapshots();

  // get all hospital list
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllHospitalList() =>
      db.collection(_hospitalCollection).snapshots();

  // get all hospital list
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllVerifiedList() =>
      db.collection(_verifiedCollection).snapshots();

  // get all hospital list
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAdmin() =>
      db.collection(_adminCollection).snapshots();

  // add specialist
  static Future<void> addSpecialist(SpecialistModel specialistModel) {
    final writeBatch = db.batch();
    final docID = db.collection(_specialistCollection).doc();
    specialistModel.id = docID.id;
    writeBatch.set(docID, specialistModel.toMap());
    return writeBatch.commit();
  }

  // add hospital
  static Future<void> addHospital(HospitalModel hospitalModel) {
    final writeBatch = db.batch();
    final docID = db.collection(_hospitalCollection).doc();
    hospitalModel.id = docID.id;
    writeBatch.set(docID, hospitalModel.toMap());
    return writeBatch.commit();
  }

  // add verified
  static Future<void> addVerified(VerifiedModel verifiedModel) {
    final writeBatch = db.batch();
    final docID = db.collection(_verifiedCollection).doc();
    verifiedModel.id = docID.id;
    writeBatch.set(docID, verifiedModel.toMap());
    return writeBatch.commit();
  }
}
