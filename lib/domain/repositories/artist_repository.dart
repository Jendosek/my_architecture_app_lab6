import '../entities/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> getTopArtists();
}