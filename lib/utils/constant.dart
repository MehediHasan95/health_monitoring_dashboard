import 'package:flutter/material.dart';
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
