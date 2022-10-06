import 'package:ewatchlist/Classes/abstract_meta.dart';
import 'package:ewatchlist/Providers/global_variables.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Movie extends AbstractMeta {
  late String? posterUrl;
  late String? overview;
  late String displayType;
  final GlobalVariables variables = GlobalVariables();
  late Color colorCode = Colors.white;
  final String posterPlace = 'assets/images/posterPlace.png';

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

  Movie.cardInfo({
    required super.title,
    required super.id,
    required super.year,
    required this.posterUrl,
    this.overview,
    required this.colorCode,
  }) {
    displayType = variables.card;
  }

  factory Movie.cardJson(
      Map<String, dynamic> object, String posterU, Color cc) {
    return Movie.cardInfo(
        title: object['title'],
        id: object['ids']['simkl'],
        year: object['year'],
        posterUrl: posterU,
        colorCode: cc);
  }

  Widget getImage(bool poster) {
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
            fill: Fill.fillBack,
            direction: FlipDirection.HORIZONTAL,
            front: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: getImage(poster),
                ),
              ),
            ),
            back: Container(
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
      return SizedBox(
        width: 40,
        child: Card(
          elevation: 20,
          child: getImage(poster),
        ),
      );
    }
  }
}
