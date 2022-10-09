import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewatchlist/Classes/movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum WatchlistMode { loading, empty, not, ready }

class WatchlistModel extends ChangeNotifier {
  WatchlistMode mode = WatchlistMode.loading;
  String uid = '';
  String name = '';
  bool dataLoaded = false;

  WatchlistModel() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      name = user.displayName ?? "";
      mode = WatchlistMode.ready;
      notifyListeners();
    } else {
      mode = WatchlistMode.not;
      notifyListeners();
    }
  }

  Future<List<Movie>> loadData() async {
    return await FirebaseFirestore.instance
        .collection("watchlists")
        .doc(uid)
        .collection("medialist")
        .get()
        .then((QuerySnapshot query) {
      List<Movie> data = [];
      query.docs.forEach(((doc) {
        data.add(Movie.cardJson(doc));
      }));
      if (data.isEmpty) {
        mode = WatchlistMode.empty;
      }
      notifyListeners();
      return data;
    });
  }

  void toggleWatched(String id, bool status) {
    FirebaseFirestore.instance
        .collection("watchlists")
        .doc(uid)
        .collection("medialist")
        .doc(id)
        .update({"watched": !status}).then((value) {
      loadData();
      notifyListeners();
    });
  }

  void deleteEntry(String id) {
    FirebaseFirestore.instance
        .collection("watchlists")
        .doc(uid)
        .collection("medialist")
        .doc(id)
        .delete()
        .then((value) {
      loadData();
      notifyListeners();
    });
  }
}
