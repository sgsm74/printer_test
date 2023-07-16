import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../printer/domain/entities/business_printers.dart';

class AddPrinterDialog extends StatefulWidget {
  const AddPrinterDialog({
    Key? key,
    required this.printer,
    required this.onTap,
  }) : super(key: key);

  final BusinessPrinters printer;
  final Function(BusinessPrinters) onTap;

  @override
  State<AddPrinterDialog> createState() => _AddPrinterDialogState();
}

class _AddPrinterDialogState extends State<AddPrinterDialog> {
  final controller = TextEditingController();
  final wrongController = BehaviorSubject.seeded(true);

  @override
  void initState() {
    controller.text = widget.printer.usecaseName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 350,
        //height: calHeightScale(250),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.print),
                    const SizedBox(width: 5),
                    Text(widget.printer.printerName),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  StreamBuilder<bool>(
                    stream: wrongController.stream,
                    builder: (context, snapshot) {
                      bool data = snapshot.data ?? true;
                      return Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (data) ? Colors.black : Colors.red,
                          ),
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          autofocus: true,
                          onChanged: (value) =>
                              wrongController.add(value.isEmpty ? false : true),
                          controller: controller,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () => _validator(), child: const Text('ذخیره'))
            ],
          ),
        ),
      ),
    );
  }

  void _validator() async {
    if (controller.text.isEmpty) {
      wrongController.add(false);
    } else {
      widget.onTap(
        BusinessPrinters(
          id: widget.printer.id,
          printerName: widget.printer.id,
          usecaseName: controller.text,
        ),
      );
      Navigator.pop(context);
    }
  }
}
