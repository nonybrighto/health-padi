

import 'package:get_it/get_it.dart';
import 'package:healthpadi/services/remote/news_remote.dart';

GetIt locator = GetIt.instance;


setUpLocator(){
  locator.registerLazySingleton<NewsRemote>(() => NewsRemote());
}
