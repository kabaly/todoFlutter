import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:todoApp/providers/todos_provider.dart';
// import 'package:todoApp/screen/checked_todo_over_view.dart';
// import 'package:todoApp/screen/unchecked_todo_over_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';
import 'package:todoApp/widgets/dialog_add.dart';
import 'package:todoApp/widgets/todo_over_view.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {'page': TodoOverView("All"), 'title': 'Todos'},
      {'page': TodoOverView("Active"), 'title': 'Todos'},
      {'page': TodoOverView("Complete"), 'title': 'Todos'},
      // {'page': UnCheckedOverView(), 'title': 'Todos'},
      // {'page': CheckedOverView(), 'title': 'Todos'},
    ];
    super.initState();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
            child: Dialog(
              child: DialogAdd(),
            ),
            behavior: HitTestBehavior.translucent,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final editable = Provider.of<Todo>(context).etat;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.white70,
        title: Text(
          'Todos',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Anton',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: CurvedNavigationBar(
        // onTap: _selectedPage,
        backgroundColor: Colors.blue,
        buttonBackgroundColor: Colors.white70.withOpacity(0.8),
        index: _selectedPageIndex,
        animationCurve: Curves.easeInExpo,
        animationDuration: Duration(milliseconds: 600),
        items: [
          FlatButton(
            child: Text(
              'All',
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            onPressed: () {
              setState(() {
                setState(() {
                  _selectedPageIndex = 0;
                });
              });
            },
          ),
          FlatButton(
            child: Text(
              'Active',
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            onPressed: () {
              setState(() {
                setState(() {
                  _selectedPageIndex = 1;
                });
              });
            },
          ),
          FlatButton(
            child: Text(
              'Completed',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            onPressed: () {
              setState(() {
                setState(() {
                  _selectedPageIndex = 2;
                });
              });
            },
          ),
        ],
      ),
      floatingActionButton: !editable
          ? FloatingActionButton(
              onPressed: () async {
                await _showAlertDialog(context);
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
              backgroundColor: Colors.redAccent,
              elevation: 10,
            )
          : null,
    );
  }
}
