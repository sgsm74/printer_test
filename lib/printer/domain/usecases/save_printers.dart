import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/errors.dart';
import '../../../core/ok.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/business_printers.dart';
import '../repositories/printer_repository.dart';

class SavePrinters implements UseCase<OK, PrintersParams> {
  SavePrinters({required this.repository});

  final PrinterRepository repository;

  @override
  Future<Either<Failure, OK>> call(PrintersParams params) {
    return repository.savePrinters(params.printers);
  }
}

class PrintersParams extends Equatable {
  const PrintersParams({required this.printers});

  final List<BusinessPrinters> printers;

  @override
  List<Object?> get props => [printers];
}
