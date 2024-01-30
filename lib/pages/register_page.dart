import 'package:flutter/material.dart';

import 'package:olshop/components/account.dart';
import 'package:olshop/components/cart_notifier.dart';

import 'package:olshop/pages/login_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var accounts;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (context, cartNotifier, child) {
      List<Account> getAccounts = cartNotifier.accounts;
      this.accounts = getAccounts;

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/kelontong.png',
                      height: 300,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Sign Up',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama Tidak Boleh Kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      hintText: 'Ex: Aditya Putranto',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Color(0xFF0C356A), width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Alamat Tidak Boleh Kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      hintText: 'Ex: Surabaya',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Color(0xFF0C356A), width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username Tidak Boleh Kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                      hintText: 'Ex: adityapza',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Color(0xFF0C356A), width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password Tidak Boleh Kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Ex: Minimal 8 karakter',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Color(0xFF0C356A), width: 2.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 100, right: 100, top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // Buat objek Account baru berdasarkan input pengguna
                          Account newAccount = Account(
                            namaLengkap: nameController.text,
                            alamat: addressController.text,
                            username: usernameController.text,
                            password: passwordController.text,
                          );

                          // Tambahkan akun baru ke list di CartNotifier
                          cartNotifier.registerAccount(newAccount);

                          // Navigasi ke halaman login
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (builder) {
                            return LoginPage();
                          }));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          // minimumSize: const Size(100, 50),
                          ),
                      child: Container(
                        child: Center(
                          child: Text("Sign Up"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 130),
                  child: Row(
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (builder) {
                            return LoginPage();
                          }));
                        },
                        child: Text(
                          "Sign In Now",
                          style: TextStyle(
                            color: Color(0xFF0C356A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
