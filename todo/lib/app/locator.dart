import 'package:get_it/get_it.dart';

import 'package:todo/services/todos.service.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => TodoService());
}
