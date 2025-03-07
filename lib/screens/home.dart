import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _thoughtsController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int currentSongIndex = 0;

  // 🎵 List of Music Links (Replace YOUR_FILE_ID with actual IDs)
  final List<String> songs = [
    "https://drive.google.com/uc?export=download&id=1zNGfw7ZUYt-B2xchxpR80llgTVOgDlET",
    "https://drive.google.com/uc?export=download&id=1xIevmnf47W-wRX9ovCTeQBhS6XIo8e8F",
    "https://drive.google.com/uc?export=download&id=1glMmRDWjmiK7_5qJp1k7WpSwSZAIGZZu",
    "https://drive.google.com/uc?export=download&id=1ewP5LgqIh9Jl2rYEkRRMb8_TxW-6N0Xx",
    "https://drive.google.com/uc?export=download&id=1O1ceMylGzKb6Ac61E573Ys2d9lIIr0M1",
    "https://drive.google.com/uc?export=download&id=1tIwDcoAn4L73c2R3PoyCDDtmqBXAhWof",
  ];

  // 🎶 Play Current Song
  Future<void> playCalmMusic() async {
    try {
      await _audioPlayer.play(UrlSource(songs[currentSongIndex]));
      setState(() => isPlaying = true);
    } catch (e) {
      print("Error playing music: $e");
    }
  }

  // ⏸ Pause Music
  Future<void> pauseMusic() async {
    try {
      await _audioPlayer.pause();
      setState(() => isPlaying = false);
    } catch (e) {
      print("Error pausing music: $e");
    }
  }

  // ⏭ Play Next Song
  Future<void> playNextSong() async {
    if (currentSongIndex < songs.length - 1) {
      setState(() => currentSongIndex++);
    } else {
      setState(() => currentSongIndex = 0);
    }
    await playCalmMusic();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mind Connect")),
      drawer: AppSidebar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📝 Thoughts Section
              Text("Express Your Feelings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _thoughtsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write your thoughts here...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 16),

              // 📌 Feature Boxes
              Row(
                children: [
                  Expanded(
                    child: _featureBox(
                        "Talk to a Doctor", Icons.local_hospital, Colors.blue,
                        () {
                      Navigator.pushNamed(context, "/doctors_list");
                    }),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _featureBox(
                        "Mental Health Resources", Icons.book, Colors.green,
                        () {
                      Navigator.pushNamed(context, "/resources");
                    }),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _featureBox(
                        "Track Your Mood", Icons.mood, Colors.orange, () {
                      Navigator.pushNamed(context, "/mood_tracker");
                    }),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _featureBox(
                        "Self-care Routine", Icons.accessibility, Colors.purple,
                        () {
                      Navigator.pushNamed(context, "/routine");
                    }),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 🎵 Play a Music Section
              Text("Play Calming Music",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Icon(Icons.music_note, color: Colors.blue),
                  title: Text("Relaxing Playlist"),
                  subtitle: Text("Tap to play/pause music"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: isPlaying ? pauseMusic : playCalmMusic,
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        onPressed: playNextSong,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Feature Boxes
  Widget _featureBox(
      String title, IconData icon, Color color, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
