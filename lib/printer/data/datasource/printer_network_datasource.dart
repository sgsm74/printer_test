import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:printer_test/printer/data/model/receipt_model.dart';
import 'package:printing/printing.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class PrinterNetworkDatasource {
  Future<List<Printer>> startScanUsbPrinters();
  Future<void> startUsbPrint(Printer printer, Uint8List pdf);
  Stream<ReceiptModel> socketConnection(String ip, String port);
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

  @override
  Stream<ReceiptModel> socketConnection(String ip, String port) async* {
    try {
      final channel = IOWebSocketChannel.connect('ws://$ip:$port');
      await for (var data in channel.stream) {
        log(data);
        yield ReceiptModel.fromJson(json.decode(data));
      }
    } on WebSocketChannelException catch (e) {
      throw WebSocketChannelException(e.message);
    } on SocketException catch (e) {
      throw SocketException(e.message);
    }
  }
}
