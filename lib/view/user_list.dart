import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/model/user_model.dart';
import 'package:health_monitoring_dashboard/provider/common_provider.dart';
import 'package:health_monitoring_dashboard/utils/constant.dart';
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
                        leading: user.gender == 'Male'
                            ? Image.asset('assets/man.png', height: 50)
                            : Image.asset('assets/woman.png', height: 50),
                        title: Text("${user.username}"),
                        subtitle: Text("${user.email}"),
                        trailing: IconButton(
                            onPressed: () {
                              _deleteMethod(user.uid);
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent)),
                        onLongPress: () {
                          _getUserProfile(user);
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
    deleteDialog(context, "Do you want to delete this user's account?", uid!,
        "userProfileInfo");
  }

  void _getUserProfile(UserModel user) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Column(
                children: [
                  user.gender == "Male"
                      ? Image.asset('assets/man.png', height: 150)
                      : Image.asset('assets/woman.png', height: 150),
                  const SizedBox(height: 10),
                  Text("${user.username}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade900)),
                ],
              ),
              content: Column(
                children: [
                  Text("${user.email}",
                      style: TextStyle(color: Colors.grey.shade900)),
                  Text("${user.gender}",
                      style: TextStyle(color: Colors.grey.shade900)),
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
