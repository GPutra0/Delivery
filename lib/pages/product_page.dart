import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olshop/api/api_controller.dart';
import 'package:olshop/components/capitalize_each_word.dart';
import 'package:olshop/pages/checkout_page.dart';
import 'package:olshop/pages/product_detail.dart';
import '../../Components/PointCard.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductPage> {
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
    var beritaTerkini = [
      "assets/images/Banner.png",
    ];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                PoinCard(size, 'Hi, Yukya', 'Kode Users : KP-120200022',
                    'Selamat Datang', '1,6 Kg', '23.000', Container()),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: Container(
                //     height: 230,
                //     decoration: BoxDecoration(
                //       color: const Color(0xFF0C356A),
                //       borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(20.0),
                //         bottomRight: Radius.circular(20.0),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Special Offers",
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 165,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                    ),
                    items: beritaTerkini.map((title) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(title),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Products",
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FutureBuilder<List<dynamic>>(
                    future: _data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String gambar_produk = snapshot.data![index]
                                        ['gambar'] !=
                                    null
                                ? snapshot.data![index]['gambar']
                                : 'https://static.vecteezy.com/system/resources/previews/012/961/167/original/online-product-search-flat-design-icon-illustration-vector.jpg';
                            String nama_produk = snapshot.data![index]['nama'];
                            String harga_produk =
                                snapshot.data![index]['harga'];
                            String promo_produk =
                                snapshot.data![index]['promo'];
                            String id_produk = snapshot.data![index]['id'];

                            return Card(
                              elevation: 2,
                              child: Builder(
                                builder: (context) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ProductDetailPage(
                                        id: id_produk,
                                        nama: nama_produk,
                                        harga: harga_produk,
                                        promo: promo_produk,
                                        gambar: gambar_produk,
                                      );
                                    }));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Hero(
                                        tag: 'produk_${id_produk}',
                                        child: Image.memory(
                                          decodeBase64(gambar_produk),
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            print(
                                                'Error decoding image: $error');
                                            return Center(
                                              child: Icon(Icons.error),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${(nama_produk)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Rp ${harga_produk}',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Rp ${double.parse(harga_produk) - (double.parse(harga_produk) * (double.parse(promo_produk) / 100))}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
