import 'package:printer_test/printer/domain/entities/receipt.dart';

class ReceiptModel extends Receipt {
  const ReceiptModel({required super.name});

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(name: 'name');
  }
}
