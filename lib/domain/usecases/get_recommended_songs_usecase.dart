import '../entities/song.dart';
import '../repositories/song_repository.dart';

class GetRecommendedSongsUseCase {
  final SongRepository repository;

  GetRecommendedSongsUseCase(this.repository);

  Future<List<Song>> call() async {
    return await repository.getRecommendedSongs();
  }
}