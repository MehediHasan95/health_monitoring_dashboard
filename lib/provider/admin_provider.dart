import 'package:flutter/foundation.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';

class AdminProvider extends ChangeNotifier {
  Future<bool> isUser(String email) => DatabaseHelper.isAdmin(email);
}
