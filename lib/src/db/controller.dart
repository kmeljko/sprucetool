import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sembast/sembast.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/note/model/note.dart';

class Controller {
  final Database _database = GetIt.I.get();

  Future<List<Group>> getAllGroups() async {
    final StoreRef _store = intMapStoreFactory.store("group_store");
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Group.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  // Future<List<Group>> getAllNotes(Group group) async {
  // final StoreRef _store = intMapStoreFactory.store("group_store");
  //   final value = await _store.record(group.id).get(_database);
  //   return value[''];
  // }

  Future<int> addGroup(String name) async {
    final StoreRef _store = intMapStoreFactory.store("group_store");
    Group group = Group(id: 0, name: name, dates: [], notes: [], toDoList: []);
    return await _store.add(_database, group.toMap());
  }

  Future addNote(Group group, String name) async {
    StoreRef _store = intMapStoreFactory.store("notes_store");
    var note = Note(
        id: int.tryParse(DateFormat('yyyyMMddkkmm').format(DateTime.now()))!,
        name: name,
        body: "",
        creationTimestamp: DateTime.now(),
        lastUpdateTimestamp: DateTime.now());
    int id = await _store.add(_database, note.toMap());

    _store = intMapStoreFactory.store("group_store");
    if (group.notes.isEmpty) {
      group.notes = [];
    }
    group.notes.add(id);
    _store.record(group.id).update(_database, group.toMap());
  }

  Future<Note> getNote(int id) async {
    StoreRef _store = intMapStoreFactory.store("notes_store");
    var note=await _store.record(id).get(_database);
    return Note.fromMap(note);
  }

  Database getDb() {
    return GetIt.I.get();
  }
}
