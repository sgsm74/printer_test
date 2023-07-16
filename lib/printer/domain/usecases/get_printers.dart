import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/business_printers.dart';
import '../repositories/printer_repository.dart';

class GetPrinters implements UseCase<List<BusinessPrinters>, NoParams> {
  GetPrinters({required this.repository});

  final PrinterRepository repository;

  @override
  Future<Either<Failure, List<BusinessPrinters>>> call(NoParams params) {
    return repository.getPrinters();
  }
}
