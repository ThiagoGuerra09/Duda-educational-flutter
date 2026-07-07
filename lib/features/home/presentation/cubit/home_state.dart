import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/home/domain/entities/home_data.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.data,
    this.errorMessage,
  });

  const HomeState.initial() : this();

  const HomeState.loading() : this(status: HomeStatus.loading);

  const HomeState.loaded(HomeData data)
      : this(status: HomeStatus.loaded, data: data);

  const HomeState.failure(String message)
      : this(status: HomeStatus.failure, errorMessage: message);

  final HomeStatus status;
  final HomeData? data;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, data, errorMessage];
}
