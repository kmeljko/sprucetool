import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/group/ui/add.dart';
import 'package:sprucetool/src/group/ui/group_page.dart';
import 'package:sprucetool/src/ui/all_to_do.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';
import 'package:sprucetool/src/util/values/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Controller controller = GetIt.I.get();
  List<Group> _groups = [];

  _loadGroups() async {
    final groups = await controller.getAllGroups();
    // ignore: avoid_print
    print(groups.length);
    setState(() => _groups = groups);
  }

  @override
  void initState() {
    super.initState();

    _loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("SpruceTool"),
      body: Stack(
        children: [
          Center(
            child: RefreshIndicator(
              onRefresh: () async {
                await _loadGroups();
              },
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(_groups.length, (index) {
                  return GestureDetector(
                    onTap: () async {
                      await _loadGroups();
                      Get.to(GroupPage(
                        group: _groups[index],
                      ));
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              _groups[index].name,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Text(
                            _groups[index].notes.length.toString(),
                          ),
                          Text(
                            _groups[index].toDoList.length.toString(),
                          ),
                          Text(
                            _groups[index].dates.length.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              Get.to(AllToDoListPage());
            },
            backgroundColor: AppColors.mainColor,
            child: const Icon(Icons.notes),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Get.to(GroupAdd());
            },
            backgroundColor: AppColors.mainColor,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
