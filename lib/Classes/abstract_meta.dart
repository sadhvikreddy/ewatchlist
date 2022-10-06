import 'package:flutter/material.dart';

class AbstractMeta {
  final String title;
  final int id;
  int? year;
  AbstractMeta({required this.title, required this.id, this.year}) {
    year ?? 00;
  }

  factory AbstractMeta.fromJson(Map<String, dynamic> object) {
    return AbstractMeta(
        title: object['title'],
        id: object['ids']['simkl_id'],
        year: object['year']);
  }

  Widget display() {
    return Card(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
        elevation: 0,
        color: const Color.fromRGBO(54, 69, 79, 1),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(year.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14))
            ])));
  }
}
