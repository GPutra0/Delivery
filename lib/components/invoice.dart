import 'dart:math';

class Invoice {
  String invoiceDate;
  String invoiceNumber = '';
  String totalProductPrice;
  String totalCostPrice;
  String overallCheckout;
  List<InvoiceProduct> products = [];

  Invoice({
    required this.invoiceDate,
    required this.totalProductPrice,
    required this.totalCostPrice,
    required this.overallCheckout,
  }) : invoiceNumber = generateRandomInvoiceNumber();

  void addProducts(InvoiceProduct invoiceProduct) {
    this.products.add(invoiceProduct);
  }

  static String generateRandomInvoiceNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(999999); // Ubah batas sesuai kebutuhan

    String invoiceNumber = 'INV-${randomNumber.toString().padLeft(6, '0')}';
    return invoiceNumber;
  }
}

class InvoiceProduct {
  final String nameProduct;
  final String qtyProduct;
  final String priceProduct;

  InvoiceProduct({
    required this.nameProduct,
    required this.qtyProduct,
    required this.priceProduct
  });
}
