import 'package:flutter/material.dart';
import 'package:olshop/api/api_controller.dart';

class ProductInsertPage extends StatefulWidget {
  ProductInsertPage({Key? key}) : super(key: key);

  @override
  _ProductInsertPageState createState() => _ProductInsertPageState();
}

class _ProductInsertPageState extends State<ProductInsertPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController promoController = TextEditingController();
  TextEditingController gambarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C356A),
        title: Text('Insert Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama',
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: hargaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Harga',
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: promoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Promo',
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: gambarController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Link gambar',
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Panggil fungsi untuk menyimpan data
                          Navigator.pop(context, true);
                        },
                        child: Text('Batal'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Panggil fungsi untuk menyimpan data
                          ApiController().insertDataProduct(
                            namaController.text,
                            hargaController.text,
                            promoController.text,
                            gambarController.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Data berhasil disimpan!'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Clear text controllers
                          namaController.clear();
                          hargaController.clear();
                          promoController.clear();
                          gambarController.clear();
                        },
                        child: Text('Simpan Produk'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
