import 'package:chat_app/dialuge_utils.dart';
import 'package:chat_app/ui/registeration/register_screen.dart';
import 'package:chat_app/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String RouteName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/background_pattern.png',
                ))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('Login '),
          ),
          body: Container(
            padding: EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .25,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter Email Address';
                        }
                        if (!ValidationUtils.IsVaildEmail(text)) {
                          return 'please enter vaild Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Email Address'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter Password';
                        }
                        if (text.length < 6) {
                          return 'password should be at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: securedPassword,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: InkWell(
                              onTap: () {
                                securedPassword = !securedPassword;
                                setState(() {});
                              },
                              child: Icon(securedPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        SignIn();
                      },
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(12))),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.RouteName);
                        },
                        child: Text('or create Account'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  var authService = FirebaseAuth.instance;

  void SignIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    showLoading(context, 'Loading');
    authService
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((userCredential) {
      hideLoading(context);
      showMessage(context, (userCredential.user?.uid) ?? '');
    }).onError((error, stackTrace) {
      hideLoading(context);
      showMessage(context, error.toString());
    });
  }
}
