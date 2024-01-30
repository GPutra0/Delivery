import 'package:flutter/material.dart';

void clicked(BuildContext context, String message) {
  print(message);
}

AppBar appbar() {
  return AppBar(
    backgroundColor: const Color(0xFF0C356A),
    //leading: Icon(Icons.home),
    title: Text(
      "E-SIDIG",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.message),
        onPressed: () {
          print("Diclik");
        },
      ),
      PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: InkWell(
                onTap: () {
                  clicked(context, "Diclik");
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email), // Perbaikan di sini
                    Text("data"),
                  ],
                ),
              ),
            ),
          ];
        },
        onSelected: (value) {
          // Lakukan sesuatu berdasarkan item yang dipilih jika diperlukan
        },
      ),
    ],
  );
}
