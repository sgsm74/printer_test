import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_test/printer/presentation/pages/main_page.dart';
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
      title: 'Printing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Dana',
      ),
      home: const MyHomePage(title: 'Printing'),
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
