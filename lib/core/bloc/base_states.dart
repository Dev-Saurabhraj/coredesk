import 'package:equatable/equatable.dart';
import 'package:coredesk/core/exceptions/index.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class InitialState extends BaseState {
  const InitialState();
}

class LoadingState extends BaseState {
  const LoadingState();
}

class SuccessState<T> extends BaseState {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ErrorState extends BaseState {
  final AppException error;
  final bool isRetryable;

  const ErrorState(this.error, {this.isRetryable = true});

  @override
  List<Object?> get props => [error, isRetryable];
}

class EmptyState extends BaseState {
  final String message;

  const EmptyState({this.message = 'No data available'});

  @override
  List<Object?> get props => [message];
}

class ListLoadingState<T> extends BaseState {
  final List<T>? previousData;

  const ListLoadingState({this.previousData});

  @override
  List<Object?> get props => [previousData];
}

class PaginatedState<T> extends BaseState {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final bool hasMore;

  const PaginatedState({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [items, currentPage, totalPages, hasMore];
}
