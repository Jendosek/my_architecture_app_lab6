import '../entities/song.dart';
import '../repositories/song_repository.dart';

class GetMostPlayedSongsUseCase {
  final SongRepository repository;

  GetMostPlayedSongsUseCase(this.repository);

  Future<List<Song>> call() async {
    return await repository.getMostPlayedSongs();
  }
}