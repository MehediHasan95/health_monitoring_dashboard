import 'package:flutter/foundation.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';
import 'package:health_monitoring_dashboard/model/admin_model.dart';

class AdminProvider extends ChangeNotifier {
  Future<bool> isUser(String email) => DatabaseHelper.isAdmin(email);

  List<AdminModel> admin = [];
  // Get all user
  void getAdmin() {
    DatabaseHelper.fetchAdmin().listen((event) {
      admin = List.generate(event.docs.length,
          (index) => AdminModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
}
