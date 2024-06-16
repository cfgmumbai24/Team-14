import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Portal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Admin Portal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _studentsEnrolled = 500; // Dummy data
  int _studentsPlaced = 280; // Dummy data

  List<BarChartGroupData> _createMentorSessionsData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 120.0,
            color: Colors.blue,
            width: 20,
          ),
          BarChartRodData(
            toY: 80.0,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  List<BarChartGroupData> _createExcellingStudentsData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 75.0,
            color: Colors.green,
            width: 20,
          ),
          BarChartRodData(
            toY: 25.0,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  List<BarChartGroupData> _createMentorRateData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 4.5,
            color: Colors.deepOrange,
            width: 20,
          ),
          BarChartRodData(
            toY: 0.5,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  List<BarChartGroupData> _createStudentsEnrolledData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 500.0,
            color: Colors.purple,
            width: 20,
          ),
          BarChartRodData(
            toY: 280.0,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  List<BarChartGroupData> _createAverageTestScoresData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 75.0,
            color: Colors.teal,
            width: 20,
          ),
          BarChartRodData(
            toY: 25.0,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  List<BarChartGroupData> _createCatEnrollmentData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 60.0,
            color: Colors.blue,
            width: 20,
          ),
          BarChartRodData(
            toY: 10.0,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  List<BarChartGroupData> _createClatEnrollmentData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 80.0,
            color: Colors.red,
            width: 20,
          ),
          BarChartRodData(
            toY: 20.0,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  List<BarChartGroupData> _createIitJeeEnrollmentData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 60.0,
            color: Colors.deepOrange,
            width: 20,
          ),
          BarChartRodData(
            toY: 40.0,
            color: Colors.grey,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0, 1],
      ),
    ];
  }

  Widget _buildBarChart(List<BarChartGroupData> data, String title) {
    return SizedBox(
      height: 150.0,
      width: MediaQuery.sizeOf(context).width,
      child: BarChart(
        BarChartData(
          barGroups: data,
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text(title);
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              // tooltipBgColor: Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.round()}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Students Enrolled:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '$_studentsEnrolled',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Students Placed:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '$_studentsPlaced',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _buildBarChart(
                  _createMentorSessionsData(), 'Mentor 1:1 Sessions'),
              const SizedBox(height: 20.0),
              _buildBarChart(
                  _createExcellingStudentsData(), '% of Excelling Students'),
              const SizedBox(height: 20.0),
              _buildBarChart(_createMentorRateData(), 'Mentor Rate'),
              const SizedBox(height: 20.0),
              _buildBarChart(_createStudentsEnrolledData(),
                  'Number of Students Enrolled in Universities'),
              const SizedBox(height: 20.0),
              _buildBarChart(
                  _createAverageTestScoresData(), 'Average Test Scores'),
              const SizedBox(height: 20.0),
              _buildBarChart(
                  _createCatEnrollmentData(), '% of Students Enrolled in CAT'),
              const SizedBox(height: 20.0),
              _buildBarChart(_createClatEnrollmentData(),
                  'Number of Students Enrolled in CLAT'),
              const SizedBox(height: 20.0),
              _buildBarChart(_createIitJeeEnrollmentData(),
                  'Number of Students Enrolled in IIT-JEE'),
            ],
          ),
        ),
      ),
    );
  }
}
