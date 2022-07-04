import 'package:api_firebase_practice/firebase_auth_service/firebase_auth_setvice.dart';
import 'package:api_firebase_practice/view/nots_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Valid password";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "password",
                    label: Text("password"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            FirebaseAuthService.loginUser(
                                    email: _email.text,
                                    password: _password.text)
                                .then(
                              (user) {
                                if (user != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NotesPage(),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Login successfully"),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Login Faild"),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                        child: Text("Login"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
