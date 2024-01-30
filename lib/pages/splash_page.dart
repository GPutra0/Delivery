import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:olshop/pages/login_page.dart';
import 'package:olshop/components/bottom_navigation_bar.dart';
import 'package:olshop/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (build) {
              return LoginPage();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 251, 248, 248),
        //backgroundColor: Color(0xFF0C356A),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/kelontong.png',
              height: 300,
            ),
          ]),
        ),
      ),
    );
  }
}
