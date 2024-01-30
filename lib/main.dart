// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olshop/components/bottom_navigation_bar.dart';
import 'package:olshop/components/cart_notifier.dart';
import 'package:olshop/pages/checkout_page.dart';
import 'package:olshop/pages/invoice_page.dart';
import 'package:olshop/pages/login_page.dart';
import 'package:olshop/pages/product_edit_page.dart';
import 'package:olshop/pages/product_insert_page.dart';
import 'package:olshop/pages/product_page.dart';
import 'package:olshop/pages/profile_page.dart';
import 'package:olshop/pages/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CartNotifier(), child: MainApp()));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
      ),
      home: SplashPage(),
    );
  }
}
