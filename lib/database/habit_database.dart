import 'package:habit_tracker/date/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

//reference to the box
// This is the box where we will store our habit data
// final _myBox = Hive.box("habit_Database");

class HabitDatabase {
  List todaysHabitList = [];
  late Box _myBox;
  Box get myBox => _myBox;

  //map for heatmap-style visualizations
  Map<DateTime, int> heatMapDataSet = {};

  HabitDatabase(String uid) {
    _myBox = Hive.box("habits_$uid");
  }

  //inital data
  void createIntialData() {
    todaysHabitList = [
      // ["Drink water", false],
      // ["Morning run", false],
      // ["Read book", false],
    ];

    _myBox.put("Start_Date", getTodayDate());
    _myBox.put("Current_Habit_List", todaysHabitList); // Save base habit list
    _myBox.put(getTodayDate(), todaysHabitList);
  }

  //load data if exists
  void loadData() {
    var todayKey = getTodayDate();
    var currentList = _myBox.get("Current_Habit_List") ?? [];

    // If it's a new day and today's key isn't present
    if (_myBox.get(todayKey) == null) {
      todaysHabitList = List.from(currentList);

      // Set all to not completed
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    } else {
      todaysHabitList = List.from(_myBox.get(todayKey) ?? []);
    }
  }

  //update data
  void updateDatabase() {
    //update today's date in db
    _myBox.put(getTodayDate(), todaysHabitList);

    //update habit list in db (new habits, edit habits, delete habits)
    _myBox.put("Current_Habit_List", todaysHabitList);

    //calculate habits progress
    calculateHabitPercentage();

    //load heatmap
    loadHeatMap();
  }

  //Heatmap func
  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("Start_Date"));

    //cont number of days since start date to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("Habit_Percentage_$yyymmdd") ?? "0.0",
      );

      ///year, month, day
      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print("Heatmap data: $heatMapDataSet");
    }
  }

  void calculateHabitPercentage() {
    //calculate percentage of habits completed
    int completedHabitCount = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        completedHabitCount++;
      }
    }

    //calculate percentage
    String percentage =
        todaysHabitList.isEmpty
            ? '0.0'
            : (completedHabitCount / todaysHabitList.length).toStringAsFixed(1);

    //update percentage in db
    _myBox.put("Habit_Percentage_${getTodayDate()}", percentage);
  }
}
