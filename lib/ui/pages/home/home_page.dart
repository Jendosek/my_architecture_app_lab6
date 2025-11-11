import 'package:flutter/material.dart';
import 'package:my_architecture_app/ui/pages/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Musify 🎵'),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline), // Іконка профілю
            onPressed: () {
              // Логіка навігації при натисканні
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: _buildBody(context, homeProvider), 
    );
  }

  Widget _buildBody(BuildContext context, HomeProvider provider) {
    if (provider.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.purple),
      );
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Text(
          'Сталася помилка: ${provider.errorMessage}',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return ListView.builder(
      itemCount: provider.recommendedSongs.length,
      itemBuilder: (context, index) {
        final song = provider.recommendedSongs[index];
        
        return ListTile(
          leading: Image.asset(
            song.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (c, o, s) => Icon(Icons.music_note),
          ),
          title: Text(song.title, style: TextStyle(color: Colors.white)),
          subtitle: Text(song.artistName, style: TextStyle(color: Colors.grey[400])),
        );
      },
    );
  }
}
