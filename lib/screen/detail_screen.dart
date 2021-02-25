import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = "/detail";
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool edit = false;
  String text = "";
  @override
  Widget build(BuildContext context) {
    final Map details = ModalRoute.of(context).settings.arguments as Map;
    String des =
        Provider.of<Todo>(context, listen: false).descript(details['id']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      details['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Laton',
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description :",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Laton',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      child: !edit
                          ? InkWell(
                              onDoubleTap: () {
                                setState(() {
                                  edit = !edit;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: des == "null"
                                    ? Text(
                                        // details['description'],
                                        "double cliquer pour faire une description")
                                    : Text(
                                        // details['description'],
                                        des),
                              ),
                            )
                          : TextFormField(
                              onChanged: (desc) {
                                text = desc;
                              },
                              initialValue: details['description'],
                              maxLines: 15,
                              keyboardType: TextInputType.multiline,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'Entrer la description',
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                // labelText: "Description",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                    ),
                  ),
                  edit
                      ? RaisedButton(
                          onPressed: () async {
                            await Provider.of<Todo>(context, listen: false)
                                .updateDescription(details['id'], text);
                            // (context as Element).reassemble();
                            setState(() {
                              edit = !edit;
                            });
                          },
                          child: Text('Ok'),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
