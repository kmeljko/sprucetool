import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:sprucetool/src/group/model/group.dart';

class Controller {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("group_store");
  
  Future<List<Group>> getAllGroups() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Group.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
  
  Future<int> addGroup(String name) async {
    Group group = Group(id: 0,name: name,dates: [],notes: [],toDoList: []);
    return await _store.add(_database, group.toMap());
  }


  Database getDb() {
    return GetIt.I.get();
  }
}
