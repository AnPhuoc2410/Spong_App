import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/model/song.dart';
import '../../ui/discovery/discovery.dart';
import '../../ui/home/viewmodel.dart';
import '../../ui/settings/settings.dart';
import '../../ui/user/user.dart';

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const SettingTab(),
    const AccountTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                CupertinoIcons.music_note_2,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Spong Music',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        border: const Border(bottom: BorderSide.none),
        trailing: GestureDetector(
          onTap: () {
            // TODO: Navigate to search page
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: const Color(0xFF1A1A1A),
          activeColor: const Color(0xFF6366F1),
          inactiveColor: Colors.grey,
          border: const Border(
            top: BorderSide(color: Color(0xFF2A2A2A), width: 0.5),
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              activeIcon: Icon(CupertinoIcons.house_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.compass),
              activeIcon: Icon(CupertinoIcons.compass_fill),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              activeIcon: Icon(CupertinoIcons.settings_solid),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              activeIcon: Icon(CupertinoIcons.person_fill),
              label: 'Profile',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;
  late StreamSubscription<List<Song>> _songSubscription;

  @override
  void initState() {
    super.initState();
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
  }

  @override
  void dispose() {
    _songSubscription.cancel();
    super.dispose();
  }

  void observeData() {
    _songSubscription = _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs = songList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      child: SafeArea(child: Material(child: getBody())),
    );
  }

  Widget getBody() {
    if (songs.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(color: Colors.white, radius: 16),
      );
    } else {
      return getListView();
    }
  }

  Widget getListView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: songs.length,
      separatorBuilder: (context, index) => const Divider(
        color: Color(0xFF2A2A2A),
        thickness: 0.6,
        indent: 72,
        endIndent: 16,
      ),
      itemBuilder: (context, index) => getRow(index),
    );
  }

  Widget getRow(int i) {
    final song = songs[i];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(song.image),
        radius: 26,
        backgroundColor: const Color(0xFF2A2A2A),
      ),
      title: Text(
        song.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        song.artist,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      ),
      trailing: const Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Colors.white,
        size: 20,
      ),
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Selected: ${song.title}")));
      },
    );
  }
}
