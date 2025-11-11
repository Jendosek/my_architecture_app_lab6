import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. "Слухаємо" ProfileProvider
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: _buildBody(context, profileProvider), // Виносимо логіку
    );
  }

  Widget _buildBody(BuildContext context, ProfileProvider provider) {
    // 2. Стан Завантаження
    if (provider.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.purple),
      );
    }

    // 3. Стан Помилки
    if (provider.errorMessage != null) {
      return Center(
        child: Text(
          'Сталася помилка: ${provider.errorMessage}',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    // 4. Стан Успіху (але якщо юзер чомусь null)
    if (provider.user == null) {
      return Center(
        child: Text(
          'Не вдалося завантажити профіль',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // 5. Стан Успіху (Все Ок)
    final user = provider.user!; // Ми знаємо, що user не null

    return ListView( // ListView, щоб можна було скролити
      padding: EdgeInsets.all(16.0),
      children: [
        // --- Блок Профілю ---
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(user.avatarUrl), // Використовуємо asset
            onBackgroundImageError: (e, s) => {}, // Обробка помилки (якщо asset не знайдено)
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            user.name,
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            user.email,
            style: TextStyle(color: Colors.grey[400], fontSize: 16),
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildProfileStat('Followers', user.followers.toString()),
            _buildProfileStat('Following', user.following.toString()),
          ],
        ),
        Divider(color: Colors.grey[700], height: 48), // Розділювач

        // --- Блок "Mostly Played" ---
        Text(
          'Mostly played',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ...provider.mostlyPlayedSongs.map((song) => ListTile(
              leading: Image.asset(
                song.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (c, o, s) => Icon(Icons.music_note),
              ),
              title: Text(song.title, style: TextStyle(color: Colors.white)),
              subtitle: Text(song.artistName, style: TextStyle(color: Colors.grey[400])),
            )),
      ],
    );
  }

  // Маленький віджет-хелпер для статистики профілю
  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
      ],
    );
  }
}