import './imports.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // **************************************** Bloc ****************************************
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(sl()));
  sl.registerFactory<OnboardBloc>(() => OnboardBloc(sl()));

  // **************************************** Repos ****************************************
  sl.registerLazySingleton<ThemeRepo>(() => ThemeRepoImpl(sl()));
  sl.registerLazySingleton<OnboardRepo>(() => OnboardRepoImpl(sl()));
  // **************************************** Data Sources ****************************************

  sl.registerLazySingleton<ThemeDataSource>(() => ThemeDataSourceImpl(sl()));
  sl.registerLazySingleton<OnboardDataSource>(
      () => OnboardDataSourceImpl(sl()));

  // **************************************** Externals ****************************************
  // final auth = FirebaseAuth.instance;
  // final db = FirebaseFirestore.instance;
  // final storage = FirebaseStorage.instance;

  // Hive Boxes
  final home = await Hive.openBox<ThemeMode>(HiveBox.themeBox);
  final onboard = await Hive.openBox<bool>(HiveBox.onboardBox);

  // sl.registerLazySingleton<FirebaseAuth>(() => auth);
  // sl.registerLazySingleton<FirebaseFirestore>(() => db);
  // sl.registerLazySingleton<FirebaseStorage>(() => storage);

  sl.registerLazySingleton<Box<ThemeMode>>(() => home);
  sl.registerLazySingleton<Box<bool>>(() => onboard);
}
