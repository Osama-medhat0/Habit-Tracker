import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/monthly_progress.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/new_habit.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/pages/edit_habit_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HabitDatabase db;

  @override
  void initState() {
    super.initState();

    // Initializing the database instance with the Hive box
    db = HabitDatabase(widget.uid);

    // Check if there is any existing habit list in the Hive box
    if (db.myBox.get("Current_Habit_List") == null) {
      db.createIntialData();
    } else {
      db.loadData();
    }

    // Update Hive with current data
    db.updateDatabase();

    print("Hive DB contents:");
    print(db.myBox.toMap());
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
      backgroundColor: const Color.fromARGB(221, 238, 238, 238),
      floatingActionButton: MyFloatActionButton(
        onPressed: () => createNewHabit(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 152, 91, 237),
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          MonthlyProgress(
            datasets: db.heatMapDataSet,
            startDate: db.myBox.get("Start_Date"),
          ),
          ListView.builder(
            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),
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
                        db.updateDatabase();
                      });
                    } else if (value != null) {
                      setState(() {
                        db.todaysHabitList[index][0] = value;
                        db.updateDatabase(); // also update after renaming
                      });
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
