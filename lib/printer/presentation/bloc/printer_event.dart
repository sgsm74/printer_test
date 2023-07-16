part of 'printer_bloc.dart';

abstract class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class GetPrintersEvent extends PrinterEvent {}

class ScanPrintersEvent extends PrinterEvent {}

class SavePrintersEvent extends PrinterEvent {
  const SavePrintersEvent({required this.printers});
  final List<BusinessPrinters> printers;
  @override
  List<Object> get props => [printers];
}

class DeletePrinterEvent extends PrinterEvent {
  const DeletePrinterEvent({required this.printer});
  final BusinessPrinters printer;
  @override
  List<Object> get props => [printer];
}

class StartPrintingEvent extends PrinterEvent {
  const StartPrintingEvent({required this.printer, required this.pdf});
  final BusinessPrinters printer;
  final Uint8List pdf;
  @override
  List<Object> get props => [printer, pdf];
}
