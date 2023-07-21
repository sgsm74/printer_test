import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_test/core/utils/pdf_generator.dart';
import 'package:printer_test/core/utils/utils.dart';
import 'package:printer_test/printer/domain/entities/business_printers.dart';
import 'package:printer_test/printer/domain/entities/receipt.dart';
import 'package:printer_test/printer/presentation/bloc/printer_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BusinessPrinters> addedPrinters = [];
  final textEditingController = TextEditingController();
  String printerError = '', ip = '127.0.0.1', port = '8080';
  StreamController? streamController;
  List<Receipt> receipts = [];
  @override
  void initState() {
    getPrinters(context, addedPrinters);
    BlocProvider.of<PrinterBloc>(context)
        .add(SocketConnectionEvent(ip: ip, port: port));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrinterBloc, PrinterState>(
      listener: (context, state) {
        print(state);
        if (state is GetPrintersState) {
          addedPrinters = state.printers;
        } else if (state is PrintersError) {
        } else if (state is SocketConnectionSuccessfulState) {
          state.stream.asBroadcastStream().listen((receipt) {
            print(receipt);
            receipts.add(receipt);
            _startPrinting(context, receipt);
          });
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: receipts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final receipt = receipts[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            'سفارش شماره: ${receipt.number}',
                          ),
                          subtitle: Text(
                            'مبلغ قابل پرداخت: ${seprate3Numbers(receipt.totalPayableAmount)} ریال',
                          ),
                          trailing: IconButton(
                            onPressed: () => _startPrinting(context, receipt),
                            icon: const Icon(Icons.print_rounded),
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(receipt.date),
                              Text(receipt.time),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Expanded(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: TextFormField(
                //           controller: textEditingController,
                //           decoration:
                //               const InputDecoration(border: OutlineInputBorder()),
                //         ),
                //       ),
                //       ElevatedButton(
                //         onPressed: () {},
                //         child: const Text('Print Test'),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startPrinting(BuildContext context, Receipt receipt) async {
    if (addedPrinters.isEmpty) {
      setState(() {
        printerError = 'There is no printer';
      });
    }
    final sd = await printReceipt(receipt: receipt);
    for (var printer in addedPrinters) {
      BlocProvider.of<PrinterBloc>(context)
          .add(StartPrintingEvent(printer: printer, pdf: sd));
    }
  }
}
