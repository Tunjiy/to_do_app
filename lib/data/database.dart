import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  //reference the box
  final _myBox = Hive.box('Mybox');

  //run this the first time ever opening this app

  void createInitialData() {
    toDoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false]
    ];
  }

  //load data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //update data from database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
