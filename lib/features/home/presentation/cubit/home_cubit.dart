import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/home/domain/usecases/get_home_data.dart';
import 'package:duda_educational_flutter/features/home/presentation/cubit/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeData) : super(const HomeState.initial());

  final GetHomeData _getHomeData;

  Future<void> loadHome({bool refresh = false}) async {
    if (!refresh) emit(const HomeState.loading());
    try {
      final data = await _getHomeData();
      emit(HomeState.loaded(data));
    } on Failure catch (e) {
      emit(HomeState.failure(e.message));
    } catch (e) {
      emit(HomeState.failure(e.toString()));
    }
  }
}
