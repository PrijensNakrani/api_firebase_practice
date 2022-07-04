import 'package:api_firebase_practice/firebase_auth_service/firebase_auth_setvice.dart';
import 'package:api_firebase_practice/view/nots_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? confirm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Valid Email";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Email",
                    label: Text("Email"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _password,
                  validator: (value) {
                    confirm = value;
                    if (value!.isEmpty) {
                      return "Enter Valid password";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "password",
                    label: Text("password"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != confirm) {
                      return "Enter Valid password";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Confirm password",
                    label: Text("confirm password"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseAuthService.registerUser(
                              email: _email.text, password: _password.text)
                          .then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotesPage(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Sign Up Succsesfully"),
                          ),
                        );
                      });
                    }
                  },
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
