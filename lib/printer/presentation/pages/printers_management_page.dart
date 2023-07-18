import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/utils.dart';
import '../../domain/entities/business_printers.dart';
import '../bloc/printer_bloc.dart';

class AddedPrintersWidget extends StatefulWidget {
  const AddedPrintersWidget({super.key});

  @override
  State<AddedPrintersWidget> createState() => _AddedPrintersWidgetState();
}

class _AddedPrintersWidgetState extends State<AddedPrintersWidget> {
  List<BusinessPrinters> addedPrinters = [];
  @override
  void initState() {
    getPrinters(context, addedPrinters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrinterBloc, PrinterState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<PrinterBloc, PrinterState>(
                  listener: (context, state) {
                    if (state is GetPrintersState) {
                      addedPrinters = state.printers;
                    } else if (state is PrintersError) {}
                  },
                  builder: (context, state) {
                    if (state is GetPrintersState) {
                      return _addedPrintersBodyBuilder(
                        context,
                        state.printers,
                      );
                    } else if (state is PrinterOperationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueGrey,
                        ),
                      );
                    } else {
                      return _addedPrintersBodyBuilder(
                        context,
                        addedPrinters,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () => getPrinters(context, addedPrinters),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Widget _addedPrintersBodyBuilder(
    BuildContext context,
    List<BusinessPrinters> printers,
  ) {
    return Visibility(
      visible: printers.isNotEmpty,
      replacement: const Center(
        child: Text('There is no printer'),
      ),
      child: ListView.builder(
        itemCount: printers.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.print),
              title: Text(printers[index].usecaseName),
              subtitle: Row(
                children: [
                  Text(printers[index].printerName),
                ],
              ),
              trailing: SizedBox(
                width: 60,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        addedPrinters.removeWhere(
                          (printer) =>
                              printer.id == printers[index].id &&
                              printer == printers[index],
                        );
                        BlocProvider.of<PrinterBloc>(context)
                            .add(SavePrintersEvent(printers: addedPrinters));
                        getPrinters(context, addedPrinters);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DiscoveredPrintersWidget extends StatefulWidget {
  const DiscoveredPrintersWidget({super.key});

  @override
  State<DiscoveredPrintersWidget> createState() =>
      _DiscoveredPrintersWidgetState();
}

class _DiscoveredPrintersWidgetState extends State<DiscoveredPrintersWidget> {
  List<BusinessPrinters> discoveredPrinters = [];
  @override
  void initState() {
    BlocProvider.of<PrinterBloc>(context).add(ScanPrintersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrinterBloc, PrinterState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<PrinterBloc, PrinterState>(
                  listener: (context, state) {
                    if (state is ScanPrintersState) {
                      discoveredPrinters = state.printers;
                    } else if (state is PrintersError) {}
                  },
                  builder: (context, state) {
                    if (state is PrinterLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueGrey,
                        ),
                      );
                    } else if (state is ScanPrintersState) {
                      return _discoveredPrintersBodyBuilder(
                        context,
                        state.printers,
                      );
                    } else {
                      return _discoveredPrintersBodyBuilder(
                        context,
                        discoveredPrinters,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.refresh,
            ),
            onPressed: () =>
                BlocProvider.of<PrinterBloc>(context).add(ScanPrintersEvent()),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Widget _discoveredPrintersBodyBuilder(
    BuildContext context,
    List<BusinessPrinters> printers,
  ) {
    return Visibility(
      visible: printers.isNotEmpty,
      replacement: const Center(
        child: Text('There is no printer'),
      ),
      child: ListView.builder(
        itemCount: printers.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => addPrinter(context, printers[index], false, []),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                leading: const Icon(
                  Icons.usb,
                  size: 15,
                ),
                title: Text(
                  printers[index].printerName,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
