// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:olshop/components/account.dart';
import 'package:olshop/components/cart_notifier.dart';
import 'package:olshop/pages/login_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Account account;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (context, cartNotifier, child) {
      this.account = cartNotifier.getActiveAccount();

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profil",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF0C356A),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 4.0,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '@${account.username}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${account.namaLengkap}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${account.alamat}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0C356A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        cartNotifier.removeInvoiceAndProducts();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (builder) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
