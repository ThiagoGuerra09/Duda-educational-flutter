import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/classes/domain/usecases/get_classes.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/classes_state.dart';

@injectable
class ClassesCubit extends Cubit<ClassesState> {
  ClassesCubit(this._getClasses) : super(const ClassesState.initial());

  final GetClasses _getClasses;

  Future<void> loadClasses() async {
    emit(const ClassesState.loading());
    try {
      final classes = await _getClasses();
      emit(ClassesState.success(classes));
    } on ServerException catch (e) {
      emit(ClassesState.failure(e.message));
    } on Failure catch (e) {
      emit(ClassesState.failure(e.message));
    } catch (e) {
      emit(ClassesState.failure(e.toString()));
    }
  }
}
