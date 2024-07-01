import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/util/todo_tile.dart';
import 'package:to_do/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the Hive box
  final Box _myBox = Hive.box('mybox');
  final ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();

    // If this is the 1st time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitalData();
    } else {
      // There already exists data
      db.loadData();
    }
  }

  // Text controller
  final TextEditingController _controller = TextEditingController();

  // CheckBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 103, 138, 212),
      appBar: AppBar(
        title: const Text('To Do List'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoTile(
            taskName: db.toDoList[index][0] as String,
            taskCompleted: db.toDoList[index][1] as bool,
            onChanged: (bool? value) => checkBoxChanged(value, index),
            deleteFunction: (BuildContext context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
