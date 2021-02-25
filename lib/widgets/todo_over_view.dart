import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart' show Todo;
import 'package:todoApp/widgets/todo_item.dart';

class TodoOverView extends StatelessWidget {
  final String etat;
  TodoOverView(this.etat);
  @override
  Widget build(BuildContext context) {
    var data;
    final todos = Provider.of<Todo>(context, listen: true);
    if (etat == "All") {
      data = todos.todos;
    } else if (etat == "Active") {
      data = todos.todosUnchecked;
    } else {
      data = todos.todosChecked;
    }
    return ListView.builder(
      itemBuilder: (context, i) => TodoItem(
        data[i].id,
        data[i].title,
        data[i].description,
        data[i].isChecked,
        i,
      ),
      itemCount: data.length,
    );
  }
}
