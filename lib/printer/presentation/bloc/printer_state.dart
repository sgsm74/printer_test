part of 'printer_bloc.dart';

abstract class PrinterState extends Equatable {
  const PrinterState();

  @override
  List<Object> get props => [];
}

class PrinterInitial extends PrinterState {}

class PrinterLoading extends PrinterState {}

class PrinterOperationLoading extends PrinterState {}

class PrintersError extends PrinterState {
  const PrintersError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class SavePrintersState extends PrinterState {}

class DeletePrintersState extends PrinterState {}

class GetPrintersState extends PrinterState {
  const GetPrintersState({required this.printers});
  final List<BusinessPrinters> printers;
  @override
  List<Object> get props => [printers];
}

class ScanPrintersState extends PrinterState {
  const ScanPrintersState({required this.printers});
  final List<BusinessPrinters> printers;
  @override
  List<Object> get props => [printers];
}

class StartPrintingState extends PrinterState {}

class SocketConnectionSuccessfulState extends PrinterState {
  const SocketConnectionSuccessfulState({
    required this.stream,
  });
  final Stream<Receipt> stream;
  @override
  List<Object> get props => [stream];
}
