import 'package:ewatchlist/Providers/hero_section_model.dart';
import 'package:ewatchlist/Providers/search_model.dart';
import 'package:ewatchlist/Providers/settings_model.dart';
import 'package:ewatchlist/Providers/watchlist_model.dart';
import 'package:ewatchlist/Widgets/hero_section.dart';
import 'package:ewatchlist/Widgets/search.dart';
import 'package:ewatchlist/Widgets/settings.dart';
import 'package:ewatchlist/Widgets/watchlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "EWatchlist",
        theme: ThemeData(fontFamily: 'Oswald'),
        initialRoute: '/settings',
        routes: {
          // '/': (context) => ChangeNotifierProvider(
          //     create: (context) => HeroSectionModel(), child: const HeroSection()),
          // '/watchlist': (context) => ChangeNotifierProvider(
          //     create: (context) => WatchlistModel(), child: const Watchlist()),
          '/settings': (context) => ChangeNotifierProvider(
              create: (context) => SettingsModel(), child: const Settings()),
          '/search': (context) => ChangeNotifierProvider(
              create: (context) => SearchModel(), child: Search())
        });
  }
}
