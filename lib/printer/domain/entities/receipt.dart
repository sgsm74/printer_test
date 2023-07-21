import 'package:equatable/equatable.dart';

import 'package:printer_test/printer/domain/entities/item.dart';

class Receipt extends Equatable {
  const Receipt({
    required this.vendorName,
    required this.vendorAddress,
    required this.date,
    required this.time,
    required this.number,
    required this.totalDiscount,
    required this.totalAmount,
    required this.totalPayableAmount,
    required this.items,
  });
  final String vendorName;
  final String vendorAddress;
  final String date;
  final String time;
  final int number;
  final int totalDiscount;
  final int totalAmount;
  final int totalPayableAmount;
  final List<OrderItem> items;

  @override
  List<Object> get props => [
        vendorName,
        vendorAddress,
        date,
        time,
        number,
        totalDiscount,
        totalAmount,
        totalPayableAmount,
        items
      ];
}
