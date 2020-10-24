import 'package:flutter/material.dart';

class Entry {
  final String entryid;
  final String date;
  final String entry;

  Entry({this.date, this.entry, @required this.entryid}); //Named Constructor

  //To fetch the details from the firestore we need to convert the dart object to json object
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        date: json['date'], entry: json['entry'], entryid: json['entryid']);
  }

  //To send to firestore you need to changes the dart object to the json object

  Map<String, dynamic> toMap() {
    return {'date': date, 'entry': entry, 'entryid': entryid};
  }
}
