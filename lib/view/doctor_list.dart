import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/model/doctor_model.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
import 'package:health_monitoring_dashboard/utils/constant.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});
  static const String routeNames = '/DoctorList';

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  late CommonProvider _commonProvider;

  @override
  void didChangeDependencies() {
    _commonProvider = Provider.of<CommonProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Doctor list"),
      ),
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _commonProvider.doctorList.length,
                itemBuilder: (context, index) {
                  final doctor = _commonProvider.doctorList[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        leading: doctor.gender == 'Male'
                            ? Image.asset('assets/man-doctor.png', height: 50)
                            : Image.asset('assets/woman-doctor.png',
                                height: 50),
                        title: Text("${doctor.name}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${doctor.email}"),
                        trailing: IconButton(
                            onPressed: () {
                              _deleteMethod(doctor.uid);
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent)),
                        onLongPress: () {
                          _getDoctorProfile(doctor);
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _deleteMethod(String? uid) {
    deleteDialog(context, "Do you want to delete this doctor's account?", uid!,
        "doctor");
  }

  void _getDoctorProfile(DoctorModel doctor) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Column(
                children: [
                  doctor.gender == "Male"
                      ? Image.asset('assets/man-doctor.png', height: 150)
                      : Image.asset('assets/woman-doctor.png', height: 150),
                  const SizedBox(height: 10),
                  Text("${doctor.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade900)),
                ],
              ),
              content: Column(
                children: [
                  Text("(${doctor.hospital})",
                      style: TextStyle(color: Colors.grey.shade900)),
                  Text("${doctor.specialist}",
                      style: TextStyle(color: Colors.grey.shade900)),
                  Text("Reg. No: ${doctor.uniqueId}",
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('CLOSE',
                      style: TextStyle(color: Colors.redAccent)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
