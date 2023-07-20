import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../core/errors/errors.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/ok.dart';
import '../../domain/entities/business_printers.dart';
import '../../domain/repositories/printer_repository.dart';
import '../datasource/printer_local_datasource.dart';
import '../datasource/printer_network_datasource.dart';

class PrinterRepositoryImpl extends PrinterRepository {
  PrinterRepositoryImpl({
    required this.localDataSource,
    required this.networkDatasource,
  });

  final PrinterNetworkDatasource networkDatasource;
  final PrinterLocalDataSource localDataSource;
  @override
  Future<Either<Failure, List<BusinessPrinters>>> getPrinters() async {
    try {
      return Right(await localDataSource.getPrinters());
    } on HiveException catch (_) {
      return const Left(DbFailure(message: 'There is no printer'));
    }
  }

  @override
  Future<Either<Failure, OK>> savePrinters(
    List<BusinessPrinters> printer,
  ) async {
    try {
      await localDataSource.savePrinters(printer);
      return Right(OK());
    } on HiveException catch (_) {
      return const Left(DbFailure(message: 'There is no printer'));
    }
  }

  @override
  Future<Either<Failure, List<BusinessPrinters>>> scanPrinters() async {
    List<BusinessPrinters> printers = [];
    String usbError = '';
    try {
      if (!Platform.isAndroid && !Platform.isIOS) {
        final usbPrinters = await networkDatasource.startScanUsbPrinters();
        for (var element in usbPrinters) {
          printers.add(
            BusinessPrinters(
              id: element.url,
              printerName: element.name,
              usecaseName: element.name,
            ),
          );
        }
      }
    } catch (e) {
      usbError += e.toString();
      //throw Left(PrinterFailure(message: e.message));
    }

    return usbError.isEmpty
        ? Right(printers)
        : Left(PrinterFailure(message: usbError));
  }

  @override
  Future<Either<Failure, OK>> startPrinting(
    BusinessPrinters printer,
    Uint8List pdf,
  ) async {
    try {
      final printers = await networkDatasource.startScanUsbPrinters();
      bool found = false;
      for (var element in printers) {
        if (element.url.trim() == printer.id.trim()) {
          await networkDatasource.startUsbPrint(element, pdf);
          found = true;
        }
      }
      if (found) {
        return Right(OK());
      } else {
        throw const PrinterException(
          message: 'There is no connected printer',
        );
      }
    } on PrinterException catch (e) {
      return Left(PrinterFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OK>> deletePrinter(BusinessPrinters printer) async {
    try {
      await localDataSource.deletePrinter(printer);
      return Right(OK());
    } on HiveException catch (_) {
      return const Left(
        DbFailure(message: 'Delete printer failed'),
      );
    }
  }
}
