import 'package:ewatchlist/Providers/watchlist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistModel>(builder: (context, watchlist, child) {
      return MaterialApp();
    });
  }
}
