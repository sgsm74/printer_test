import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

abstract class PrinterNetworkDatasource {
  Future<List<Printer>> startScanUsbPrinters();
  Future<void> startUsbPrint(Printer printer, Uint8List pdf);
}

class PrinterNetworkDatasourceImp implements PrinterNetworkDatasource {
  @override
  Future<List<Printer>> startScanUsbPrinters() async =>
      await Printing.listPrinters();

  @override
  Future<void> startUsbPrint(Printer printer, Uint8List pdf) async {
    await Printing.directPrintPdf(
      printer: printer,
      onLayout: (layout) => pdf,
      format: PdfPageFormat.roll80,
    );
  }
}
