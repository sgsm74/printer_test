import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/widgets.dart';
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
    const htmlContent = '''
  <h1>Heading Example</h1>
  <p>This is a paragraph.</p>
  <img src="image.jpg" alt="Example Image" />
  <blockquote>This is a quote.</blockquote>
  <ul>
    <li>First item</li>
    <li>Second item</li>
    <li>Third item</li>
  </ul>
''';

  final newpdf = Document();
  List<Widget> widgets = await HTMLToPdf().convert(htmlContent);
  newpdf.addPage(MultiPage(
      maxPages: 200,
      build: (context) {
        return widgets;
      }));
    // await Printing.directPrintPdf(
    //   printer: printer,
    //   onLayout: (layout) => pdf,
    //   format: PdfPageFormat.roll80,
    // );
    await Printing.layoutPdf(onLayout: (el) => Printing.convertHtml(html: '''
<!DOCTYPE html>
<html lang="fa" dir="rtl">
  <head>
    <title>Shine</title>
  </head>
  <body>
    <p>Hi</p>
  </body>
</html>
'''));
  }
}
