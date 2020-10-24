import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/src/models/entry.dart';

class Firestoreservice {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get Entries(Fetch list of all entries from the firestore)

  Stream<List<Entry>> getEntries() {
    return _db
        .collection('entries')
        .where('date',
            isGreaterThan: DateTime.now()
                .add(Duration(days: -30))
                .toIso8601String()) //For Querrying
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Entry.fromJson(doc.data())).toList());
  }

  //upsert(If ht record dosent exisr go ahead and create it otherwise update the existing one ) create + update

  Future<void> setEntry(Entry entry) {
    var options = SetOptions(merge: true);
    return _db
        .collection('entries')
        .doc(entry.entryid)
        .set(entry.toMap(), options);
  }

  //Delete

  Future<void> removeEntry(String entryid) {
    return _db.collection('entries').doc(entryid).delete();
  }
}
