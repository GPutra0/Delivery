// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:olshop/components/bottom_navigation_bar.dart';
import 'package:olshop/pages/invoice_page.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'SUCCESS!',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Image(
              image: AssetImage('assets/images/invoice.png'),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: TextButton.styleFrom(),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => InvoicePage()));
                },
                child: Text(
                  'Check Invoice',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => BottomNavigationbar()));
                },
                child: Text(
                  'Back to Product',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
