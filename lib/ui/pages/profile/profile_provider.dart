import 'package:flutter/material.dart';
import '../../../di/injection_container.dart';
import '../../../domain/entities/song.dart';
import '../../../domain/usecases/get_most_played_songs_usecase.dart';

class ProfileProvider extends ChangeNotifier {
  final GetMostPlayedSongsUseCase _getMostPlayedSongsUseCase = sl<GetMostPlayedSongsUseCase>();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Song> _mostlyPlayedSongs = [];
  List<Song> get mostlyPlayedSongs => _mostlyPlayedSongs;

  ProfileProvider() {
    fetchMostlyPlayedSongs();
  }

  Future<void> fetchMostlyPlayedSongs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _mostlyPlayedSongs = await _getMostPlayedSongsUseCase.call();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}