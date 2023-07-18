// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_printers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessPrintersAdapter extends TypeAdapter<BusinessPrinters> {
  @override
  final int typeId = 1;

  @override
  BusinessPrinters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusinessPrinters(
      id: fields[0] as String,
      printerName: fields[1] as String,
      usecaseName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BusinessPrinters obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.printerName)
      ..writeByte(2)
      ..write(obj.usecaseName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessPrintersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
