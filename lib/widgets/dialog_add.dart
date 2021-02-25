import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';

class DialogAdd extends StatelessWidget {
  void _add(BuildContext ctx, String todo, String desc) {
    if (todo.isEmpty) {
      return null;
    }
    if (desc.isEmpty) {
      desc = null;
    }
    Provider.of<Todo>(ctx, listen: false).addTodo(todo, desc);
  }

  @override
  Widget build(BuildContext context) {
    var input = "";
    var description = "";
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              onChanged: (todo) {
                input = todo;
              },
              autofocus: true,
              decoration: InputDecoration(
                labelText: "todo",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (todo) {
                description = todo;
              },
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Entrer la description',
                filled: true,
                fillColor: Color(0xFFDBEDFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // labelText: "Description",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: () async {
                await _add(context, input, description);
                await Navigator.of(context).pop();
              },
              child: Text(
                'Ajouter',
                style: TextStyle(
                    fontFamily: 'Laton',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
