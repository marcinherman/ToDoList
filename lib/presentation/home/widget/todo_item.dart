import 'package:flutter/material.dart';
import 'package:to_todo_list/constants/colors.dart';
import 'package:to_todo_list/domain/entity/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  final ToDo todo;
  final void Function(ToDo) onToDoChanged;
  final void Function(String) onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onToDoChanged(todo),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      tileColor: Colors.white,
      leading: Icon(
        todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        color: tdBlue,
      ),
      title: Text(
        todo.todoText,
        style: TextStyle(
          fontSize: 16,
          color: tdBlack,
          decoration: todo.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(vertical: 12),
        height: 35,
        width: 35,
        decoration:
            BoxDecoration(color: tdRed, borderRadius: BorderRadius.circular(5)),
        child: IconButton(
          color: Colors.white,
          iconSize: 18,
          icon: const Icon(Icons.delete),
          onPressed: () {
            //print('Deleted');
            onDeleteItem(todo.id);
          },
        ),
      ),
    );
  }
}
