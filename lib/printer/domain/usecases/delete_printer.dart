import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/errors.dart';
import '../../../core/ok.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/business_printers.dart';
import '../repositories/printer_repository.dart';

class DeletePrinter implements UseCase<OK, PrinterParams> {
  DeletePrinter({required this.repository});

  final PrinterRepository repository;

  @override
  Future<Either<Failure, OK>> call(PrinterParams params) {
    return repository.deletePrinter(params.printer);
  }
}

class PrinterParams extends Equatable {
  const PrinterParams({required this.printer});

  final BusinessPrinters printer;

  @override
  List<Object?> get props => [printer];
}
