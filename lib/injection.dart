import 'package:daily_us/common/secrets.dart';
import 'package:daily_us/data/datasources/daily_us_local_cache_data_source.dart';
import 'package:daily_us/data/datasources/daily_us_remote_data_source.dart';
import 'package:daily_us/data/datasources/local/local_cache_client.dart';
import 'package:daily_us/data/datasources/remote/api_client.dart';
import 'package:daily_us/data/repositories/daily_us_repository_impl.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:daily_us/domain/usecases/get_all_stories.dart';
import 'package:daily_us/domain/usecases/get_auth_info.dart';
import 'package:daily_us/domain/usecases/get_detail_story.dart';
import 'package:daily_us/domain/usecases/login.dart';
import 'package:daily_us/domain/usecases/logout.dart';
import 'package:daily_us/domain/usecases/register.dart';
import 'package:daily_us/domain/usecases/upload_new_story.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  var pref = await SharedPreferences.getInstance();
  var appSecret = await AppSecretLoader.load();

  // client
  locator.registerLazySingleton<DailyUsLocalCacheClient>(
    () => DailyUsLocalCacheClient(pref: pref),
  );

  locator.registerLazySingleton<Dio>(
    () => DailyUsApiClient.getInstance(appSecret),
  );

  // data source
  locator.registerLazySingleton<DailyUsLocalCacheDataSource>(
    () => DailyUsLocalCacheDataSourceImpl(localCacheClient: locator()),
  );
  locator.registerLazySingleton<DailyUsRemoteDataSource>(
    () => DailyUsRemoteDataSourceImpl(apiClient: locator()),
  );

  // repositories
  locator.registerLazySingleton<DailyUsRepository>(
    () => DailyUsRepositoryImpl(
      remoteDataSource: locator(),
      localCacheDataSource: locator(),
    ),
  );

  // usecases
  locator.registerLazySingleton<GetAllStories>(
    () => GetAllStories(locator()),
  );
  locator.registerLazySingleton<GetAuthInfo>(
    () => GetAuthInfo(locator()),
  );
  locator.registerLazySingleton<GetDetailStory>(
    () => GetDetailStory(locator()),
  );
  locator.registerLazySingleton<Login>(
    () => Login(locator()),
  );
  locator.registerLazySingleton<Logout>(
    () => Logout(locator()),
  );
  locator.registerLazySingleton<Register>(
    () => Register(locator()),
  );
  locator.registerLazySingleton<UploadNewStory>(
    () => UploadNewStory(locator()),
  );
}
