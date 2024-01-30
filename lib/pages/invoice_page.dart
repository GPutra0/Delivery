// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:olshop/components/account.dart';
import 'package:olshop/components/bottom_navigation_bar.dart';
import 'package:olshop/components/capitalize_each_word.dart';
import 'package:olshop/components/cart_notifier.dart';
import 'package:olshop/components/invoice.dart';
import 'package:provider/provider.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late Invoice invoice;
  late Account account;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (context, cartNotifier, child) {
      Invoice invoiceConsumer = cartNotifier.invoice;
      this.account = cartNotifier.getActiveAccount();

      this.invoice = invoiceConsumer;

      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Expanded(
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      '  Invoice',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 19, 17, 17),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color:
                                              Color.fromARGB(255, 32, 151, 64),
                                          size: 20,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '   Payment Successful',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 19, 17, 17),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Date: ${invoice.invoiceDate}',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 19, 17, 17),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Invoice Number: ${invoice.invoiceNumber}',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 19, 17, 17),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                'Buyer : ${capitalizeEachWord(account.namaLengkap)}',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 19, 17, 17),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: const Color.fromARGB(
                                          255, 119, 119, 119),
                                      thickness: 1,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  invoice.products.length,
                                              itemBuilder: (context, index) {
                                                var data =
                                                    invoice.products[index];
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              capitalizeEachWord(
                                                                  data.nameProduct),
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Qty : ${data.qtyProduct}',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Rp. ${data.priceProduct}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: const Color.fromARGB(
                                          255, 119, 119, 119),
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Total Produk ',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 19, 17, 17),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Total Ongkir',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 19, 17, 17),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Total Pembayaran',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 19, 17, 17),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Rp. ${invoice.totalProductPrice}',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 19, 17, 17),
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Rp. ${invoice.totalCostPrice}',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 19, 17, 17),
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                  'Rp. ${invoice.overallCheckout}',
                                                  style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                          ],
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      width: 650,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF0C356A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          cartNotifier.removeInvoiceAndProducts();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => BottomNavigationbar()));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Back to Product",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
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
