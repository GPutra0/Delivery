import 'package:flutter/material.dart';
import 'package:olshop/components/account.dart';
import 'package:olshop/components/invoice.dart';
import 'package:olshop/components/selected_product.dart';

class CartNotifier extends ChangeNotifier {
  List<SelectedProduct> selectedProducts = [];
  List<Account> accounts = [];
  String activeAccount = '';
  late Invoice invoice;

  void addProduct(SelectedProduct product) {
    selectedProducts.add(product);
    notifyListeners();
  }

  void registerAccount(Account account) {
    accounts.add(account);
    notifyListeners();
  }

  void addInvoice(Invoice invoiceParam) {
    invoice = invoiceParam;
    notifyListeners();
  }

  bool validateLogin(String username, String password) {
    for (var account in accounts) {
      if (account.username == username && account.password == password) {
        this.activeAccount = account.username;
        return true;
      }
    }
    return false;
  }

  Account getActiveAccount() {
    for (var account in this.accounts) {
      if (account.username == this.activeAccount) {
        return account;
      }
    }
    throw Exception("Active account not found!");
  }

  void removeInvoiceAndProducts() {
    selectedProducts.clear();
    invoice = Invoice(
      invoiceDate: '',
      totalProductPrice: '',
      totalCostPrice: '',
      overallCheckout: '',
    );
    notifyListeners();
  }
}
