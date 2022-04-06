import 'package:sprucetool/src/group/model/group.dart';

abstract class Controller {
  Future<int> addGroup(String name);
  Future<List<Group>> getAllGroups();
}