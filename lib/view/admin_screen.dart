import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/provider/admin_provider.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  static const String routeNames = "/AdminScreen";

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late AdminProvider _adminProvider;

  @override
  void didChangeDependencies() {
    _adminProvider = Provider.of<AdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Admin"),
      ),
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _adminProvider.admin.length,
                itemBuilder: (context, index) {
                  final admin = _adminProvider.admin[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        title: Text("${admin.name}"),
                        subtitle: Text("${admin.email}"),
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
}
