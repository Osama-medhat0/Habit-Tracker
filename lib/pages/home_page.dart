import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/new_habit.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/pages/edit_habit_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("habit_Database");

  @override
  void initState() {
    //if there is no data, create initial data
    if (_myBox.get("Current_Habit_List") == null) {
      db.createIntialData();
    }
    //else load data
    else {
      db.loadData();
    }

    //update database
    db.updateDatabase();

    super.initState();
  }

  //controller for habit name
  bool habitCompleted = false;

  //checkbox
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });

    //update database
    db.updateDatabase();
  }

  //create new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabitBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  //save habit
  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();

    //update database
    db.updateDatabase();
  }

  //cancel func
  void cancelNewHabit() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatActionButton(
        onPressed: () => createNewHabit(),
      ),
      body: ListView.builder(
        itemCount: db.todaysHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: db.todaysHabitList[index][0],
            habitCompleted: db.todaysHabitList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            settingsPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => EditHabitPage(
                        habitName: db.todaysHabitList[index][0],
                      ),
                ),
              ).then((value) {
                if (value == 'delete') {
                  setState(() {
                    db.todaysHabitList.removeAt(index);
                    db.updateDatabase(); // ⬅️ important!
                  });
                } else if (value != null) {
                  setState(() {
                    db.todaysHabitList[index][0] = value;
                    db.updateDatabase(); // ⬅️ also update after renaming
                  });
                }
              });
            },
          );
        },
      ),
    );
  }
}
