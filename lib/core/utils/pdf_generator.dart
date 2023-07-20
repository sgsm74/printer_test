import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printer_test/printer/domain/entities/receipt.dart';

Future<Uint8List> printReceipt({Receipt? order}) async {
  var font = await rootBundle.load('assets/fonts/Dana-FaNum-Regular.ttf');
  var myFont = pw.Font.ttf(font);
  var myStyle = pw.TextStyle(
    fontSize: 8.5,
    font: myFont,
  );
  final pdf = pw.Document();

  /// Order Items header
  List<pw.Widget> orderItemsHeader = [
    pw.Container(
      alignment: pw.Alignment.center,
      width: PdfPageFormat.roll80.width / 7,
      child: pw.Text(
        'جمع‌کل',
        style: myStyle.copyWith(color: PdfColors.black),
      ),
    ),
    pw.Container(
      alignment: pw.Alignment.center,
      width: PdfPageFormat.roll80.width / 7,
      child: pw.Text(
        'تخفیف',
        style: myStyle.copyWith(color: PdfColors.black),
      ),
    ),
    pw.Container(
      alignment: pw.Alignment.center,
      width: PdfPageFormat.roll80.width / 7,
      child: pw.Text(
        'قیمت‌کالا',
        style: myStyle.copyWith(color: PdfColors.black),
      ),
    ),
    pw.Container(
      alignment: pw.Alignment.center,
      width: PdfPageFormat.roll80.width / 7,
      child: pw.Text(
        'تعداد',
        style: myStyle.copyWith(color: PdfColors.black),
      ),
    ),
    pw.Container(
      alignment: pw.Alignment.center,
      width: PdfPageFormat.roll80.width / 3,
      child: pw.Text(
        'نام کالا',
        style: myStyle.copyWith(color: PdfColors.black),
      ),
    ),
  ];

  /// Genertate items
  itemsList() {
    List<pw.Widget> itemBuilderList = [
      pw.Container(
        width: PdfPageFormat.roll80.width / 7,
        alignment: pw.Alignment.center,
        child: pw.Text(
          '20000',
          style: myStyle,
          textDirection: pw.TextDirection.rtl,
        ),
      ),
      pw.Container(
        width: PdfPageFormat.roll80.width / 7,
        alignment: pw.Alignment.center,
        child: pw.Text(
          '20000',
          style: myStyle,
          textDirection: pw.TextDirection.rtl,
        ),
      ),
      pw.Container(
        width: PdfPageFormat.roll80.width / 7,
        alignment: pw.Alignment.center,
        child: pw.Text(
          '20000',
          style: myStyle,
          textDirection: pw.TextDirection.rtl,
        ),
      ),
      pw.Container(
        width: PdfPageFormat.roll80.width / 7,
        alignment: pw.Alignment.center,
        child: pw.Text(
          '1',
          style: myStyle,
          textDirection: pw.TextDirection.rtl,
        ),
      ),
      pw.Container(
        width: PdfPageFormat.roll80.width / 3,
        alignment: pw.Alignment.center,
        child: pw.Column(
          children: [
            pw.Text(
              'name',
              textDirection: pw.TextDirection.rtl,
              style: myStyle.copyWith(font: myFont),
            ),
          ],
        ),
      ),
    ];

    return itemBuilderList;
  }

  /// Generate modifiers
  List<pw.Widget> _itemsBuilder() {
    List<pw.Widget> items = [];

    for (int i = 0; i < 3; i++) {
      items.add(
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Column(
            children: [
              pw.Row(
                children: itemsList(),
              ),
            ],
          ),
        ),
      );
    }
    return items;
  }

  /// Bill body section
  pw.Widget _body() {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        child: pw.Column(
          children: [
            pw.Container(
              color: null,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: orderItemsHeader,
              ),
            ),
            pw.Column(children: _itemsBuilder()),
          ],
        ),
      ),
    );
  }

  List<pw.Widget> totalPriceList = [
    pw.Expanded(
      child: pw.Container(
        alignment: pw.Alignment.center,
        height: 20,
        padding: const pw.EdgeInsets.symmetric(horizontal: 5),
        color: PdfColors.black,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              '2222  ریال',
              textDirection: pw.TextDirection.rtl,
              style: myStyle.copyWith(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
            pw.Text(
              'مبلغ قابل پرداخت: ',
              textDirection: pw.TextDirection.rtl,
              style: myStyle.copyWith(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  List<pw.Widget> header = [
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text('شاین',
            style:
                myStyle.copyWith(font: myFont, fontWeight: pw.FontWeight.bold)),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('شماره فاکتور: 1212',
                style: myStyle.copyWith(font: myFont)),
            pw.Text('فروشگاه رضا', style: myStyle.copyWith(font: myFont)),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('1402/07/10', style: myStyle.copyWith(font: myFont)),
            pw.Text('021-46656565', style: myStyle.copyWith(font: myFont)),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('22:32', style: myStyle.copyWith(font: myFont)),
            pw.Text('تهران فردوسی', style: myStyle.copyWith(font: myFont)),
          ],
        ),
      ],
    ),
  ];

  List<pw.Widget> prices = [
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('20000', style: myStyle.copyWith(font: myFont)),
                pw.Text(
                  'جمع کل بدون تخفیف: ',
                  style: myStyle.copyWith(font: myFont),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('20000', style: myStyle.copyWith(font: myFont)),
                pw.Text(
                  'مجموع تخفیف ها: ',
                  style: myStyle.copyWith(font: myFont),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
  pw.Widget _prices() {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: pw.Directionality(
          textDirection: pw.TextDirection.rtl, child: pw.Row(children: prices)),
    );
  }

  pw.Widget _header() {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Column(
          children: header,
        ),
      ),
    );
  }

  pw.Widget _totalPrice() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: totalPriceList,
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      margin: pw.EdgeInsets.zero,
      build: (context) {
        return pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.only(right: 25),
            child: pw.Column(
              children: [
                pw.SizedBox(height: 5),
                _header(),
                pw.SizedBox(height: 5),
                _body(),
                _prices(),
                pw.SizedBox(height: 5),
                _totalPrice(),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text(
                    'از خرید شما متشکریم',
                    textDirection: pw.TextDirection.rtl,
                    style: myStyle.copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  return await pdf.save();
}