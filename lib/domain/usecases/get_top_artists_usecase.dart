import '../entities/artist.dart';
import '../repositories/artist_repository.dart';

class GetTopArtistsUseCase {
  final ArtistRepository repository;

  GetTopArtistsUseCase(this.repository);

  Future<List<Artist>> call() async {
    return await repository.getTopArtists();
  }
}