import 'package:printer_test/printer/domain/entities/item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.name,
    required super.quantity,
    required super.discount,
    required super.totalAmount,
    required super.unitPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      name: json['name'],
      quantity: json['quantity'],
      discount: json['discount'],
      totalAmount: json['total_amount'],
      unitPrice: json['unit_price'],
    );
  }
}
