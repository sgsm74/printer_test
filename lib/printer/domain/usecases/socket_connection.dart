import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:printer_test/core/errors/errors.dart';
import 'package:printer_test/core/usecase/usecase.dart';
import 'package:printer_test/printer/domain/entities/receipt.dart';
import 'package:printer_test/printer/domain/repositories/printer_repository.dart';

class SocketConnection
    implements UseCase<Stream<Receipt>, SocketConnectionParams> {
  SocketConnection({required this.repository});

  final PrinterRepository repository;

  @override
  Future<Either<Failure, Stream<Receipt>>> call(SocketConnectionParams params) {
    return repository.socketConnection(params.ip, params.port);
  }
}

class SocketConnectionParams extends Equatable {
  const SocketConnectionParams({required this.ip, required this.port});

  final String ip;
  final String port;

  @override
  List<Object?> get props => [ip, port];
}
