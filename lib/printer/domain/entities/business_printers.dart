import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'business_printers.g.dart';

@HiveType(typeId: 0)
class BusinessPrinters extends Equatable {
  const BusinessPrinters({
    required this.id,
    required this.printerName,
    required this.usecaseName,
  });

  // in usb printers equals to url and in network printers equals to macAddress
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String printerName;
  @HiveField(2)
  final String usecaseName;

  @override
  List<Object?> get props => [id];
}
