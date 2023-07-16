import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../core/errors/errors.dart';
import '../../../core/ok.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/business_printers.dart';
import '../repositories/printer_repository.dart';

class StartPrinting implements UseCase<OK, StartPrintingParams> {
  StartPrinting({required this.repository});

  final PrinterRepository repository;

  @override
  Future<Either<Failure, OK>> call(StartPrintingParams params) {
    return repository.startPrinting(params.printer, params.pdf);
  }
}

class StartPrintingParams extends Equatable {
  const StartPrintingParams({required this.printer, required this.pdf});

  final BusinessPrinters printer;
  final Uint8List pdf;

  @override
  List<Object?> get props => [printer, pdf];
}
