import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';

class ToDoItem extends StatelessWidget {
  final onToDoChanged;
  final onDeleteItem;
  final text;
  final subtitle;
  final image;

  const ToDoItem({
    Key? key,
    required this.text,
    required this.onToDoChanged,
    required this.onDeleteItem,
    this.subtitle,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        child: ListTile(
          onTap: onToDoChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: Container(
            width: size.width * 0.14,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(14.0)),
            child: (image),
          ),

          title: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: colorHeader,
              // decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              // decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          // trailing: Container(
          //   padding: const EdgeInsets.all(0),
          //   margin: const EdgeInsets.symmetric(vertical: 12),
          //   height: 35,
          //   width: 35,
          //   decoration: BoxDecoration(
          //     color: colorHeader,
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: IconButton(
          //     color: Colors.white,
          //     iconSize: 18,
          //     icon: const Icon(Icons.delete),
          //     onPressed:onDeleteItem,
          //   ),
          // ),
        ),
      ),
    );
  }
}
