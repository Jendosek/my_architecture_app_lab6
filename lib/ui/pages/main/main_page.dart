import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),      
    PlaceholderWidget('Playlist'), 
    PlaceholderWidget('Player'),   
    PlaceholderWidget('History'),  
    ProfilePage(),    
  ];

  AppBar? _buildAppBar() {
    if (_currentIndex == 0) {
      return AppBar(
        title: Text('Musify 🎵', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.search, size: 28),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, size: 28),
            onPressed: () {},
          ),
        ],
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: _pages[_currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFF8A2BE2),
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Playlist'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// Це просто "заглушка" для сторінок, яких у нас ще немає
class PlaceholderWidget extends StatelessWidget {
  final String text;
  const PlaceholderWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 30)),
    );
  }
}