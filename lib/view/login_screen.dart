import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_dashboard/auth/auth_service.dart';
import 'package:health_monitoring_dashboard/provider/admin_provider.dart';
import 'package:health_monitoring_dashboard/utils/constant.dart';
import 'package:health_monitoring_dashboard/view/dashboard.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeNames = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String _errMsg = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          color: Colors.grey.shade300,
          child: Center(
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shrinkWrap: true,
                  children: [
                    Text(
                      'ADMIN SIGN IN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.grey.shade800),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'This app only for admin',
                      style: TextStyle(color: Colors.grey.shade800),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      controller: _emailController,
                      style: TextStyle(color: Colors.grey.shade800),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey.shade800,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email ID',
                      ),
                      cursorColor: Colors.grey.shade800,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyEmailErrMsg;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: _obscureText,
                      controller: _passwordController,
                      style: TextStyle(color: Colors.grey.shade800),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey.shade800,
                        ),
                        suffixIcon: IconButton(
                          color: Colors.grey.shade800,
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                      ),
                      cursorColor: Colors.grey.shade800,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyPasswordErrMsg;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: _signInAdmin,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(13.0),
                        backgroundColor: Colors.deepPurple,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      child: const Text('Sign In'),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Future<void> _signInAdmin() async {
    if (_formKey.currentState!.validate()) {
      if (_formKey.currentState!.validate()) {
        try {
          final uid = await AuthService.signInAdmin(
              _emailController.text.toLowerCase(), _passwordController.text);

          if (uid != null) {
            final isAdmin =
                // ignore: use_build_context_synchronously
                await Provider.of<AdminProvider>(context, listen: false)
                    .isUser(AuthService.currentUser!.email!);
            if (isAdmin) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Dashboard.routeNames, (Route<dynamic> route) => false);
            } else {
              setState(() {
                showWarningMessage(context, "Sorry, you are not an admin");
                AuthService.signOut();
              });
            }
          }
        } on FirebaseAuthException catch (error) {
          setState(() {
            _errMsg = error.message!;
            showWarningMessage(context, _errMsg);
          });
        }
      }
    }
  }
}
