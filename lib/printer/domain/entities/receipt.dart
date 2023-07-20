import 'package:equatable/equatable.dart';

class Receipt extends Equatable {
  const Receipt({
    required this.name,
  });
  final String name;

  @override
  List<Object> get props => [name];
}
