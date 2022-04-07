import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/note/model/note.dart';
import 'package:sprucetool/src/to_do/model/to_do.dart';

class Controller {
  final Database _database = GetIt.I.get();

  // Future<List<Group>> getAllNotes(Group group) async {
  // final StoreRef _store = intMapStoreFactory.store("group_store");
  //   final value = await _store.record(group.id).get(_database);
  //   return value[''];
  // }

  // Future deleteDB() async {
  //   await databaseFactoryIo.deleteDatabase(_database.path);
  // }

  //-------GROUPS-------
  //get all groups
  Future<List<Group>> getAllGroups() async {
    final StoreRef _store = intMapStoreFactory.store("group_store");
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Group.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  //add new group
  Future<int> addGroup(String name) async {
    final StoreRef _store = intMapStoreFactory.store("group_store");
    Group group = Group(id: 0, name: name, dates: [], notes: [], toDoList: []);
    return await _store.add(_database, group.toMap());
  }

  //-------NOTES-------
  //get note by id
  Future<Note> getNote(int id) async {
    StoreRef _store = intMapStoreFactory.store("notes_store");
    var note = await _store.record(id).get(_database);
    return Note.fromMap(id, note);
  }

  //add new note
  Future addNote(Group group, String name) async {
    StoreRef _store = intMapStoreFactory.store("notes_store");
    var note = Note(
        id: 0,
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

  //update note
  Future updateNote(Note note) async {
    StoreRef _store = intMapStoreFactory.store("notes_store");
    _store.record(note.id).update(_database, note.toMap());
  }

  //-------TO DO-------
  //get to do with id
  Future<ToDo> getToDo(int id) async {
    StoreRef _store = intMapStoreFactory.store("todo_store");
    var todo = await _store.record(id).get(_database);
    return ToDo.fromMap(id, todo);
  }

  //add new to do
  Future addToDo(Group group, String name, String type) async {
    StoreRef _store = intMapStoreFactory.store("todo_store");
    var todo = ToDo(
        id: 0,
        name: name,
        creationTimestamp: DateTime.now(),
        lastUpdateTimestamp: DateTime.now(),
        type: type,
        description: "",
        done: false,
        children: []);
    int id = await _store.add(_database, todo.toMap());

    _store = intMapStoreFactory.store("group_store");
    if (group.toDoList.isEmpty) {
      group.toDoList = [];
    }

    group.toDoList.add(id);
    _store.record(group.id).update(_database, group.toMap());
  }


  //add new to do as child to other to do
  Future addToDoAsChild(ToDo parent, String name, String type) async {
    StoreRef _store = intMapStoreFactory.store("todo_store");
    var todo = ToDo(
        id: 0,
        name: name,
        creationTimestamp: DateTime.now(),
        lastUpdateTimestamp: DateTime.now(),
        type: type,
        description: "",
        done: false,
        children: []);
    int id = await _store.add(_database, todo.toMap());

    if (parent.children.isEmpty) {
      parent.children = [];
    }

    parent.children.add(id);
    _store.record(parent.id).update(_database, parent.toMap());
  }

  //update to do
  Future updateToDo(ToDo todo) async {
    StoreRef _store = intMapStoreFactory.store("todo_store");
    _store.record(todo.id).update(_database, todo.toMap());
  }

  //get db
  Database getDb() {
    return GetIt.I.get();
  }
}
