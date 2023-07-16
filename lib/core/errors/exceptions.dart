import 'package:equatable/equatable.dart';

///This is used to report server Exceptions like 404,500,etc.
class ServerException extends Equatable implements Exception {
  const ServerException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class PortException extends Equatable implements Exception {
  const PortException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class HiveException implements Exception {}

class PrinterException extends Equatable implements Exception {
  const PrinterException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class DirectoryException extends Equatable implements Exception {
  /// The default constructor.
  const DirectoryException({required this.message});

  /// Give the reason why this exception is thrown.
  final String message;

  @override
  List<Object> get props => [message];
}

class UpdaterException extends Equatable implements Exception {
  const UpdaterException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
