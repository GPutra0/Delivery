// ignore_for_file: must_be_immutable, unused_import, unused_field

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olshop/api/api_controller.dart';
import 'package:olshop/components/capitalize_each_word.dart';
import 'package:olshop/pages/checkout_page.dart';
import 'package:olshop/pages/product_detail.dart';
import 'package:olshop/pages/product_insert_page.dart';
import 'package:olshop/pages/product_update_page.dart';

class ProductEditPage extends StatefulWidget {
  ProductEditPage({Key? key}) : super(key: key);

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  Future<List<dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _data = ApiController().getDatas();
  }

  Uint8List decodeBase64(String base64String) {
    try {
      String dataWithoutPrefix = base64String.split(',').last;
      return base64.decode(dataWithoutPrefix);
    } catch (e) {
      print('Error decoding base64: $e');
      return Uint8List(
          0); // Mengembalikan Uint8List kosong atau menangani kesalahan sesuai kebutuhan
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building ProductPage');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Management",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF0C356A),
        // centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => CheckoutPage()));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiController().getDatas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String gambar_produk = snapshot.data![index]['gambar'] != null
                    ? snapshot.data![index]['gambar']
                    : 'https://static.vecteezy.com/system/resources/previews/012/961/167/original/online-product-search-flat-design-icon-illustration-vector.jpg';
                String nama_produk = snapshot.data![index]['nama'];
                String harga_produk = snapshot.data![index]['harga'];
                String promo_produk = snapshot.data![index]['promo'];
                String id_produk = snapshot.data![index]['id'];

                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image.memory(
                            decodeBase64(gambar_produk),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp $harga_produk',
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              Text(
                                'Rp ${double.parse(harga_produk) - (double.parse(harga_produk) * (double.parse(promo_produk) / 100))}',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.amber.shade700,
                                ),
                              ),
                              Text(
                                '${capitalizeEachWord(nama_produk)}',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductUpdatePage(id: id_produk)),
                                  );

                                  if (result != null &&
                                      result is bool &&
                                      result) {
                                    setState(() {
                                      _data = ApiController().getDatas();
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.green.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Aksi ketika tombol ditekan
                                  ApiController().deleteDataProduct(id_produk);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Data berhasil dihapus!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );

                                  setState(() {
                                    _data = ApiController().getDatas();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.red.shade500,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            Icon(
              Icons.add,
              size: 16,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Tambah produk',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
            )
          ],
        ),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductInsertPage()),
          );

          if (result != null && result is bool && result) {
            setState(() {
              _data = ApiController().getDatas();
            });
          }
        },
      ),
    );
  }
}
