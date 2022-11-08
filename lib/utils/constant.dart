import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/database/database_helper.dart';
import 'package:lottie/lottie.dart';

const String emptyEmailErrMsg = 'Enter your email Id';
const String emptyPasswordErrMsg = 'Enter your password';
const String emptyErrMsg = "This field can't be left blank";

// Show login warning
Future<bool?> showWarningMessage(BuildContext context, String errMsg) async =>
    showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: LottieBuilder.asset('assets/error.json', height: 100),
              content: Text(
                errMsg,
                style: const TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("CLOSE",
                      style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ));

Future<bool?> deleteDialog(BuildContext context, String errMsg, String uid,
        String collection) async =>
    showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
            title: LottieBuilder.asset('assets/delete.json', height: 120),
            content: Text(
              errMsg,
              style: TextStyle(color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("NO", style: TextStyle(color: Colors.green)),
              ),
              MaterialButton(
                onPressed: () => {
                  Navigator.pop(context, true),
                  DatabaseHelper.db.collection(collection).doc(uid).delete()
                },
                child: const Text("YES",
                    style: TextStyle(color: Colors.redAccent)),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center));
