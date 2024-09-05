import 'package:detectionApp/services/local_storage_service.dart';
import 'package:detectionApp/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

import '../shared/network/api.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocator() async {
  var localStorageInstance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageInstance);
  var apiInterceptor = ApiIntercetor();
  apiInterceptor.initApiService();
  locator.registerSingleton<ApiIntercetor>(apiInterceptor);

  //locator.registerSingleton<AuthRepository>(AuthRepository());
  locator.registerLazySingleton(() => NavigationService());

  //locator.registerSingleton<GlobalAppCubit>(GlobalAppCubit());
}
