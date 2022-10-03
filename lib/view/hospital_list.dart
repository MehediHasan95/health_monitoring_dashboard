import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';
import 'package:health_monitoring_dashboard/model/hospital_model.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
import 'package:health_monitoring_dashboard/utils/constant.dart';
import 'package:provider/provider.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({super.key});
  static const String routeNames = '/HospitalList';

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  late CommonProvider _commonProvider;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
        title: const Text("Hospital list"),
      ),
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _commonProvider.hospitalList.length,
                itemBuilder: (context, index) {
                  final hospital = _commonProvider.hospitalList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        title: Text("${hospital.hospital}"),
                        trailing: IconButton(
                            onPressed: () {
                              _deleteMethod(hospital.id);
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          openDialogModal(context);
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool?> openDialogModal(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.deepPurple.shade100,
            title: const Text("Hospital"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _textController,
                    style: TextStyle(color: Colors.grey.shade800),
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Hospital',
                    ),
                    cursorColor: Colors.grey.shade800,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyErrMsg;
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  _addToDatabase();
                },
                child: const Text("ADD",
                    style: TextStyle(color: Colors.deepPurple)),
              ),
            ],
          ));

  void _addToDatabase() {
    if (_formKey.currentState!.validate()) {
      final hospitalModel = HospitalModel(
        hospital: _textController.text,
      );
      DatabaseHelper.addHospital(hospitalModel).then((value) {
        setState(() {
          Navigator.pop(context, false);
          _textController.clear();
        });
      }).catchError((onError) {
        showWarningMessage(context, onError);
      });
    }
  }

  void _deleteMethod(String? uid) {
    DatabaseHelper.db.collection("Hospital").doc(uid).delete();
  }
}
