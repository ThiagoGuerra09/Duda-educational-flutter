import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/home/domain/entities/home_data.dart';
import 'package:duda_educational_flutter/features/home/domain/usecases/get_home_data.dart';
import 'package:duda_educational_flutter/features/home/presentation/cubit/home_cubit.dart';
import 'package:duda_educational_flutter/features/home/presentation/cubit/home_state.dart';

class MockGetHomeData extends Mock implements GetHomeData {}

void main() {
  late MockGetHomeData getHomeData;
  late HomeCubit cubit;

  const homeData = HomeData(
    professorName: 'Thiago',
    initials: 'L',
    welcomeMessage: 'Facilitador do seu dia a dia',
    subjects: [],
    quickAccess: [],
    pendingAssignments: 2,
    unreadNotifications: 1,
  );

  setUp(() {
    getHomeData = MockGetHomeData();
    cubit = HomeCubit(getHomeData);
  });

  tearDown(() => cubit.close());

  test('initial state is HomeState.initial', () {
    expect(cubit.state, const HomeState.initial());
  });

  blocTest<HomeCubit, HomeState>(
    'emits loaded when getHomeData succeeds',
    build: () {
      when(() => getHomeData()).thenAnswer((_) async => homeData);
      return cubit;
    },
    act: (c) => c.loadHome(),
    expect: () => [
      const HomeState.loading(),
      const HomeState.loaded(homeData),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits failure when getHomeData throws Failure',
    build: () {
      when(() => getHomeData()).thenThrow(const ServerFailure('Erro'));
      return cubit;
    },
    act: (c) => c.loadHome(),
    expect: () => [
      const HomeState.loading(),
      const HomeState.failure('Erro'),
    ],
  );
}
