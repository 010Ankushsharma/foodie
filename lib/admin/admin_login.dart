import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/homeadmin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
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
                colors: [Color.fromARGB(225, 53, 51, 51), Colors.black],
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
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "let's start with \ Admin Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: TextFormField(
                                controller: usernameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Username";
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "username",
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(225, 160, 160, 147)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Password";
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(225, 160, 160, 147)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: (){
                              LoginAdmin();

                            // AdminLogin();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['password'] ! == usernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your id is not correct",
                style: TextStyle(fontSize: 18),
              )));
        }
       else if (result.data()['username'] ! == passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your password is not correct",
                style: TextStyle(fontSize: 18),
              )));
        }
        else{
          Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
