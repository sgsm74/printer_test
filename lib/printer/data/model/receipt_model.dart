import 'package:printer_test/printer/data/model/order_item_model.dart';
import 'package:printer_test/printer/domain/entities/receipt.dart';

class ReceiptModel extends Receipt {
  const ReceiptModel({
    required super.vendorName,
    required super.vendorAddress,
    required super.date,
    required super.time,
    required super.number,
    required super.totalDiscount,
    required super.totalAmount,
    required super.totalPayableAmount,
    required super.items,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> items = [];
    for (var item in json['order_items']) {
      items.add(OrderItemModel.fromJson(item));
    }
    return ReceiptModel(
      vendorName: json['vendor_name'],
      vendorAddress: json['vendor_address'],
      date: json['date'],
      time: json['time'],
      number: json['number'],
      totalDiscount: json['total_discount'],
      totalAmount: json['total_amount'],
      totalPayableAmount: json['total_payable_amount'],
      items: items,
    );
  }
}
