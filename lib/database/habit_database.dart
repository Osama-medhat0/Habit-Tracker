import 'package:habit_tracker/date/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

//reference to the box
// This is the box where we will store our habit data
final _myBox = Hive.box("habit_Database");

class HabitDatabase {
  List todaysHabitList = [];

  //inital data
  void createIntialData() {
    todaysHabitList = [
      ["Drink water", false],
      ["Morning run", false],
      ["Read book", false],
    ];

    _myBox.put("Start_Date", getTodayDate());
  }

  //load data if exists
  void loadData() {
    //if new day, get habit list from db
    if (_myBox.get(getTodayDate()) == null) {
      todaysHabitList = _myBox.get("Current_Habit_List");
      // all habits are not completed
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    //if not new day, get habit list from db
    else {
      todaysHabitList = _myBox.get(getTodayDate());
    }
  }

  //update data
  void updateDatabase() {
    //update today's date in db
    _myBox.put(getTodayDate(), todaysHabitList);

    //update habit list in db (new habits, edit habits, delete habits)
    _myBox.put("Current_Habit_List", todaysHabitList);
  }
}
