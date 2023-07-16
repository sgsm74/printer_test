import 'package:queue/queue.dart';

import '../../../core/consts/consts.dart';
import '../../../core/utils/hive_utils.dart';
import '../../domain/entities/business_printers.dart';

abstract class PrinterLocalDataSource {
  Future<void> savePrinters(List<BusinessPrinters> printers);
  Future<List<BusinessPrinters>> getPrinters();
  Future<void> deletePrinter(BusinessPrinters printer);
}

class PrinterLocalDataSourceImpl implements PrinterLocalDataSource {
  const PrinterLocalDataSourceImpl({
    required this.printerQueue,
  });
  final Queue printerQueue;

  @override
  Future<List<BusinessPrinters>> getPrinters() async =>
      printerQueue.add(() async => await loadListFromHive(HiveKeys.printers));

  @override
  Future<void> savePrinters(List<BusinessPrinters> printers) async =>
      printerQueue
          .add(() async => await saveListToHive(HiveKeys.printers, printers));

  @override
  Future<void> deletePrinter(BusinessPrinters printer) async => printerQueue
      .add(() async => await deleteFromHive(HiveKeys.printers, printer.id));
}
