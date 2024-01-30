// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:olshop/api/api_controller.dart';

class ProductUpdatePage extends StatefulWidget {
  final String id; // ID data yang akan diperbarui

  ProductUpdatePage({required this.id});

  @override
  _ProductUpdatePageState createState() => _ProductUpdatePageState();
}

class _ProductUpdatePageState extends State<ProductUpdatePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController promoController = TextEditingController();
  TextEditingController gambarController = TextEditingController();

  var product;

  @override
  void initState() {
    super.initState();
    print('start update : ${widget.id}');
    // Menggunakan FutureBuilder untuk menunggu hasil pemanggilan async function
    // dan mengisi data produk ke dalam input teks
    product = ApiController().getProductById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: product,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Data produk diambil dengan sukses
              List<dynamic> productList = snapshot.data as List<dynamic>;
              Map<String, dynamic> productData =
                  productList[0] as Map<String, dynamic>;

              // Memasukkan data produk ke dalam input teks
              namaController.text = productData['nama'];
              hargaController.text = productData['harga'];
              promoController.text = productData['promo'];
              gambarController.text = productData['gambar'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nama'),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: hargaController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Harga'),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: promoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Promo'),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: gambarController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Gambar'),
                  ),
                  Center(
                      child: Image.network(
                    gambarController.text,
                    height: 200,
                  )),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print('id widget : ${widget.id}');
                        print(
                            'controller ${namaController.text}, ${hargaController.text}');
                        // Panggil fungsi untuk melakukan pembaruan data
                        ApiController().updateDataProduct(
                          widget.id,
                          namaController.text,
                          hargaController.text,
                          promoController.text,
                          gambarController.text,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Data berhasil diupdate!'),
                            duration: Duration(
                                seconds: 2), // Durasi tampilan snackbar
                          ),
                        );

                        Navigator.pop(context, true);
                      },
                      child: Text('Update Data'),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
