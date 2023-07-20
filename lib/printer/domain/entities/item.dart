import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  const OrderItem({
    required this.name,
    required this.quantity,
    required this.discount,
    required this.totalAmount,
    required this.unitPrice,
  });
  final String name;
  final int quantity;
  final int discount;
  final int totalAmount;
  final int unitPrice;

  @override
  List<Object> get props => [name, quantity, discount, totalAmount];
}
