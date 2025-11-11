import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';
import '../../../domain/entities/song.dart';
import '../../../domain/entities/artist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    if (homeProvider.isLoadingSongs) {
      return Center(child: CircularProgressIndicator(color: Colors.purple));
    }

    if (homeProvider.errorMessage != null &&
        homeProvider.recommendedSongs.isEmpty) {
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
        _buildCategoryTabs(),
        SizedBox(height: 24),
        _buildTabContent(homeProvider),
      ],
    );
  }

  // =Checklist:
  // 1. Domain: Artist entity, Artist repo, GetArtists usecase
  // 2. Data: mockArtists in mock_db, MockArtistRepoImpl
  // 3. DI: Register new repo and usecase
  // 4. Provider: Update HomeProvider to fetch artists
  // 5. UI: Convert HomePage to Stateful, add _selectedTabIndex, implement TabBar, display artists

  Widget _buildCategoryTabs() {
    final List<String> tabs = ['Artists', 'Album', 'Podcast'];

    return Container(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final bool isActive = _selectedTabIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[600],
                  fontSize: 18,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabContent(HomeProvider provider) {
    if (_selectedTabIndex == 0) {
      if (provider.isLoadingArtists) {
        return Center(
          heightFactor: 5,
          child: CircularProgressIndicator(color: Colors.purple),
        );
      }
      if (provider.errorMessage != null && provider.artists.isEmpty) {
        return Center(
          child: Text(
            'Помилка завантаження артистів',
            style: TextStyle(color: Colors.red),
          ),
        );
      }
      return _buildArtistsList(provider.artists);
    } else if (_selectedTabIndex == 1) {
      return Center(
        heightFactor: 10,
        child: Text('Альбоми (TODO)', style: TextStyle(color: Colors.grey)),
      );
    } else {
      return Center(
        heightFactor: 10,
        child: Text('Подкасти (TODO)', style: TextStyle(color: Colors.grey)),
      );
    }
  }

  Widget _buildArtistsList(List<Artist> artists) {
    return Column(
      children: artists.map((artist) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(artist.avatarUrl),
            onBackgroundImageError: (e, s) => {},
          ),
          title: Text(
            artist.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${artist.monthlyListeners} monthly listeners',
            style: TextStyle(color: Colors.grey[400]),
          ),
          trailing: Icon(Icons.chevron_right, color: Colors.white),
        );
      }).toList(),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
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
}
