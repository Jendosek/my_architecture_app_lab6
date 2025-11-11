import '../../../domain/entities/song.dart';
import '../../../domain/entities/user.dart';

final List<User> mockUsers = [
  User(
    id: '1',
    name: 'Balaker Evgenii',
    email: 'bala01081977@gmail.com',
    avatarUrl: 'assets/images/avatar.png',
    followers: 999,
    following: 52,
  ),
  User(
    id: '2',
    name: 'Test User 2',
    email: 'test2@gmail.com',
    avatarUrl: 'assets/images/avatar.jpg',
    followers: 150,
    following: 30,
  ),
  User(
    id: '3',
    name: 'Test User 3',
    email: 'test3@gmail.com',
    avatarUrl: 'assets/images/avatar.jpg',
    followers: 10,
    following: 1,
  ),
];


final List<Song> mockRecommendedSongs = [
  Song(
    id: 's1',
    title: 'Sisa Rasa',
    artistName: 'Mahalini',
    imageUrl: 'assets/images/song.jpg',
  ),
  Song(
    id: 's2',
    title: 'Arti Untuk Cinta',
    artistName: 'Arsy Widianto',
    imageUrl: 'assets/images/song.jpg',
  ),
  Song(
    id: 's3',
    title: 'Runtuh',
    artistName: 'Feby Putri',
    imageUrl: 'assets/images/song.jpg',
  ),
];

final List<Song> mockMostlyPlayedSongs = [
  Song(
    id: 's4',
    title: 'Dekat Di Hati',
    artistName: 'RAN',
    imageUrl: 'assets/images/song.jpg',
  ),
  Song(
    id: 's5',
    title: 'Bigger Than The Whole...',
    artistName: 'Taylor Swift',
    imageUrl: 'assets/images/song.jpg',
  ),
];