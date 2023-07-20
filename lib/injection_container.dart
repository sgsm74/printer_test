import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:printer_test/printer/data/datasource/printer_local_datasource.dart';
import 'package:printer_test/printer/data/datasource/printer_network_datasource.dart';
import 'package:printer_test/printer/data/repositories/printer_repository_impl.dart';
import 'package:printer_test/printer/domain/entities/business_printers.dart';
import 'package:printer_test/printer/domain/repositories/printer_repository.dart';
import 'package:printer_test/printer/domain/usecases/delete_printer.dart';
import 'package:printer_test/printer/domain/usecases/get_printers.dart';
import 'package:printer_test/printer/domain/usecases/save_printers.dart';
import 'package:printer_test/printer/domain/usecases/scan_printers.dart';
import 'package:printer_test/printer/domain/usecases/socket_connection.dart';
import 'package:printer_test/printer/domain/usecases/start_printing.dart';
import 'package:printer_test/printer/presentation/bloc/printer_bloc.dart';
import 'package:queue/queue.dart';

final sl = GetIt.instance;

//Queues
const _localQueue = 'localQueue';

Future<void> init() async {
  await _injectHive();
  _injectPrinter();
}

Future<void> _injectHive() async {
  Directory hiveDbDirectory = Directory('');
  hiveDbDirectory = Directory(
    '${Directory.current.path}/Hive',
  );
  if (!await hiveDbDirectory.exists()) {
    Directory(hiveDbDirectory.path).create(recursive: true);
  }
  Hive.init(hiveDbDirectory.path);
  Hive.registerAdapter(BusinessPrintersAdapter());
}

void _injectPrinter() {
  //bloc
  sl.registerFactory(
    () => PrinterBloc(
      getPrinters: sl(),
      savePrinters: sl(),
      scanPrinters: sl(),
      deletePrinter: sl(),
      startPrinting: sl(),
      socketConnectionUseCase: sl(),
    ),
  );
  //usecases
  sl.registerLazySingleton(() => GetPrinters(repository: sl()));
  sl.registerLazySingleton(() => SavePrinters(repository: sl()));
  sl.registerLazySingleton(() => ScanPrinters(repository: sl()));
  sl.registerLazySingleton(() => StartPrinting(repository: sl()));
  sl.registerLazySingleton(() => DeletePrinter(repository: sl()));
  sl.registerLazySingleton(() => SocketConnection(repository: sl()));

  //repository
  sl.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(localDataSource: sl(), networkDatasource: sl()),
  );
  //datasource
  sl.registerLazySingleton<PrinterLocalDataSource>(
    () => PrinterLocalDataSourceImpl(
      printerQueue: sl.get(instanceName: _localQueue),
    ),
  );
  sl.registerLazySingleton<PrinterNetworkDatasource>(
    () => PrinterNetworkDatasourceImp(),
  );
  sl.registerLazySingleton<Queue>(() => Queue(), instanceName: _localQueue);
}
