
import './imports.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // **************************************** Bloc ****************************************
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(sl()));

  // **************************************** Repos ****************************************
  sl.registerLazySingleton<ThemeRepo>(() => ThemeRepoImpl(sl()));
  // **************************************** Data Sources ****************************************

  sl.registerLazySingleton<ThemeDataSource>(() => ThemeDataSourceImpl(sl()));

  // **************************************** Externals ****************************************
  // final auth = FirebaseAuth.instance;
  // final db = FirebaseFirestore.instance;
  // final storage = FirebaseStorage.instance;

  // Hive Boxes
  final home = await Hive.openBox<ThemeMode>(HiveBox.themeBox);

  // sl.registerLazySingleton<FirebaseAuth>(() => auth);
  // sl.registerLazySingleton<FirebaseFirestore>(() => db);
  // sl.registerLazySingleton<FirebaseStorage>(() => storage);

  sl.registerLazySingleton<Box<ThemeMode>>(() => home);
}
