import 'package:flutter/material.dart';
import 'package:food_app/pages/bottomnav.dart';
import 'package:food_app/pages/login/LoginController/googleController.dart';
import 'package:food_app/pages/login/LoginController/logincontroller.dart';
import 'package:food_app/pages/login/signup.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  GoogleController googleController = Get.put(GoogleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
                padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(225, 53, 51, 51),
                      Colors.black
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      110.0,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: MediaQuery.of(context).size.height / 6,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Text(
                        "Let's start with Admin!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: loginController.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Username';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username or Email',
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: loginController.password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  loginController.onLogin();
                                  Get.to(BottomNav());
                                  //Get.to(HomePage());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black.withOpacity(0.15),
                                  minimumSize: Size(260, 50),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  Get.to(Signup());
                                },
                                child: Text('Create an account? Sign Up '),
                              ),
                              SizedBox(height: 7),
                              Text('or Login with'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await googleController.signInWithGoogle();
                                      Get.to(BottomNav());
                                    //  Get.to(HomePage());
                                    },
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                        'assets/images/google.jpg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     // Handle Facebook icon tap
                                  //   },
                                  //   child: CircleAvatar(
                                  //     radius: 24,
                                  //     backgroundColor: Colors.transparent,
                                  //     backgroundImage: AssetImage(
                                  //       'assets/images/facebookdp.png',
                                  //     ),
                                  //   ),
                                 // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
