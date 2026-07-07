import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/classes/domain/usecases/get_class_detail.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/class_detail_state.dart';

@injectable
class ClassDetailCubit extends Cubit<ClassDetailState> {
  ClassDetailCubit(this._getClassDetail) : super(const ClassDetailState.initial());

  final GetClassDetail _getClassDetail;

  Future<void> loadDetail(String id) async {
    emit(const ClassDetailState.loading());
    try {
      final detail = await _getClassDetail(id);
      emit(ClassDetailState.success(detail));
    } on ServerException catch (e) {
      emit(ClassDetailState.failure(e.message));
    } on Failure catch (e) {
      emit(ClassDetailState.failure(e.message));
    } catch (e) {
      emit(ClassDetailState.failure(e.toString()));
    }
  }
}
