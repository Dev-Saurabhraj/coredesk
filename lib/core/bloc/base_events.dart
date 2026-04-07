import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class InitializeEvent extends BaseEvent {
  const InitializeEvent();
}

class RefreshEvent extends BaseEvent {
  const RefreshEvent();
}

class RetryEvent extends BaseEvent {
  const RetryEvent();
}

class ClearErrorEvent extends BaseEvent {
  const ClearErrorEvent();
}

class ResetEvent extends BaseEvent {
  const ResetEvent();
}
