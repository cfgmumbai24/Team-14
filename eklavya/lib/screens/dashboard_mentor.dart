
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedStudent;
  final List<String> students = ['John Doe', 'Jane Smith'];
  final Map<String, Map<String, dynamic>> studentData = {
    'John Doe': {
      'attendance': [1, 1, 0, 1, 1, 0, 1],
      'tests': [75, 80, 78, 82, 85],
      'courseCompletion': 70,
      'applicationStage': 3,
      'details': 'John is a computer science major in his third year.'
    },
    'Jane Smith': {
      'attendance': [1, 0, 1, 1, 1, 1, 1],
      'tests': [70, 75, 78, 80, 82],
      'courseCompletion': 80,
      'applicationStage': 4,
      'details': 'Jane is an electrical engineering major in her final year.'
    },
  };

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Student to gain insights for',style: TextStyle(fontSize: 16),),
              DropdownButton<String>(
                hint: Text('Select Student'),
                value: selectedStudent,
                items: students.map((String student) {
                  return DropdownMenuItem<String>(
                    value: student,
                    child: Text(student),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStudent = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              if (selectedStudent != null) ...[
                Text(
                  'Student Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  studentData[selectedStudent]!['details'],
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                OverviewSection(studentData[selectedStudent]!),
                SizedBox(height: 20),
                AttendanceSection(studentData[selectedStudent]!['attendance']),
                SizedBox(height: 20),
                TestScoresSection(studentData[selectedStudent]!['tests']),
                SizedBox(height: 20),
                CourseCompletionSection(studentData[selectedStudent]!['courseCompletion']),
                SizedBox(height: 20),
                ApplicationStageSection(studentData[selectedStudent]!['applicationStage']),
              ],
              if (selectedStudent == null) ...[
                Text('Select a student to view detailed information.'),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class OverviewSection extends StatelessWidget {
  final Map<String, dynamic> data;

  OverviewSection(this.data);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OverviewCard(
          title: 'Course Completion',
          value: '${data['courseCompletion']}%',
          color: Colors.blue,
        ),
        OverviewCard(
          title: 'Application Stage',
          value: 'Stage ${data['applicationStage']}',
          color: Colors.green,
        ),
      ],
    );
  }
}

class OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const OverviewCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: color),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceSection extends StatelessWidget {
  final List<int> attendance;

  AttendanceSection(this.attendance);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance (last 7 days)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('Day ${(value + 1).toInt()}');
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(value == 0 ? 'Absent' : 'Present');
                        },
                        interval: 1,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        attendance.length,
                        (index) => FlSpot(index.toDouble(), attendance[index].toDouble()),
                      ),
                      isCurved: false,
                      barWidth: 4,
                      color: Colors.blue,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestScoresSection extends StatelessWidget {
  final List<int> testScores;

  TestScoresSection(this.testScores);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Scores',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(
                    testScores.length,
                    (index) => BarChartGroupData(
                      x: index,
                      barRods: [BarChartRodData(toY: testScores[index].toDouble(), color: Colors.blue)],
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('Test ${(value + 1).toInt()}');
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCompletionSection extends StatelessWidget {
  final int completion;

  CourseCompletionSection(this.completion);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 0)
          ],
        ),
      ),
    );
  }
}

class ApplicationStageSection extends StatelessWidget {
  final int stage;

  ApplicationStageSection(this.stage);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          ],
        ),
      ),
    );
  }
}
