import 'dart:async';
import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/usecase.dart';
import '../../domain/entities/business_printers.dart';
import '../../domain/usecases/delete_printer.dart';
import '../../domain/usecases/get_printers.dart';
import '../../domain/usecases/save_printers.dart';
import '../../domain/usecases/scan_printers.dart';
import '../../domain/usecases/start_printing.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc({
    required this.getPrinters,
    required this.savePrinters,
    required this.scanPrinters,
    required this.deletePrinter,
    required this.startPrinting,
  }) : super(PrinterInitial()) {
    on<PrinterEvent>(
      (event, emit) async {
        if (event is ScanPrintersEvent) {
          await _onScanPrintersEvent(event, emit);
        } else if (event is GetPrintersEvent) {
          await _onGetPrintersEvent(event, emit);
        } else if (event is SavePrintersEvent) {
          await _onSavePrintersEvent(event, emit);
        } else if (event is DeletePrinterEvent) {
          await _onDeletePrinterEvent(event, emit);
        } else if (event is StartPrintingEvent) {
          await _onStartPrintingEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  final GetPrinters getPrinters;
  final SavePrinters savePrinters;
  final ScanPrinters scanPrinters;
  final StartPrinting startPrinting;
  final DeletePrinter deletePrinter;

  Future<void> _onScanPrintersEvent(
    ScanPrintersEvent event,
    Emitter<PrinterState> emit,
  ) async {
    emit(PrinterLoading());
    final result = await scanPrinters(NoParams());
    emit(
      result.fold(
        (error) => PrintersError(message: error.message),
        (printers) => ScanPrintersState(printers: printers),
      ),
    );
  }

  Future<void> _onGetPrintersEvent(
    GetPrintersEvent event,
    Emitter<PrinterState> emit,
  ) async {
    emit(PrinterOperationLoading());
    final result = await getPrinters(NoParams());
    emit(
      result.fold(
        (error) => PrintersError(message: error.message),
        (printers) => GetPrintersState(printers: printers),
      ),
    );
  }

  Future<void> _onSavePrintersEvent(
    SavePrintersEvent event,
    Emitter<PrinterState> emit,
  ) async {
    emit(PrinterOperationLoading());
    final result = await savePrinters(PrintersParams(printers: event.printers));
    emit(
      result.fold(
        (error) => PrintersError(message: error.message),
        (ok) => SavePrintersState(),
      ),
    );
  }

  Future<void> _onDeletePrinterEvent(
    DeletePrinterEvent event,
    Emitter<PrinterState> emit,
  ) async {
    emit(PrinterOperationLoading());
    final result = await deletePrinter(PrinterParams(printer: event.printer));
    emit(
      result.fold(
        (error) => PrintersError(message: error.message),
        (ok) => DeletePrintersState(),
      ),
    );
  }

  Future<void> _onStartPrintingEvent(
    StartPrintingEvent event,
    Emitter<PrinterState> emit,
  ) async {
    final result = await startPrinting(
      StartPrintingParams(printer: event.printer, pdf: event.pdf),
    );
    emit(
      result.fold(
        (error) => PrintersError(message: error.message),
        (ok) => StartPrintingState(),
      ),
    );
  }
}
