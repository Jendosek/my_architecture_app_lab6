import '../../domain/repositories/artist_repository.dart';
import '../../domain/entities/artist.dart';
import '../datasources/local/mock_db.dart';

class MockArtistRepositoryImpl implements ArtistRepository {
  @override
  Future<List<Artist>> getTopArtists() async {
    await Future.delayed(Duration(seconds: 1));
    return mockArtists;
  }
}