import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewatchlist/Classes/abstract_meta.dart';
import 'package:ewatchlist/Providers/global_variables.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Movie extends AbstractMeta {
  late String? posterUrl;
  late String? overview;
  late String displayType;
  late String type;
  final GlobalVariables variables = GlobalVariables();
  late Color colorCode = Colors.white;
  final String posterPlace = 'assets/images/posterPlace.png';
  bool watched = false;

  Movie.fullInfo({
    required super.title,
    required super.id,
    super.year,
    this.posterUrl,
    this.overview,
    required this.colorCode,
  }) {
    displayType = variables.full;
  }

  factory Movie.fullJson(
      Map<String, dynamic> object, String posterU, Color cc) {
    return Movie.fullInfo(
        title: object['title'],
        id: object['ids']['simkl'],
        year: object['year'],
        posterUrl: posterU,
        overview: object['overview'],
        colorCode: cc);
  }

  Movie.cardInfo(
      {required super.title,
      required super.id,
      required super.year,
      required this.posterUrl,
      this.overview,
      required this.watched,
      required this.type}) {
    displayType = variables.card;
    if (type == "movie") {
      colorCode = const Color(0xFF808000);
    } else if (type == "tv") {
      colorCode = Colors.purple;
    } else {
      colorCode = Colors.blue;
    }
  }

  factory Movie.cardJson(QueryDocumentSnapshot<Object?> object) {
    return Movie.cardInfo(
        title: object['title'],
        id: object['id'],
        year: object['year'],
        posterUrl: object['poster'],
        type: object['type'],
        overview: object['overview'],
        watched: object['watched']);
  }

  void setType(String mtype) {
    type = mtype;
  }

  Widget getImage(bool poster, String displayType) {
    if (displayType == variables.full) {
      if (poster) {
        return Image.network(
          posterUrl!,
          width: 340,
          height: 510,
          fit: BoxFit.fill,
        );
      } else {
        return Image.asset(
          posterPlace,
          width: 340,
          height: 510,
          fit: BoxFit.fill,
        );
      }
    } else {
      if (poster) {
        return Image.network(
          posterUrl!,
          width: 340 / 2,
          height: 510 / 2,
          fit: BoxFit.fill,
        );
      } else {
        return Image.asset(
          posterPlace,
          width: 340 / 2,
          height: 510 / 2,
          fit: BoxFit.fill,
        );
      }
    }
  }

  Widget displayThis(String displayType) {
    bool poster = false;
    if (posterUrl != "Nothing") {
      poster = true;
    }
    if (displayType == variables.full) {
      return Padding(
          padding: const EdgeInsets.only(top: 25),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            fill: Fill.fillFront,
            front: Container(
              width: 340,
              height: 510,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 10,
                color: colorCode,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: getImage(poster, displayType),
                ),
              ),
            ),
            back: Container(
              width: 340,
              height: 510,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 10,
                color: colorCode,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              const Divider(
                                height: 5,
                                thickness: 1,
                                color: Colors.white,
                              ),
                              Text(
                                year.toString(),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                overview ?? "Overview not Available",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ]))),
              ),
            ),
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Container(
              width: 340,
              height: 510,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(children: [
                Card(
                  elevation: 30,
                  color: colorCode,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: getImage(poster, displayType),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: watched
                            ? Stack(children: const <Widget>[
                                Positioned(
                                    left: 1.0,
                                    top: 2.0,
                                    child: Text("WATCHED",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black))),
                                Text("WATCHED",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                              ])
                            : Stack(children: const <Widget>[
                                Positioned(
                                    left: 1.0,
                                    top: 2.0,
                                    child: Text("",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black))),
                                Text("",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                              ])))
              ])));
    }
  }
}
