import 'package:flutter/material.dart';
import 'package:food_app/admin/admin_login.dart';
import 'package:food_app/pages/assets.dart';
import 'package:food_app/pages/bottomnav.dart';
import 'package:food_app/pages/login/loginPage.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/login.png'),
            //const HotelynIcon(),
            const SizedBox(height: 30),
            const Text(
              'Welcome to Foodie',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'If you are new here please create your account first before book the food.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 120),
            ElevatedButton(
                onPressed: () {
                  Get.to(LoginPage());
                },
                child: Text('Create Account / Login')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  Get.to(AdminLogin());
                },
                child: Column(
                  children: [
                    Text("Admin login "),
                    Text("only Admin can login"),
                  ],
                )),
            const SizedBox(height: 16),
            TextButton(
                onPressed: () {
                  Get.to(BottomNav());
                 // Get.to(HomePage());
                },
                child: Text('Go To HomePage'))
          ],
        ),
      ),
    );
  }
}
