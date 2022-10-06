import 'dart:async';
import 'dart:convert';

import 'package:ewatchlist/Classes/abstract_meta.dart';
import 'package:ewatchlist/Classes/movie.dart';
import 'package:ewatchlist/Providers/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}
