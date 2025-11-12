import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_provider.dart';
import '../../providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final authProvider = context.watch<AuthProvider>();

    return SafeArea(
      child: Builder(
        builder: (context) {
          if (profileProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          }
      
          if (profileProvider.errorMessage != null) {
            return Center(
              child: Text(
                'Помилка: ${profileProvider.errorMessage}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
      
          if (authProvider.user == null) {
            return Center(
              child: Text(
                'Не вдалося завантажити профіль',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
      
          final user = authProvider.user!;
          final songs = profileProvider.mostlyPlayedSongs;
      
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              _buildProfileHeader(user),
              SizedBox(height: 24),
              _buildProfileButtons(),
              Divider(color: Colors.grey[800], height: 48),
              _buildSectionHeader('Mostly played'),
              SizedBox(height: 16),
              _buildMostlyPlayedList(songs),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(dynamic user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(user.avatarUrl),
          onBackgroundImageError: (e, s) => {},
        ),
        SizedBox(height: 16),
        Text(
          user.name,
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildProfileStat('Followers', user.followers.toString()),
            _buildProfileStat('Following', user.following.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(icon: Icons.settings, label: 'Settings'),
        _buildActionButton(icon: Icons.share, label: 'Share'),
      ],
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
  
  Widget _buildMostlyPlayedList(List<dynamic> songs) {
    return Column(
      children: songs.map((song) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            song.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (c, o, s) => Icon(Icons.music_note),
          ),
        ),
        title: Text(song.title, style: TextStyle(color: Colors.white)),
        subtitle: Text(song.artistName, style: TextStyle(color: Colors.grey[400])),
        trailing: Icon(Icons.more_vert, color: Colors.white),
      )).toList(),
    );
  }
  
  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
      ],
    );
  }
  
  Widget _buildActionButton({required IconData icon, required String label}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(16),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}