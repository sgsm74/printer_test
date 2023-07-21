import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class DbFailure extends Failure {
  const DbFailure({required super.message});
}

class PrinterFailure extends Failure {
  const PrinterFailure({required super.message});
}

class SocketFailure extends Failure {
  const SocketFailure({required super.message});
}
