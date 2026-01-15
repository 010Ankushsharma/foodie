import 'package:flutter/material.dart';
import 'package:food_app/pages/login/LoginController/signupController.dart';
import 'package:food_app/pages/login/loginPage.dart';
import 'package:get/get.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  SignupController signupController = Get.put(SignupController());

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
                        "New Registration",
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
                                controller: signupController.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.person),
                                  labelText: 'Name',
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: signupController.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.email_rounded),
                                  labelText: 'Email',
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: signupController.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Phone';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.phone),
                                  labelText: 'Phone',
                                ),
                              ),

                              SizedBox(height: 10),
                              TextFormField(
                                controller: signupController.password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.password_rounded),
                                  labelText: 'Password',
                                ),
                              ),
                              SizedBox(height: 20,),
                              ElevatedButton(
                                onPressed: () {
                                  signupController.onSignUp();
                                  Get.to(LoginPage());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black.withOpacity(0.15),
                                  minimumSize: Size(260, 50),
                                ),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }
}
