import 'package:equatable/equatable.dart';

abstract class RetrieveCodeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RetrieveCodeInitial extends RetrieveCodeState {}

class RetrieveCodeLoading extends RetrieveCodeState {}

class RetrieveCodeSuccess extends RetrieveCodeState {
  final String message;

  RetrieveCodeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RetrieveCodeFailure extends RetrieveCodeState {
  final String error;

  RetrieveCodeFailure(this.error);

  @override
  List<Object?> get props => [error];
}
