import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
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
                        title: Text("${doctor.name} (${doctor.uniqueId})",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${doctor.email}"),
                        // trailing: IconButton(
                        //     onPressed: () {
                        //       _deleteMethod(doctor.uid);
                        //     },
                        //     icon: const Icon(Icons.delete,
                        //         color: Colors.redAccent)),
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

  // void _deleteMethod(String? uid) {
  //   DatabaseHelper.db.collection("doctor").doc(uid).delete();
  // }
}
