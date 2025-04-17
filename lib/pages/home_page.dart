import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/new_habit.dart';
import 'package:habit_tracker/pages/edit_habit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controller for habit name
  bool habitCompleted = false;

  List HabitList = [
    ["Drink water", false],
    ["Morning run", false],
    ["Read book", false],
  ];

  //checkbox
  void checkboxChanged(bool? value, int index) {
    setState(() {
      HabitList[index][1] = value!;
    });
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
      HabitList.add([_newHabitNameController.text, false]);
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
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
        itemCount: HabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: HabitList[index][0],
            habitCompleted: HabitList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            settingsPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          EditHabitPage(habitName: HabitList[index][0]),
                ),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    HabitList[index][0] = value;
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
