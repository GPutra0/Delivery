// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:olshop/components/capitalize_each_word.dart';
import 'package:olshop/components/cart_notifier.dart';
import 'package:olshop/components/selected_product.dart';
import 'package:olshop/pages/checkout_page.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  final String nama;
  final String harga;
  final String promo;
  final String gambar;

  List<SelectedProduct> selectedProducts = [];

  ProductDetailPage({
    Key? key,
    required this.id,
    required this.nama,
    required this.harga,
    required this.promo,
    required this.gambar,
    // required this.selectedProducts
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState(
      id: id,
      nama: nama,
      harga: harga,
      promo: promo,
      gambar: gambar,
      selectedProducts: selectedProducts);
}

class _ProductDetailState extends State<ProductDetailPage> {
  String id;
  String nama;
  String harga;
  String promo;
  String gambar;

  bool isBookmark = false; // Status ikon favorit

  _ProductDetailState(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.promo,
      required this.gambar,
      required this.selectedProducts});

  int quantity = 1;
  String deskripsi = loremIpsum(words: 30);
  List<SelectedProduct> selectedProducts = [];

  // List<SelectedProduct> selectedProducts = [] ;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products Detail",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // HERO IMAGE
            Container(
              // color: Colors.grey.shade100,
              width: double.infinity,
              height: 400,
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'produk_${this.id}',
                child: Image.memory(
                  decodeBase64(gambar),
                  semanticLabel: 'Product Image',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // NAME AND PRICE
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${capitalizeEachWord(nama)}',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(
                              'Rp$harga',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.shade400,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Rp${int.parse(harga) - (int.parse(harga) * 0.1)}',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.orange),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$promo%',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                          Text(
                            'OFF',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
            ),

            // DESCRIPTION
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DESCRIPTION',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${deskripsi},',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // TOTAL PRODUCT
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '$quantity',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBookmark = !isBookmark;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors
                                    .grey), // Warna border sesuai kebutuhan
                          ),
                          child: Icon(
                            Icons.bookmark,
                            color: isBookmark ? Colors.pink : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // Kirim data produk yang ditambahkan ke keranjang ke CartNotifier
                            Provider.of<CartNotifier>(context, listen: false)
                                .addProduct(
                              SelectedProduct(
                                id: id,
                                quantity: quantity,
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Berhasil menambah ke keranjang!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
