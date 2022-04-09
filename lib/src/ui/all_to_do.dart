import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprucetool/src/db/controller.dart';
import 'package:sprucetool/src/group/model/group.dart';
import 'package:sprucetool/src/group/ui/group_page.dart';
import 'package:sprucetool/src/to_do/ui/to_do_list.dart';
import 'package:sprucetool/src/ui/components/appbar.dart';

class AllToDoListPage extends StatefulWidget {
  const AllToDoListPage({Key? key}) : super(key: key);
  @override
  State<AllToDoListPage> createState() => _AllToDoListPageState();
}

class _AllToDoListPageState extends State<AllToDoListPage> {
  Controller controller = GetIt.I.get();
  List<Group> _groups = [];
  List<Widget> _items = [];

  _loadGroups() async {
    final groups = await controller.getAllGroups();
    // ignore: avoid_print
    print(groups.length);
    setState(() => _groups = groups);
    _items = List.generate(
        _groups.length,
        (index) => toDoListWidget(
            _groups[index].toDoList, 0, controller, refresh,
            showItems: false));
    refresh();
  }

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("SpruceTool", withBack: true),
      body: Stack(
        children: [
          Center(
            child: RefreshIndicator(
              onRefresh: () async {
                await _loadGroups();
              },
              child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: _groups.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _loadGroups();
                            Get.to(GroupPage(
                              group: _groups[index],
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _groups[index].name,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        (index < _items.length) ? _items[index] : Container()
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
