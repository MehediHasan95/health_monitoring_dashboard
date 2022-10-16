import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_monitoring_dashboard/auth/auth_service.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
import 'package:health_monitoring_dashboard/view/doctor_list.dart';
import 'package:health_monitoring_dashboard/view/hospital_list.dart';
import 'package:health_monitoring_dashboard/view/login_screen.dart';
import 'package:health_monitoring_dashboard/view/specialist.dart';
import 'package:health_monitoring_dashboard/view/user_list.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const String routeNames = '/Dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final uid = AuthService.currentUser?.uid;
  late CommonProvider _commonProvider;

  @override
  void didChangeDependencies() {
    _commonProvider = Provider.of<CommonProvider>(context, listen: false);
    _commonProvider.getAllDoctor();
    _commonProvider.getAllUser();
    _commonProvider.getAllSpecialist();
    _commonProvider.getAllHospital();
    getAdmin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Admin Panel"),
        // actions: [
        //   IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
        // ],
      ),
      body: Container(
        color: Colors.deepPurple.shade100,
        child: GridView.count(
          padding: const EdgeInsets.all(8.0),
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DoctorList.routeNames);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.userDoctor),
                    SizedBox(height: 5),
                    Text("DOCTOR")
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, UserList.routeNames);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.users),
                    SizedBox(height: 5),
                    Text("USER")
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Specialist.routeNames);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.brain),
                    SizedBox(height: 5),
                    Text("SPECIALIST")
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, HospitalList.routeNames);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.hospital),
                    SizedBox(height: 5),
                    Text("HOSPITAL")
                  ],
                )),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(email!, style: const TextStyle(color: Colors.white)),
                  ],
                )),
            ListTile(
              onTap: _logOut,
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

// Logout method
  void _logOut() {
    AuthService.signOut().whenComplete(() => Navigator.of(context)
        .pushNamedAndRemoveUntil(
            LoginScreen.routeNames, (Route<dynamic> route) => false));
  }

  String? name = '';
  String? email = '';
  String? gender = '';
  Future getAdmin() async {
    await DatabaseHelper.db.collection('admin').doc(uid).get().then(
      (querySnapshot) {
        name = querySnapshot.data()!['name'];
        email = querySnapshot.data()!['email'];
        gender = querySnapshot.data()!['gender'];
      },
    );
    setState(() {
      name;
      email;
      gender;
    });
  }
}
