import 'package:duda_educational_flutter/features/home/domain/entities/home_data.dart';

abstract class HomeRepository {
  Future<HomeData> getHomeData();
}
