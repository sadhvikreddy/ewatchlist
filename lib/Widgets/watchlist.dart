import 'package:ewatchlist/Providers/watchlist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistModel>(builder: (context, watchlist, child) {
      return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'assets/images/logo.png',
                width: 75,
                height: 75,
              ),
              toolbarHeight: 100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              elevation: 5,
              backgroundColor: const Color.fromRGBO(54, 68, 79, 0.8),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: IconButton(
                        iconSize: 50,
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        icon: const Icon(Icons.account_circle_sharp)))
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              backgroundColor: const Color.fromRGBO(54, 68, 79, 0.8),
              label: const Text('Search'),
              icon: const Icon(Icons.search),
            ),
            body: const Center(
              child: Text("Hello"),
            )),
      );
    });
  }
}
