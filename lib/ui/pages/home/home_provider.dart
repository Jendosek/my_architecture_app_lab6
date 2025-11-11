import 'package:flutter/material.dart';
import '../../../di/injection_container.dart';
import '../../../domain/usecases/get_recommended_songs_usecase.dart';
import '../../../domain/entities/song.dart';
import '../../../domain/usecases/get_top_artists_usecase.dart';
import '../../../domain/entities/artist.dart';

class HomeProvider extends ChangeNotifier {
  final GetRecommendedSongsUseCase _getRecommendedSongsUseCase =
      sl<GetRecommendedSongsUseCase>();
  final GetTopArtistsUseCase _getTopArtistsUseCase = sl<GetTopArtistsUseCase>();

  bool _isLoadingSongs = true;
  bool get isLoadingSongs => _isLoadingSongs;
  List<Song> _recommendedSongs = [];
  List<Song> get recommendedSongs => _recommendedSongs;

  bool _isLoadingArtists = true;
  bool get isLoadingArtists => _isLoadingArtists;
  List<Artist> _artists = [];
  List<Artist> get artists => _artists;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  HomeProvider() {
    fetchRecommendedSongs();
  }

  Future<void> fetchRecommendedSongs() async {
    _isLoadingSongs = true;
    _isLoadingArtists = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final futureSongs = _getRecommendedSongsUseCase.call();
      final futureArtists = _getTopArtistsUseCase.call();

      _recommendedSongs = await futureSongs;
      _isLoadingSongs = false;
      notifyListeners();

      _artists = await futureArtists;
      _isLoadingArtists = false;
      notifyListeners();

    } catch (e) {
      _isLoadingSongs = false;
      _isLoadingArtists = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
