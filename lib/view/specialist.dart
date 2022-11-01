import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';
import 'package:health_monitoring_dashboard/model/specialist_model.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
import 'package:health_monitoring_dashboard/utils/constant.dart';
import 'package:provider/provider.dart';

class Specialist extends StatefulWidget {
  const Specialist({super.key});
  static const String routeNames = '/Specialist';

  @override
  State<Specialist> createState() => _SpecialistState();
}

class _SpecialistState extends State<Specialist> {
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
        title: const Text("Specialist"),
      ),
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _commonProvider.hospital.length,
                itemBuilder: (context, index) {
                  final specialist = _commonProvider.hospital[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        title: Text("${specialist.specialist}"),
                        trailing: IconButton(
                            onPressed: () {
                              _deleteMethod(specialist.id);
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent)),
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
            title: const Text("Specialist"),
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
                      hintText: 'Specialist',
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
      final specialistModel = SpecialistModel(
        specialist: _textController.text,
      );
      DatabaseHelper.addSpecialist(specialistModel).then((value) {
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
    deleteDialog(
        context, "Do you want to delete this specialist", uid!, "Specialist");
  }
}
