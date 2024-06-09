import 'package:flutter/material.dart';
import 'package:geo_trackermap/screens/MapScreen.dart';
import 'package:geo_trackermap/screens/Podscast.dart';
import 'package:geo_trackermap/screens/RadioFM.dart';
import 'package:geo_trackermap/screens/SplashScreen.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart'; // Importa la biblioteca de just_audio

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo Tracker Map',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(
              imagePath: 'assets/splash.gif',
              duration: Duration(seconds: 4),
            ),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _notchBottomBarController = NotchBottomBarController();
  final _pageController = PageController();
  final AudioPlayer _audioPlayer = AudioPlayer(); // Crea una instancia del AudioPlayer 

  @override
  void dispose() {
    _audioPlayer.dispose(); // se asegura de liberar el recurso cuando HomeScreen se elimine
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          MapScreen(),
          PodscastScreen(audioPlayer: _audioPlayer),
          RadioFMScreen(audioPlayer: _audioPlayer), // Pasa el audioPlayer al RadioFMScreen
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        kIconSize: 24.0,
        kBottomRadius: 16.0,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              'assets/map_icon.svg',
              color: Colors.grey,
            ),
            activeItem: SvgPicture.asset(
              'assets/map_icon.svg',
              color: Colors.blue,
            ),
            itemLabel: 'Map',
          ),
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              'assets/podcast_icon.svg',
              color: Colors.grey,
            ),
            activeItem: SvgPicture.asset(
              'assets/podcast_icon.svg',
              color: Colors.blue,
            ),
            itemLabel: 'Podcast',
          ),
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              'assets/radio_icon.svg',
              color: Colors.grey,
            ),
            activeItem: SvgPicture.asset(
              'assets/radio_icon.svg',
              color: Colors.blue,
            ),
            itemLabel: 'Radio FM',
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}
