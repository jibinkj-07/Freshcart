
import './imports.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // **************************************** Externals ****************************************
  final auth = FirebaseAuth.instance;
  final db = FirebaseDatabase.instance;
  final storage = FirebaseStorage.instance;

  // Hive Boxes
  final home = await Hive.openBox<String>(HiveBox.themeBox);
  final onboard = await Hive.openBox<bool>(HiveBox.onboardBox);
  final user = await Hive.openBox<UserModel>(HiveBox.userBox);

  sl.registerLazySingleton<FirebaseAuth>(() => auth);
  sl.registerLazySingleton<FirebaseDatabase>(() => db);
  sl.registerLazySingleton<FirebaseStorage>(() => storage);

  sl.registerLazySingleton<Box<String>>(() => home);
  sl.registerLazySingleton<Box<bool>>(() => onboard);
  sl.registerLazySingleton<Box<UserModel>>(() => user);

  // **************************************** Data Sources ****************************************
  sl.registerLazySingleton<ThemeDataSource>(() => ThemeDataSourceImpl(sl()));
  sl.registerLazySingleton<OnboardDataSource>(() => OnboardDataSourceImpl(sl()));
  sl.registerLazySingleton<UserFbDataSource>(() => UserFbDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<UserCacheDataSource>(() => UserCacheDataSourceImpl(sl()));

  // **************************************** Repos ****************************************
  sl.registerLazySingleton<ThemeRepo>(() => ThemeRepoImpl(sl()));
  sl.registerLazySingleton<OnboardRepo>(() => OnboardRepoImpl(sl()));
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(sl(), sl()));

  // **************************************** Bloc ****************************************
  sl.registerSingleton<ThemeBloc>(ThemeBloc(sl()));
  sl.registerSingleton<OnboardBloc>(OnboardBloc(sl()));
  sl.registerSingleton<AuthBloc>(AuthBloc(sl(), sl()));
  sl.registerSingleton<AccountBloc>(AccountBloc(sl(), sl()));
}
