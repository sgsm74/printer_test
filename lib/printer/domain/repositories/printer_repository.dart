import 'dart:typed_data';

import 'package:dartz/dartz.dart';

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
}
