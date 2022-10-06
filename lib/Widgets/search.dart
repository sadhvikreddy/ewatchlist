import 'package:ewatchlist/Classes/abstract_meta.dart';
import 'package:ewatchlist/Classes/movie.dart';
import 'package:ewatchlist/Providers/global_variables.dart';
import 'package:ewatchlist/Providers/search_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final GlobalVariables variables = GlobalVariables();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, search, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  onChanged: (value) {
                    search.setSearchTerm(value);
                    search.flipStatus();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(54, 68, 79, 1)),
                    ),
                    labelText: 'Search',
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: -10,
                            title: const Text(
                              'Movies',
                              style: TextStyle(
                                  color: Color.fromRGBO(54, 68, 79, 1)),
                            ),
                            leading: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                (states) => const Color.fromRGBO(54, 68, 79, 1),
                              ),
                              value: MediaType.movie,
                              groupValue: search.mt,
                              onChanged: (MediaType? value) {
                                search.setMediaType(value!);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: -10,
                            title: const Text(
                              'TV Show',
                              style: TextStyle(
                                  color: Color.fromRGBO(54, 68, 79, 1)),
                            ),
                            leading: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromRGBO(54, 68, 79, 1)),
                              value: MediaType.tv,
                              groupValue: search.mt,
                              onChanged: (MediaType? value) {
                                search.setMediaType(value!);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: -10,
                            title: const Text(
                              'Anime',
                              style: TextStyle(
                                  color: Color.fromRGBO(54, 68, 79, 1)),
                            ),
                            leading: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromRGBO(54, 68, 79, 1)),
                              value: MediaType.anime,
                              groupValue: search.mt,
                              onChanged: (MediaType? value) {
                                search.setMediaType(value!);
                              },
                            ),
                          ),
                        )
                      ])),
              Center(
                child: search.status ? const CircularProgressIndicator() : null,
              ),
              // Padding(
              //     padding: const EdgeInsets.all(5),
              //     child: ElevatedButton(
              //         onPressed: search.handleSearch,
              //         child: const Text("Search"))),
              FutureBuilder<List<AbstractMeta>>(
                  future: search.fmovieList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  search.showItem(snapshot.data![index].id);
                                  showMaterialModalBottomSheet(
                                      backgroundColor: Colors.grey,
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  color: Colors.grey,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(children: [
                                                    FutureBuilder<Movie>(
                                                      future: search.movieData,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData &&
                                                            snapshot.connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                          return snapshot.data!
                                                              .displayThis(
                                                                  variables
                                                                      .full);
                                                        } else {
                                                          return Image.asset(
                                                              'assets/images/posterPlace.png');
                                                        }
                                                      },
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              style:
                                                                  ButtonStyle(
                                                                      backgroundColor: const MaterialStatePropertyAll<
                                                                              Color>(
                                                                          Colors
                                                                              .white),
                                                                      foregroundColor:
                                                                          const MaterialStatePropertyAll<Color>(Color.fromRGBO(
                                                                              54,
                                                                              69,
                                                                              79,
                                                                              1)),
                                                                      shape: MaterialStatePropertyAll<
                                                                              RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(25),
                                                                      ))),
                                                              child: Row(
                                                                children: const [
                                                                  BackButtonIcon(),
                                                                  Text("Back")
                                                                ],
                                                              )),
                                                          ElevatedButton(
                                                              onPressed: () {},
                                                              style:
                                                                  ButtonStyle(
                                                                      backgroundColor: const MaterialStatePropertyAll<
                                                                              Color>(
                                                                          Colors
                                                                              .white),
                                                                      foregroundColor: const MaterialStatePropertyAll<
                                                                              Color>(
                                                                          Color.fromRGBO(
                                                                              54,
                                                                              69,
                                                                              79,
                                                                              1)),
                                                                      shape: MaterialStatePropertyAll<
                                                                              RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(25),
                                                                      ))),
                                                              child: Row(
                                                                children: const [
                                                                  Icon(Icons
                                                                      .bookmark_add),
                                                                  Text(
                                                                      "Add to watchlist")
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    )
                                                  ]))
                                            ]);
                                      });
                                },
                                child: snapshot.data![index].display());
                          },
                        ));
                      } else {
                        return const Text(
                          "No data found. please try again",
                          style: TextStyle(fontSize: 16),
                        );
                      }
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.pink,
                      ));
                    }
                  })
            ],
          ),
        ),
      );
    });
  }
}
