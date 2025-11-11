import 'package:flutter/material.dart';
import '../../../di/injection_container.dart';
import '../../../domain/usecases/get_recommended_songs_usecase.dart';
import '../../../domain/entities/song.dart';

class HomeProvider extends ChangeNotifier {
  final GetRecommendedSongsUseCase _getRecommendedSongsUseCase =
      sl<GetRecommendedSongsUseCase>();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Song> _recommendedSongs = [];
  List<Song> get recommendedSongs => _recommendedSongs;

  HomeProvider() {
    fetchRecommendedSongs();
  }

  Future<void> fetchRecommendedSongs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final songs = await _getRecommendedSongsUseCase.call();
      _recommendedSongs = songs;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
