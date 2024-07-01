import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List<List<dynamic>> toDoList = [];

  // Reference our box
  final Box _myBox = Hive.box('mybox');

  // Run this method if it's the first time ever opening this app
  void createInitalData() {
    toDoList = [
      ["Consertar a porta", false],
      ["Terminar o projeto", false],
    ];
  }

  // Load the data from database
  void loadData() {
    toDoList = List<List<dynamic>>.from(_myBox.get("TODOLIST"));
  }

  // Update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
