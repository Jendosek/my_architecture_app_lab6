import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';
import '../../../domain/entities/song.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Builder(
      builder: (context) {
        if (homeProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        }

        if (homeProvider.errorMessage != null) {
          return Center(
            child: Text(
              'Помилка: ${homeProvider.errorMessage}',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            _buildPopularBanner(),
            SizedBox(height: 24),
            _buildSectionHeader('Recommendation'),
            SizedBox(height: 16),
            _buildRecommendations(homeProvider.recommendedSongs),
            SizedBox(height: 24),
            _buildCategoryTabs(), // TODO: Artists, Album, Podcast
            SizedBox(height: 24),
            _buildArtistsList(), // TODO: Наповнити даними
          ],
        );
      },
    );
  }
  
  Widget _buildPopularBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '"Sisa Rasa" Banner (TODO)',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRecommendations(List<Song> songs) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Container(
            width: 140,
            margin: EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    song.imageUrl,
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (c, o, s) => Container(
                      width: 140,
                      height: 140,
                      color: Colors.grey[800],
                      child: Icon(Icons.music_note, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  song.title,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artistName,
                  style: TextStyle(color: Colors.grey[400]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryTabs() {
    // TODO: Це має бути TabBar
    return Container(
      child: Text(
        'Artists   Album   Podcast   (TODO: Tabs)',
        style: TextStyle(color: Colors.grey[600], fontSize: 16),
      ),
    );
  }
  
  Widget _buildArtistsList() {
    // TODO: Наповнити даними з нового провайдера/юзкейсу
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
          ),
          title: Text('Adele', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text('43,877,516 monthly listeners', style: TextStyle(color: Colors.grey[400])),
          trailing: Icon(Icons.chevron_right, color: Colors.white),
        ),
      ],
    );
  }
}
