import 'package:ewatchlist/Classes/movie.dart';
import 'package:ewatchlist/Providers/global_variables.dart';
import 'package:ewatchlist/Providers/watchlist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistModel>(builder: (context, watchlist, child) {
      if (watchlist.mode == WatchlistMode.ready) {
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
                body: Center(
                    child: FutureBuilder<List<Movie>>(
                        future: watchlist.loadData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 340 / 510,
                                        crossAxisCount: 2),
                                itemBuilder: ((context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    insetPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    actions: <Widget>[
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        alignment:
                                                            Alignment.center,
                                                        children: <Widget>[
                                                          Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 250,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          15),
                                                                  color:
                                                                      const Color.fromRGBO(
                                                                          54,
                                                                          69,
                                                                          71,
                                                                          1)),
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      20,
                                                                      50,
                                                                      20,
                                                                      20),
                                                              child: Column(
                                                                  children: [
                                                                    const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            bottom:
                                                                                20),
                                                                        child:
                                                                            Text(
                                                                          "Options",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.white),
                                                                        )),
                                                                    ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          shape:
                                                                              MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                          )),
                                                                          foregroundColor: const MaterialStatePropertyAll<Color>(Color.fromRGBO(
                                                                              54,
                                                                              69,
                                                                              79,
                                                                              1)),
                                                                          backgroundColor:
                                                                              const MaterialStatePropertyAll<Color>(Colors.white),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          watchlist.toggleWatched(
                                                                              snapshot.data![index].id.toString(),
                                                                              snapshot.data![index].watched);
                                                                          Navigator.pop(
                                                                              ctx,
                                                                              'Cancel');
                                                                        },
                                                                        child: const Text(
                                                                            "Toggle watch")),
                                                                    ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          shape:
                                                                              MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                          )),
                                                                          foregroundColor: const MaterialStatePropertyAll<Color>(Color.fromRGBO(
                                                                              54,
                                                                              69,
                                                                              79,
                                                                              1)),
                                                                          backgroundColor:
                                                                              const MaterialStatePropertyAll<Color>(Colors.white),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          watchlist.deleteEntry(snapshot
                                                                              .data![index]
                                                                              .id
                                                                              .toString());
                                                                          Navigator.pop(
                                                                              ctx,
                                                                              'Cancel');
                                                                        },
                                                                        child: const Text(
                                                                            "Delete.")),
                                                                  ]))
                                                        ],
                                                      )
                                                    ]);
                                              });
                                        },
                                        child: snapshot.data![index]
                                            .displayThis(
                                                GlobalVariables().card),
                                      ));
                                }));
                          } else {
                            return const CircularProgressIndicator(
                                color: Colors.green);
                          }
                        }))));
      } else if (watchlist.mode == WatchlistMode.not) {
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
                body: Center(
                    child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/settings'),
                        child: const Text("Login to see watchlist!")))));
      } else if (watchlist.mode == WatchlistMode.empty) {
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
                body: const Center(child: Text("Your watchlist is empty!"))));
      } else {
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
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                  ),
                  elevation: 10,
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
                    child: CircularProgressIndicator(
                  color: Colors.red,
                ))));
      }
    });
  }
}
