import 'package:flutter/foundation.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';
import 'package:health_monitoring_dashboard/model/doctor_model.dart';
import 'package:health_monitoring_dashboard/model/hospital_model.dart';
import 'package:health_monitoring_dashboard/model/specialist_model.dart';
import 'package:health_monitoring_dashboard/model/user_model.dart';

class CommonProvider extends ChangeNotifier {
  List<DoctorModel> doctorList = [];
  List<UserModel> userList = [];
  List<SpecialistModel> hospital = [];
  List<HospitalModel> hospitalList = [];

// Get all doctor
  void getAllDoctor() {
    DatabaseHelper.fetchAllDoctorList().listen((event) {
      doctorList = List.generate(event.docs.length,
          (index) => DoctorModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

// Get all user
  void getAllUser() {
    DatabaseHelper.fetchAllUserList().listen((event) {
      userList = List.generate(event.docs.length,
          (index) => UserModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

// Get all specialist
  void getAllSpecialist() {
    DatabaseHelper.fetchAllSpecialist().listen((event) {
      hospital = List.generate(event.docs.length,
          (index) => SpecialistModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

// Get all hospital
  void getAllHospital() {
    DatabaseHelper.fetchAllHospitalList().listen((event) {
      hospitalList = List.generate(event.docs.length,
          (index) => HospitalModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
}
