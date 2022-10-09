import 'dart:async';
import 'dart:convert';

import 'package:ewatchlist/Classes/abstract_meta.dart';
import 'package:ewatchlist/Classes/movie.dart';
import 'package:ewatchlist/Providers/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

enum MediaType { movie, tv, anime }

class SearchModel extends ChangeNotifier {
  String _searchterm = "";
  // ignore: prefer_final_fields
  String _pterm = "";
  final GlobalVariables _variables = GlobalVariables();
  late Future<List<AbstractMeta>> fmovieList = apiCall();
  bool status = false;
  late Future<Movie> movieData;
  bool dataLoaded = false;
  MediaType mt = MediaType.movie;
  MediaType pmt = MediaType.movie;

  String get searchTerm => _searchterm;

  SearchModel() {
    const timeDelay = Duration(seconds: 5);
    Timer.periodic(timeDelay, (Timer t) {
      handleSearch();
      status = false;
    });
  }

  Future<Movie> getData(int id) async {
    String query = "movies";
    Color cc = const Color(0xFF808000);
    if (mt == MediaType.tv) {
      query = "tv";
      cc = Colors.purple;
    } else if (mt == MediaType.anime) {
      query = "anime";
      cc = Colors.blue;
    }
    String cid = _variables.clientID;
    String uri =
        'https://api.simkl.com/$query/$id?client_id=$cid&extended=full';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String? imgUrl = data['poster'] ?? 'a';
      String posterUrl = "Nothing";
      if (imgUrl != 'a') {
        posterUrl = "https://simkl.in/posters/${imgUrl}_m.jpg";
      }
      return Movie.fullJson(data, posterUrl, cc);
    } else {
      throw Exception("Failed to load");
    }
  }

  void showItem(int id) {
    movieData = getData(id);
    notifyListeners();
  }

  void flipStatus() {
    status = !status;
    notifyListeners();
  }

  void setSearchTerm(String s) {
    _searchterm = s;
    notifyListeners();
  }

  void resetTerms() {
    _pterm = _searchterm;
    pmt = mt;
  }

  void handleSearch() {
    if (_searchterm != _pterm || pmt != mt) {
      fmovieList = apiCall();
      resetTerms();
      status = true;
    }
    notifyListeners();
  }

  void setMediaType(MediaType value) {
    mt = value;
    notifyListeners();
  }

  void bundleForDb(BuildContext bcontext, String uid) {
    Movie s;
    movieData.then((value) {
      s = value;
      if (mt == MediaType.movie) {
        s.setType("movie");
      } else if (mt == MediaType.tv) {
        s.setType("tv");
      } else {
        s.setType("anime");
      }

      CollectionReference watchlists =
          FirebaseFirestore.instance.collection('watchlists');
      watchlists.doc(uid).collection('medialist').doc(s.id.toString()).set({
        "id": s.id,
        "title": s.title,
        "year": s.year,
        "overview": s.overview,
        "watched": false,
        "poster": s.posterUrl,
        "type": s.type
      }).then((value) {
        showDialog(
            context: bcontext,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Success"),
                content: Text("${s.title} added to your watchlist"),
                actions: <Widget>[
                  TextButton(
                      onPressed: (() => Navigator.pop(context, "Done")),
                      child: const Text("Done"))
                ],
              );
            });
      }).catchError((error) {
        showDialog(
            context: bcontext,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Fail"),
                content: Text("Following error occured: ${error.toString()}"),
                actions: <Widget>[
                  TextButton(
                      onPressed: (() => Navigator.pop(context, "Done")),
                      child: const Text("Done"))
                ],
              );
            });
      });
    });
  }

  Future<List<AbstractMeta>> apiCall() async {
    String query = "movie";
    if (mt == MediaType.tv) {
      query = "tv";
    } else if (mt == MediaType.anime) {
      query = "anime";
    }
    String cid = _variables.clientID;
    String uri =
        'https://api.simkl.com/search/$query?q=$_searchterm&client_id=$cid&limit=50';
    uri = uri.replaceAll(" ", "%20");
    final response = await http.get(Uri.parse(uri));
    List<AbstractMeta> movieList = [];
    if (response.statusCode == 200) {
      List<dynamic> jsonRes = jsonDecode(response.body);
      for (Map<String, dynamic> item in jsonRes) {
        movieList.add(AbstractMeta.fromJson(item));
      }
      return movieList;
    } else {
      throw Exception("Failed to load");
    }
  }

  void addToWatchlist(BuildContext bcontext) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String uid = user.uid.toString();
      bundleForDb(bcontext, uid);
    } else {
      showDialog(
          context: bcontext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("NO USER LOGIN!"),
              content: const Text("You must be logged in to add watchlist."),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Later')),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    child: const Text('Sign In')),
              ],
            );
          });
    }
  }
}
