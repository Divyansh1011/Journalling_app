import 'package:crud/src/models/entry.dart';
import 'package:crud/src/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

//State Management for the entry screen file
class EntryProvider with ChangeNotifier {
  final firestoreservice =
      Firestoreservice(); //Using the firestore servie created an instance
  //Temprorary private variables to store the data
  DateTime _date;
  String _entry;
  String _entryId;
  //UUid package instance
  var uuid = Uuid();

  //Getters to get the values of the private instances created

  DateTime get date => _date;
  String get entry => _entry;
  Stream<List<Entry>> get entries =>
      firestoreservice.getEntries(); //List of all the entries to be featched

  //Setters
  set changeDate(DateTime date) {
    _date = date;
    notifyListeners(); //This changes the UI accordingly-> need a private variables to store the data locally
  }

  set changeEntry(String entry) {
    _entry = entry;
    notifyListeners();
  }

  //Fucntion to load all the existing entries
  loadall(Entry entry) {
    if (entry != null) {
      _date = DateTime.parse(entry.date);
      _entry = entry.entry;
      _entryId = entry.entryid;
    } else {
      _date = DateTime.now();
      _entry = null;
      _entryId = null;
    }
  }

  saveEntry() {
    if (_entryId == null) {
      //Add the entry
      var newEntry = Entry(
          date: _date.toIso8601String(), entry: _entry, entryid: uuid.v1());
      firestoreservice.setEntry(newEntry);
    } else {
      //edit
      var updatedEntry = Entry(
          date: _date.toIso8601String(), entry: _entry, entryid: _entryId);
      firestoreservice.setEntry(updatedEntry);
    }
  }

  removeEntry(String entryid) {
    firestoreservice.removeEntry(entryid);
  }
}
