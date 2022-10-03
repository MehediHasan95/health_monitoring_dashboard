import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/auth/auth_service.dart';
import 'package:health_monitoring_dashboard/view/dashboard.dart';
import 'package:health_monitoring_dashboard/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeNames = "/SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (AuthService.currentUser == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeNames, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Dashboard.routeNames, (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
