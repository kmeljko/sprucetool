import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/group/ui/add.dart';
import 'package:sprucetool/src/group/ui/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Controller controller = GetIt.I.get();
  List<Group> _groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  _loadGroups() async {
    final groups = await controller.getAllGroups();
    // ignore: avoid_print
    print(groups.length);
    setState(() => _groups = groups);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(_groups.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(GroupPage(
                      group: _groups[index],
                    ));
                  },
                  child: Center(
                    child: Text(
                      _groups[index].name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(GroupAdd());
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
