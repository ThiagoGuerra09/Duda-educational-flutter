import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/app.dart';
import 'package:duda_educational_flutter/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(DudaApp(router: getIt<GoRouter>()));
}
