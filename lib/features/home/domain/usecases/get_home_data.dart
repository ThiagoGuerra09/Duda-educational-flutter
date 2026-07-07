import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/home/domain/entities/home_data.dart';
import 'package:duda_educational_flutter/features/home/domain/repositories/home_repository.dart';

@injectable
class GetHomeData {
  const GetHomeData(this._repository);

  final HomeRepository _repository;

  Future<HomeData> call() => _repository.getHomeData();
}
