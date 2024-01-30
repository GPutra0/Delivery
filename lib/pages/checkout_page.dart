// ignore_for_file: must_be_immutable, unused_import
import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:olshop/api/api_controller.dart';
import 'package:olshop/components/capitalize_each_word.dart';
import 'package:olshop/components/invoice.dart';
import 'package:olshop/components/kota_model.dart';
import 'package:olshop/components/selected_product.dart';
import 'package:olshop/components/provinsi_model.dart';
import 'package:olshop/pages/invoice_page.dart';
import 'package:olshop/pages/success_page.dart';
import 'package:provider/provider.dart';
import 'package:olshop/components/cart_notifier.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // MAIN VARIABLE
  int provinsiAwalId = 0;
  int provinsiTujuanId = 0;
  int kotaAwalId = 0;
  int kotaTujuanId = 0;
  double overallCheckout = 0;
  double beratBarang = 0;
  double hargaOngkir = 0;
  double hargaCheckout = 0;

  // checkoutproducts
  List<SelectedProduct> getSelectedProducts = [];
  var checkoutProducts;
  var checkoutProductsQty;
  List<InvoiceProduct> invoiceProduct = [];

  // INPUT CONTROLLER
  TextEditingController beratBarangInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future<List<Map<String, dynamic>>> checkoutProducts = getProductsCheckout();
    this.checkoutProducts = checkoutProducts;
  }

  Future<List<Map<String, dynamic>>> getProductsCheckout() async {
    List<Map<String, dynamic>> result = [];

    for (var i = 0; i < getSelectedProducts.length; i++) {
      var productId = getSelectedProducts[i].id;
      var productData = await ApiController().getProductById(productId);

      // Pastikan hasil pemanggilan API mengandung data yang diharapkan
      checkoutProductsQty = getSelectedProducts[i].quantity;
      if (productData.isNotEmpty) {
        result.add(productData[0]);
      }
    }

    return result;
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
    // Menggunakan Consumer untuk mendengarkan perubahan pada CartNotifier
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        // Mendapatkan daftar produk dari CartNotifier
        List<SelectedProduct> selectedProducts = cartNotifier.selectedProducts;

        // Pembaruan daftar produk ketika terjadi perubahan pada CartNotifier
        getSelectedProducts = selectedProducts;

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
            ),
            body: Stack(children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                      child: Text(
                        'Daftar belanjaan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: getProductsCheckout(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error api nih: ${snapshot.error}');
                        } else {
                          // Data sudah berhasil diambil, tampilkan dalam ListView
                          var products = snapshot.data;
                          print('prod length : ${products!.length}');

                          double hargaCheckoutTemp = 0;

                          for (var i = 0; i < products.length; i++) {
                            var hargaPromo =
                                double.parse(products[i]['harga']) -
                                    (double.parse(products[i]['harga']) *
                                        (double.parse(products[i]['promo']) /
                                            100));
                            hargaCheckoutTemp +=
                                hargaPromo * getSelectedProducts[i].quantity;
                            hargaCheckout = hargaCheckoutTemp;
                            print('harga chekcout : $hargaCheckout');
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: selectedProducts.length,
                            itemBuilder: (context, index) {
                              var product = products[index];
                              var qty = getSelectedProducts[index].quantity;

                              if (this.invoiceProduct.length <
                                  selectedProducts.length) {
                                invoiceProduct.add(new InvoiceProduct(
                                    nameProduct: '${product['nama']}',
                                    qtyProduct: qty.toString(),
                                    priceProduct: (double.parse(
                                                product['harga']) -
                                            (double.parse(product['harga']) *
                                                (double.parse(
                                                        product['promo']) /
                                                    100)))
                                        .toString()));

                                print(
                                    'invoicePro : ${invoiceProduct[index].nameProduct}');
                                print(
                                    'invoiceqty : ${invoiceProduct[index].priceProduct}');
                              }
                              Uint8List imageBytes =
                                  decodeBase64(product['gambar']);
                              // Tampilkan data produk dan jumlahnya di sini
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: Card(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 120,
                                          width: 120,
                                          child: Image.memory(
                                            imageBytes,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Rp ${product['harga']}',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              Text(
                                                'Rp ${double.parse(product['harga']) - (double.parse(product['harga']) * (double.parse(product['promo']) / 100))}',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.amber.shade700,
                                                ),
                                              ),
                                              Text(
                                                '${capitalizeEachWord(product['nama'])}',
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
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Text(
                                          'x ${qty}',
                                          style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(
                        thickness: 6.0,
                        color: Colors.grey.shade200,
                      ),
                    ),

                    // Group 1
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alamat asal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            // DROPDOWN PROVINSI
                            DropdownSearch<Provinsi>(
                              popupProps: PopupProps.menu(showSearchBox: true),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Pilih provinsi awal",
                                  hintText: "Masukkan provinsi awal",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                try {
                                  List<dynamic> response =
                                      await ApiController().getProvinces();
                                  var models = Provinsi.fromJsonList(response);
                                  return models;
                                } catch (err) {
                                  print(err);
                                  return List<Provinsi>.empty();
                                }
                              },
                              onChanged: (prov) {
                                if (prov != null) {
                                  provinsiAwalId = int.parse(prov.provinceid!);
                                } else {
                                  print("Provinsi null");
                                }
                              },
                              itemAsString: (item) => item.province!,
                            ),
                            SizedBox(height: 10),
                            // DROPDOWN CITY
                            DropdownSearch<Kota>(
                              popupProps: PopupProps.menu(showSearchBox: true),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Pilih kota awal",
                                  hintText: "Masukkan kota awal",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                try {
                                  List<dynamic> response = await ApiController()
                                      .getCities(provinsiAwalId.toString());
                                  var models = Kota.fromJsonList(response);
                                  return models;
                                } catch (err) {
                                  print(err);
                                  return List<Kota>.empty();
                                }
                              },
                              onChanged: (city) {
                                if (city != null) {
                                  kotaAwalId = int.parse(city.cityId!);
                                } else {
                                  print("Kota null");
                                }
                              },
                              itemAsString: (item) => item.cityName!,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Divider untuk Group 1
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(
                        thickness: 6.0,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    // Group 2
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alamat tujuan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            // DROPDOWN PROVINSI
                            DropdownSearch<Provinsi>(
                              popupProps: PopupProps.menu(showSearchBox: true),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "Pilih provinsi tujuan",
                                    hintText: "Masukkan provinsi tujuan",
                                    border: OutlineInputBorder()),
                              ),
                              asyncItems: (String filter) async {
                                try {
                                  List<dynamic> response =
                                      await ApiController().getProvinces();
                                  var models = Provinsi.fromJsonList(response);
                                  return models;
                                } catch (err) {
                                  print(err);
                                  return List<Provinsi>.empty();
                                }
                              },
                              onChanged: (prov) {
                                if (prov != null) {
                                  provinsiTujuanId =
                                      int.parse(prov.provinceid!);
                                } else {
                                  print("Provinsi null");
                                }
                              },
                              itemAsString: (item) => item.province!,
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            // DROPDOWN CITY
                            DropdownSearch<Kota>(
                              popupProps: PopupProps.menu(showSearchBox: true),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "Pilih kota tujuan",
                                    hintText: "Masukkan kota tujuan",
                                    border: OutlineInputBorder()),
                              ),
                              asyncItems: (String filter) async {
                                try {
                                  List<dynamic> response = await ApiController()
                                      .getCities(provinsiTujuanId.toString());
                                  var models = Kota.fromJsonList(response);
                                  return models;
                                } catch (err) {
                                  print(err);
                                  return List<Kota>.empty();
                                }
                              },
                              onChanged: (city) {
                                if (city != null) {
                                  kotaTujuanId = int.parse(city.cityId!);
                                } else {
                                  print("Kota null");
                                }
                              },
                              itemAsString: (item) => item.cityName!,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Divider untuk Group 2
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(
                        thickness: 6.0,
                        color: Colors.grey.shade200,
                      ),
                    ),

                    // Group 3
                    Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Berat barang (kg)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: beratBarangInput,
                              decoration: InputDecoration(
                                  hintText: 'Masukkan berat (cth: 1.5)',
                                  border: OutlineInputBorder()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Divider untuk Group 3
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(
                        thickness: 6.0,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
              ),

              // Stack for the additional widgets
              Positioned(
                bottom: 0,
                left: 0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    // Group 4
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  width: 4, color: Colors.grey.shade300))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Total pesanan ${selectedProducts.length} produk'),
                                    Text('Rp$hargaCheckout'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Berat barang ${beratBarang / 1000} (kg)'),
                                    hargaOngkir == 1
                                        ? Text('Calculating...')
                                        : Text('Rp$hargaOngkir')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total pembayaran',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.amber.shade800),
                                    ),
                                    hargaOngkir == 1
                                        ? Text(
                                            'Calculating...',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.amber.shade800),
                                          )
                                        : Text(
                                            'Rp${overallCheckout}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.amber.shade800),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // GROUP 5
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          hargaOngkir = 1;
                                          if (beratBarangInput.text.isEmpty) {
                                            beratBarang = 0;
                                          } else {
                                            beratBarang = double.parse(
                                                    beratBarangInput.text) *
                                                1000;
                                          }
                                        });

                                        if (provinsiAwalId == 0 ||
                                            provinsiTujuanId == 0 ||
                                            kotaAwalId == 0 ||
                                            kotaTujuanId == 0 ||
                                            beratBarang == 0) {
                                          hargaOngkir = 0;

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Alert!"),
                                                content: Text(
                                                    "Pastikan semua data telah terisi."),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          var dataOngkir = await ApiController()
                                              .getShippingCost(
                                                  kotaAwalId.toString(),
                                                  kotaTujuanId.toString(),
                                                  beratBarang.toString());

                                          setState(() {
                                            hargaOngkir = 1;

                                            hargaOngkir = dataOngkir[0]['costs']
                                                    [0]['cost'][0]['value']
                                                .toDouble();

                                            overallCheckout =
                                                hargaOngkir + hargaCheckout;

                                            // hargaCheckout += hargaCheckout;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                      child: hargaOngkir == 1
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text('Cek Ongkir'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          hargaOngkir = 1;
                                          if (beratBarangInput.text.isEmpty) {
                                            beratBarang = 0;
                                          } else {
                                            beratBarang = double.parse(
                                                    beratBarangInput.text) *
                                                1000;
                                          }
                                        });

                                        if (provinsiAwalId == 0 ||
                                            provinsiTujuanId == 0 ||
                                            kotaAwalId == 0 ||
                                            kotaTujuanId == 0 ||
                                            beratBarang == 0) {
                                          hargaOngkir = 0;

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Alert!"),
                                                content: Text(
                                                    "Pastikan semua data telah terisi."),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          var dataOngkir = await ApiController()
                                              .getShippingCost(
                                                  kotaAwalId.toString(),
                                                  kotaTujuanId.toString(),
                                                  beratBarang.toString());

                                          setState(() {
                                            hargaOngkir = 1;

                                            hargaOngkir = dataOngkir[0]['costs']
                                                    [0]['cost'][0]['value']
                                                .toDouble();

                                            overallCheckout =
                                                hargaOngkir + hargaCheckout;
                                          });

                                          var invoiceDate =
                                              DateFormat('dd-MM-yyyy HH:mm')
                                                  .format(DateTime.now());
                                          var totalProductPrice = hargaCheckout;
                                          var totalCostPrice = hargaOngkir;
                                          var invoiceCheckout = overallCheckout;

                                          Invoice invoice = new Invoice(
                                              invoiceDate:
                                                  invoiceDate.toString(),
                                              totalProductPrice:
                                                  totalProductPrice.toString(),
                                              totalCostPrice:
                                                  totalCostPrice.toString(),
                                              overallCheckout:
                                                  invoiceCheckout.toString());

                                          invoice.products =
                                              this.invoiceProduct;

                                          Provider.of<CartNotifier>(context,
                                                  listen: false)
                                              .addInvoice(invoice);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      SuccessPage()));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                      child: Text('Checkout'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]));
      },
    );
  }
}
