import 'package:get_it/get_it.dart';

import '../domain/repositories/user_repository.dart';
import '../data/repositories/mock_user_repository_impl.dart';
import '../domain/repositories/song_repository.dart';
import '../data/repositories/mock_song_repository_impl.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/get_user_usecase.dart';
import '../domain/usecases/get_most_played_songs_usecase.dart';
import '../domain/usecases/get_recommended_songs_usecase.dart';

final sl = GetIt.instance;

void initDependencyInjection() {
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => GetMostPlayedSongsUseCase(sl()));
  sl.registerLazySingleton(() => GetRecommendedSongsUseCase(sl()));

  sl.registerLazySingleton<UserRepository>(() => MockUserRepositoryImpl());
  sl.registerLazySingleton<SongRepository>(() => MockSongRepositoryImpl());
}