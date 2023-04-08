import 'package:get_it/get_it.dart';

import 'app_model.dart';

// ambient variable to access the service locator

GetIt locator = GetIt.instance;

void serviceLocatorSetup() {
  locator.registerSingleton<AppModel>(new AppModel());
}
