import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});
  static const String routeNames = '/UserList';

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
        title: const Text("User list"),
      ),
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _commonProvider.userList.length,
                itemBuilder: (context, index) {
                  final user = _commonProvider.userList[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        title: Text("${user.username}"),
                        subtitle: Text("${user.email}"),
                        trailing: IconButton(
                            onPressed: () {
                              _deleteMethod(user.uid);
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
    );
  }

  void _deleteMethod(String? uid) {
    DatabaseHelper.db.collection("userProfileInfo").doc(uid).delete();
  }
}
