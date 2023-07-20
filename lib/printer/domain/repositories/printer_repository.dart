import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:printer_test/printer/domain/entities/receipt.dart';

import '../../../core/errors/errors.dart';
import '../../../core/ok.dart';
import '../entities/business_printers.dart';

abstract class PrinterRepository {
  Future<Either<Failure, List<BusinessPrinters>>> scanPrinters();
  Future<Either<Failure, OK>> startPrinting(
    BusinessPrinters printer,
    Uint8List pdf,
  );
  Future<Either<Failure, OK>> savePrinters(List<BusinessPrinters> printer);
  Future<Either<Failure, OK>> deletePrinter(BusinessPrinters printer);
  Future<Either<Failure, List<BusinessPrinters>>> getPrinters();
  Future<Either<Failure, Stream<Receipt>>> socketConnection(
      String ip, String port);
}
