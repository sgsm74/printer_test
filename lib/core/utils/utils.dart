import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_test/printer/domain/entities/business_printers.dart';

import '../../printer/presentation/bloc/printer_bloc.dart';
import '../widgets/add_printer_dialog.dart';

Future<T?> showPopUp<T>(
  BuildContext context,
  Widget widget, {
  bool dismissible = true,
  double radius = 0,
  bool resizeToAvoidBottomInset = true,
  RouteSettings? routeSettings,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: dismissible,
    routeSettings: routeSettings,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: widget,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        // backgroundColor: Colors.transparent,
      );
    },
  );
}

void addPrinter(
  BuildContext context,
  BusinessPrinters printer,
  bool isEdit,
  List<BusinessPrinters> addedPrinters,
) {
  showPopUp(
    context,
    AddPrinterDialog(
      printer: printer,
      onTap: (newPrinter) {
        if (addedPrinters.contains(printer)) {
          isEdit
              ? addedPrinters[addedPrinters.indexOf(printer)] = newPrinter
              : addedPrinters.add(newPrinter);
        } else {
          addedPrinters.add(newPrinter);
        }
        BlocProvider.of<PrinterBloc>(context)
            .add(SavePrintersEvent(printers: addedPrinters));
        getPrinters(context, addedPrinters);
      },
    ),
  );
}

void getPrinters(
  BuildContext context,
  List<BusinessPrinters> addedPrinters,
) {
  addedPrinters = [];
  BlocProvider.of<PrinterBloc>(context).add(GetPrintersEvent());
}

String seprate3Numbers(int price) {
  return price.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );
}
