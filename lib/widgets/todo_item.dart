import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';
import 'package:todoApp/screen/detail_screen.dart';

// ignore: must_be_immutable
class TodoItem extends StatefulWidget {
  final String id;
  final int index;
  final String title;
  String description;
  final bool isChecked;
  @override
  TodoItem(this.id, this.title, this.description, this.isChecked, this.index);
  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool etat = false;
  String todo = "";
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailScreen.routeName, arguments: {
          "id": widget.id,
          "title": widget.title,
          "description": widget.description,
        });
      },
      child: Dismissible(
        key: ValueKey(widget.id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(
            right: 1,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          await Provider.of<Todo>(context, listen: false).removeTodo(widget.id);
        },
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("suppression"),
                content: const Text("voulez vous supprimmer ce todo?"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Non")),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Oui"),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          child: Card(
            margin: EdgeInsets.all(2),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: Checkbox(
                  tristate: true,
                  value: widget.isChecked,
                  onChanged: (value) async {
                    await Provider.of<Todo>(context, listen: false)
                        .check(widget.id);
                  },
                ),
                title: !etat
                    ? Text(
                        widget.title,
                        style: TextStyle(
                          color:
                              !widget.isChecked ? Colors.black : Colors.black38,
                          decoration: !widget.isChecked
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                          fontFamily: 'Laton',
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      )
                    : TextFormField(
                        initialValue: widget.title,
                        autofocus: true,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            if (value.isEmpty ||
                                value == "false" ||
                                value == null)
                              todo = widget.title;
                            else
                              todo = value;
                          });
                        },
                      ),
                subtitle: widget.description != null
                    ? Text(
                        widget.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                trailing: !etat
                    ? IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue[400],
                        ),
                        onPressed: () {
                          setState(() {
                            etat = !etat;
                          });
                          Provider.of<Todo>(context, listen: false)
                              .setEditable(true);
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.add_box,
                          color: Colors.blue[400],
                        ),
                        onPressed: () async {
                          await Provider.of<Todo>(context, listen: false)
                              .updateTodo(widget.id, todo);
                          setState(() {
                            etat = !etat;
                          });
                          Provider.of<Todo>(context, listen: false)
                              .setEditable(false);
                        },
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
