import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/provider/admin_provider.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
import 'package:health_monitoring_dashboard/view/dashboard.dart';
import 'package:health_monitoring_dashboard/view/doctor_list.dart';
import 'package:health_monitoring_dashboard/view/hospital_list.dart';
import 'package:health_monitoring_dashboard/view/login_screen.dart';
import 'package:health_monitoring_dashboard/view/specialist.dart';
import 'package:health_monitoring_dashboard/view/splash_screen.dart';
import 'package:health_monitoring_dashboard/view/user_list.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => CommonProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Roboto"),
        home: const SplashScreen(),
        routes: {
          SplashScreen.routeNames: (context) => const SplashScreen(),
          Dashboard.routeNames: (context) => const Dashboard(),
          LoginScreen.routeNames: (context) => const LoginScreen(),
          DoctorList.routeNames: (context) => const DoctorList(),
          UserList.routeNames: (context) => const UserList(),
          Specialist.routeNames: (context) => const Specialist(),
          HospitalList.routeNames: (context) => const HospitalList(),
        },
      ),
    );
  }
}
