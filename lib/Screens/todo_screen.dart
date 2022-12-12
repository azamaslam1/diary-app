import 'package:flutter/material.dart';
import 'package:personal_dairy/Screens/new_main.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:personal_dairy/widgets/todo_item.dart';

import '../main.dart';
import '../widgets/header.dart';
import 'Authentication/main_auth.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.2),
            child: CustomHeader(
              percent: percent,
            )),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: colorHeader,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _todoController,
                            decoration: const InputDecoration(
                              hintText: 'Add a new todo item',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // _addToDoItem(_todoController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            onSurface: colorHeader,
                            primary: colorHeader,
                            minimumSize: const Size(60, 60),
                            shape: const CircleBorder(),
                          ),
                          child: const Text(
                            '+',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            bottom: 20,
                          ),
                          child: Text(
                            'ToDos',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ToDoItem(
                            text: (language == "English")
                                ? english['I have to go to gym']
                                : (language == "Slovak")
                                    ? slovak['I have to go to gym']
                                    : czech['I have to go to gym'],
                            onToDoChanged: () {},
                            onDeleteItem: () {}),
                        ToDoItem(
                            text: (language == "English")
                                ? english['I have to go to gym']
                                : (language == "Slovak")
                                    ? slovak['I have to go to gym']
                                    : czech['I have to go to gym'],
                            onToDoChanged: () {},
                            onDeleteItem: () {})
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
