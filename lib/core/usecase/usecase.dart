import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:printer_test/core/errors/errors.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseStream<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchToServerParams extends Equatable {
  const FetchToServerParams({
    required this.businessId,
    required this.fetchToServer,
    this.businessSlug,
  });

  final int businessId;
  final String? businessSlug;
  final bool fetchToServer;

  @override
  List<Object> get props => [businessSlug ?? businessId, fetchToServer];
}

class SetIdParams extends Equatable {
  const SetIdParams({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
