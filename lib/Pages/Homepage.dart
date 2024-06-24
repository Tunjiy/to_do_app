import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('Mybox');
  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState() {
    // if this is the first time ever opening the app, create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //there already exist data
      db.loadData();
    }
    super.initState();
  }

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //saveNewTak
  void saveNewTask() {
    //to add new task to the list
    setState(() {
      db.toDoList.add([_controller.text, false]);
      //clear the dialogbox after adding new task
      _controller.clear();
    });
    //close the dialog box after creating task
    Navigator.of(context).pop();
    db.updateDatabase();
  }

//create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff847d3c),
        appBar: AppBar(
            centerTitle: true,
            title: Text("To Do"),
            elevation: 0,
            backgroundColor: Colors.yellow),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskname: db.toDoList[index][0],
                onChanged: (value) => checkBoxChanged(value, index),
                taskcompleted: db.toDoList[index][1],
                deleteFunction: (context) => deleteTask(index));
          },
        ));
  }
}
