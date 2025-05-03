import 'package:flutter/material.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:habit_tracker/pages/home_page.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  final String uid;

  const DashboardScreen({super.key, required this.userName, required this.uid});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late HabitDatabase habitDb;

  @override
  void initState() {
    super.initState();
    habitDb = HabitDatabase(widget.uid);
    habitDb.loadData(); //
  }

  @override
  Widget build(BuildContext context) {
    final total = habitDb.todaysHabitList.length;
    final completed =
        habitDb.todaysHabitList.where((habit) => habit[1] == true).length;
    final pending = total - completed;
    final percent = total == 0 ? 0.0 : completed / total;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 75),
            const Text(
              "Welcome,",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.userName} 👋",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 54),

            // White Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text(
                    "You've completed",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 81, 81, 81),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 12.0,
                    animation: true,
                    percent: percent,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$completed/$total",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text("total", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: const Color.fromARGB(255, 152, 91, 237),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoColumn("Total", total.toString(), Colors.black),
                      _infoColumn(
                        "Completed",
                        completed.toString(),
                        const Color.fromARGB(255, 152, 91, 237),
                      ),
                      _infoColumn("Pending", pending.toString(), Colors.red),
                    ],
                  ),
                ],
              ),
            ),

            // Motivational Message
            Container(
              margin: const EdgeInsets.only(top: 20, left: 75),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "💪 Keep it up, ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: "${widget.userName}! \n",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 152, 91, 237),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: "Don't you ever give up.",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 190),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(uid: widget.uid),
                    ),
                  ).then((_) {
                    // Reload the database when returning from HomePage
                    setState(() {
                      habitDb.loadData();
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  backgroundColor: const Color.fromARGB(255, 152, 91, 237),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "View My Habits",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 94, 94, 94),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
