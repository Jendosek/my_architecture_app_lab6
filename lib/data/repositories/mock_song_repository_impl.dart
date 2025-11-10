import '../../domain/repositories/song_repository.dart';
import '../../domain/entities/song.dart';
import '../datasources/local/mock_db.dart';

class MockSongRepositoryImpl implements SongRepository {
  @override
  Future<List<Song>> getMostPlayedSongs() async {
    await Future.delayed(Duration(seconds: 1));
    return mockMostlyPlayedSongs;
  }

  @override
  Future<List<Song>> getRecommendedSongs() async {
    await Future.delayed(Duration(seconds: 1));
    return mockRecommendedSongs;
  }

}