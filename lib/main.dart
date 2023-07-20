import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_test/core/utils/pdf_generator.dart';
import 'package:printer_test/core/utils/utils.dart';
import 'package:printer_test/printer/domain/entities/business_printers.dart';
import 'package:printer_test/printer/presentation/pages/printers_management_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'printer/presentation/bloc/printer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Printing Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Printing Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PrinterBloc>(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Main'),
                Tab(text: 'Discovered'),
                Tab(text: 'Added'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MainPage(),
              DiscoveredPrintersWidget(),
              AddedPrintersWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BusinessPrinters> addedPrinters = [];
  final textEditingController = TextEditingController();
  String printerError = '';
  @override
  void initState() {
    getPrinters(context, addedPrinters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrinterBloc, PrinterState>(
      listener: (context, state) {
        if (state is GetPrintersState) {
          addedPrinters = state.printers;
        } else if (state is PrintersError) {}
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              ElevatedButton(
                  onPressed: () => _startPrinting(context),
                  child: const Text('Print')),
              Text(
                printerError,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
        );
      },
    );
  }

  void _startPrinting(BuildContext context) async {
    if (addedPrinters.isEmpty) {
      setState(() {
        printerError = 'There is no printer';
      });
    }
    final sd = await printReceipt();
    for (var printer in addedPrinters) {
      BlocProvider.of<PrinterBloc>(context)
          .add(StartPrintingEvent(printer: printer, pdf: sd));
    }
  }
}
