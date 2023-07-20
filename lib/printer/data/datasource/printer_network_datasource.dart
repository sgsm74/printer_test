import 'dart:async';
import 'dart:typed_data';

import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
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
    const htmlContent = '''
  
<!DOCTYPE html>
<html lang="fa" dir="rtl">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://shinebag.ir/fonts/css/fontiran.css" />
    <title>Shine</title>
  </head>
  <style>
    @page {
      size: 79mm Portrait;
    }
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      word-break: break-word;
      font-family: dana, sans-serif;
      -moz-font-feature-settings: "ss02";
      -webkit-font-feature-settings: "ss02";
      font-feature-settings: "ss02";
    }
    .noborder {
      border: unset !important;
    }
    body {
      width: 72mm;
      box-sizing: border-box;
      margin-right: 2px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    table.table-head {
      --border: 1px solid black;
      border-radius: 3px;
      border-spacing: 0;
      border-collapse: separate;
      border: var(--border);
      overflow: hidden;
    }

    thead {
      font-size: 8px;
      line-height: 13px;
    }
    thead tr th,
    thead tr td {
      padding: 4px;
    }
    thead tr td:last-of-type {
      text-align: end;
    }
    .table-body {
      margin-top: 5px;
      --border: 1px solid black;
      border-radius: 3px;
      border-spacing: 0;
      border-collapse: separate;
      border: var(--border);
      overflow: hidden;
      border-bottom-left-radius: unset;
    }
    .table-body tbody tr:first-of-type {
      font-size: 8px;
      font-weight: bold;
      height: 33px;
    }
    .table-body tbody tr {
      font-size: 10px;
      line-height: 16px;
      font-weight: 600;
    }
    .table-body tbody tr td {
      border-bottom: 0.5px solid black;
      text-align: center;
    }
    .table-body tbody tr td:first-of-type {
      width: 35%;
    }
    .table-body tbody tr td:nth-of-type(2) {
      width: 7%;
    }
    .table-body tbody tr td:nth-of-type(3) {
      width: 20%;
    }
    .table-body tbody tr td:nth-of-type(4) {
      width: 18%;
    }
    .table-body tbody tr td:nth-of-type(5) {
      width: 20%;
    }
    .table-body tbody tr td:first-of-type {
      border-left: 0.5px solid black;
    }
    .table-body tbody tr td:nth-of-type(3) {
      border-left: 0.5px solid black;
      border-right: 0.5px solid black;
    }
    .table-body tbody tr td:nth-of-type(4) {
      border-left: 0.5px solid black;
    }
  
    .table-body tbody tr:first-of-type td:nth-of-type(2) div{

      transform: rotate(-90deg);
    }
    .table-body tbody tr:last-of-type td {
      border-bottom: unset;
    }
    .table-footer tr {
      font-size: 10px;
    }
    .table-footer tr td {
      text-align: center;
    }
    table.wallet {
      --border: 1px solid black;
      border-radius: 3px;
      border-spacing: 0;
      border-collapse: separate;
      border: var(--border);
      overflow: hidden;
      margin-top: 5px;
      height: 45px;
      width: 120px;
    }
    table.wallet tr:first-of-type td:first-of-type {
      font-size: 8px;
      font-weight: 500;
    }

    table.price-detail tr td {
      font-size: 9px;
      line-height: 15px;
      font-weight: 700;
      text-align: end;
      padding-left: 5px;
      padding-bottom: 3px;
      padding-top: 4px;
    }
    table.price-detail-number {
      --border: 1px solid black;
      border-radius: 3px;
      border-spacing: 0;
      border-collapse: separate;
      border: var(--border);
      overflow: hidden;
      border-top: unset;
      border-top-right-radius: unset;
      border-top-left-radius: unset;
      margin-left: -3px;
      margin-top: 0;
      width: 56px;
    }
    table.price-detail-number tr {
      font-size: 10px;
      line-height: 16px;
      font-weight: 600;
      height: 25px;
    }
    table.price-detail-number tr:first-of-type td {
      border-bottom: 0.5px solid black;
    }
    table.final-price{
      margin-top: 10px;
      --border: 1px solid black;
      border-radius: 3px;
      border-spacing: 0;
      border-collapse: separate;
      border: var(--border);
      overflow: hidden;
      font-size: 12px;
      font-weight: 900;
    }
    table.final-price tr{
      background-color: #000;
      color: #fff;
      text-align: center;
    }
    table.final-price tr td{
      padding: 5px;
    }
    table.barcode{
      margin-top: 5px;
      border-top: 1px solid black;
      text-align: center;
      font-weight: 600;
    }
  </style>
  <body>
    <div class="receipt">
      <table class="table-head">
        <thead class="">
          <tr class="">
            <th class="" colspan="2">شاین</th>
          </tr>
          <tr class="">
            <td>فروشگاه رضا</td>
            <td>شماره فاکتور: 387</td>
          </tr>
          <tr class="">
            <td>021-8877665544</td>
            <td>1402/04/07</td>
          </tr>
          <tr class="">
            <td>تهران خیابان فردوسی سر ابیورد پلاک 5</td>
            <td class="">22:32</td>
          </tr>
        </thead>
      </table>
      <table class="table-body">
        <tbody class="">
          <tr class="">
            <td class="" colspan="">نام کالا</td>
            <td class="" colspan="">
              <div>تعداد</div>
            </td>
            <td class="" colspan="">قیمت کالا</td>
            <td class="" colspan="">تخفیف</td>
            <td class="" colspan="">جمع کل</td>
          </tr>
          <tr class="">
            <td class="" colspan="">چی توز موتوری 70 گرمی</td>
            <td class="" colspan="">1</td>
            <td class="" colspan="">100,000</td>
            <td class="" colspan="">0</td>
            <td class="" colspan="">100,000</td>
          </tr>
          <tr class="">
            <td class="" colspan="">چی توز موتوری 70 گرمی</td>
            <td class="" colspan="">1</td>
            <td class="" colspan="">100,000</td>
            <td class="" colspan="">0</td>
            <td class="" colspan="">100,000</td>
          </tr>
          <tr class="">
            <td class="" colspan="">چی توز موتوری 70 گرمی</td>
            <td class="" colspan="">1</td>
            <td class="" colspan="">100,000</td>
            <td class="" colspan="">0</td>
            <td class="" colspan="">100,000</td>
          </tr>
        </tbody>
      </table>
      <table class="table-footer">
        <tr style="margin-bottom: 10px">
          <td>
            <table class="wallet">
              <tr>
                <td>پرداخت از کیف پول:</td>
                <td rowspan="2">لوگو</td>
              </tr>
              <tr>
                <td>0 ریال</td>
              </tr>
            </table>
          </td>
          <td>
            <table class="price-detail">
              <tr>
                <td>جمع کل بدون تخفیف:</td>
              </tr>
              <tr>
                <td>مجموع تخفیف ها:</td>
              </tr>
            </table>
          </td>
          <td>
            <table class="price-detail-number">
              <tr>
                <td>620,000</td>
              </tr>
              <tr>
                <td>0</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <table class="final-price">
            <tr>
              <td colspan="3">مبلغ قابل پرداخت : 620,0000 ریال</td>
            </tr>
          </table>
        </tr>
      </table>
      <table class="barcode">
        <tr>
          <td>از خرید شما متشکریم</td>
        </tr>
        <tr>
          <td>بارکد</td>
        </tr>
      </table>
    </div>
  </body>
</html>

''';

    final newpdf = Document();
    List<Widget> widgets = await HTMLToPdf().convert(htmlContent);
    newpdf.addPage(MultiPage(
        maxPages: 200,
        build: (context) {
          return widgets;
        }));
    final r = await newpdf.save();
    await Printing.directPrintPdf(
      printer: printer,
      onLayout: (layout) => r,
      format: PdfPageFormat.roll80,
    );
  }
}
