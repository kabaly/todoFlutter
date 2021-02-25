import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class TodoItem with ChangeNotifier {
  final String id;
  String title;
  String description;
  bool isChecked;
  TodoItem({
    @required this.id,
    @required this.title,
    this.description,
    this.isChecked = false,
  });
  TodoItem.convertir(Map<String, dynamic> data, String id)
      : id = id,
        title = data['title'],
        description = data['description'],
        isChecked = data['isChecked'];
}

class Todo with ChangeNotifier {
  Todo() {
    print('fjfj');
    chargerData();
  }
  var uuid = Uuid();
  bool etat = false;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('todos');
  List<TodoItem> _todos = [];

  List<TodoItem> get todos {
    return [..._todos];
  }

  List<TodoItem> get todosUnchecked {
    return _todos.where((todo) => !todo.isChecked).toList();
  }

  List<TodoItem> get todosChecked {
    return _todos.where((todo) => todo.isChecked).toList();
  }

  String descript(String id) {
    var a = _todos.where((todo) => todo.id == id).toList();
    return a.first.description.toString();
  }

  Future chargerData() async {
    collectionReference
        .orderBy('time', descending: false)
        .snapshots()
        .listen((event) {
      print('ajout avec "33"');
      _todos = event.docs.map((element) {
        return TodoItem.convertir(element.data(), element.id);
      }).toList();
      notifyListeners();
    });
    // QuerySnapshot querySnapshot = await collectionReference.get();
    // querySnapshot.docs.forEach((element) {
    //   print("les donnees ${element.data()} ${element.id}");
    //   _todos.add(TodoItem.convertir(element.data(), element.id));
    // });
  }

  Future addTodo(String todo, String description) async {
    await collectionReference.add({
      "title": todo,
      "isChecked": false,
      "description": description,
      "time": Timestamp.now(),
    }).then((_) {
      print('ajout avec succes');
      // _todos.add(
      //   TodoItem(id: uuid.v1(), title: todo, isChecked: false),
      // );
    });
    // notifyListeners();
  }

  Future removeTodo(String id) async {
    await collectionReference
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
    // _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  Future check(String id) async {
    DocumentSnapshot isch = await collectionReference.doc(id).get();
    print(isch.data()['isChecked']);
    await collectionReference
        .doc(id)
        .update({'isChecked': !isch.data()['isChecked']}).then((value) {
      print("User Updated");
      notifyListeners();
    }).catchError((error) => print("Failed to update user: $error"));
    // var i = _todos.indexWhere((todo) => todo.id == id);
    // _todos[i].isChecked = !_todos[i].isChecked;
    // notifyListeners();
  }

  Future updateTodo(String id, String todo) async {
    print(todo);
    if (todo.isEmpty) {
      return null;
    }
    await collectionReference.doc(id).update({'title': todo}).then((value) {
      print("User Updated");
      notifyListeners();
    }).catchError((error) => print("Failed to update user: $error"));

    // var i = _todos.indexWhere((todo) => todo.id == id);
    // _todos[i].title = todo;
    // notifyListeners();
  }

  Future updateDescription(String id, String text) async {
    if (text.isEmpty) {
      text = null;
    }
    await collectionReference
        .doc(id)
        .update({'description': text}).then((value) {
      print("User Updated");
      notifyListeners();
    }).catchError((error) => print("Failed to update user: $error"));

    // var i = _todos.indexWhere((todo) => todo.id == id);
    // _todos[i].title = todo;
    // notifyListeners();
  }

  void setEditable(bool state) {
    etat = state;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
