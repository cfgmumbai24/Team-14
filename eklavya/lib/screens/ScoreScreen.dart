import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ScoreScreen({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Score'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$score / $totalQuestions',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            buildCharts(context),
            SizedBox(height: 40),
            buildLeaderboard(),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCharts(BuildContext context) {
    return Column(
      children: [
        Text(
          'Performance Charts',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          'Line Chart: Shows your score progression over time.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: LineChart(LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 1),
                  FlSpot(1, 3),
                  FlSpot(2, 5),
                  FlSpot(3, 4),
                  FlSpot(4, 3),
                ],
                isCurved: true,
                color: Colors.blue,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
            ],
            borderData: FlBorderData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text('Q${value.toInt() + 1}');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
          )),
        ),
        SizedBox(height: 20),
        Text(
          'Bar Chart: Compares your scores with others.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: BarChart(BarChartData(
            barGroups: [
              BarChartGroupData(x: 0, barRods: [
                BarChartRodData(
                  toY: 5,
                  color: Colors.red,
                  width: 16,
                  borderRadius: BorderRadius.zero,
                )
              ]),
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(
                  toY: 6,
                  color: Colors.blue,
                  width: 16,
                  borderRadius: BorderRadius.zero,
                )
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(
                  toY: 7,
                  color: Colors.green,
                  width: 16,
                  borderRadius: BorderRadius.zero,
                )
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(
                  toY: 8,
                  color: Colors.orange,
                  width: 16,
                  borderRadius: BorderRadius.zero,
                )
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(
                  toY: score.toDouble(),
                  color: Colors.purple,
                  width: 16,
                  borderRadius: BorderRadius.zero,
                )
              ]),
            ],
            borderData: FlBorderData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('P1');
                      case 1:
                        return Text('P2');
                      case 2:
                        return Text('P3');
                      case 3:
                        return Text('P4');
                      case 4:
                        return Text('Me');
                      default:
                        return Text('');
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
          )),
        ),
        SizedBox(height: 20),
        Text(
          'Pie Chart: Shows the distribution of scores.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: PieChart(PieChartData(
            sections: [
              PieChartSectionData(
                value: 40,
                color: Colors.blue,
                title: '40%',
                radius: 60,
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 30,
                color: Colors.red,
                title: '30%',
                radius: 50,
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 15,
                color: Colors.green,
                title: '15%',
                radius: 40,
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 15,
                color: Colors.orange,
                title: '15%',
                radius: 30,
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
            sectionsSpace: 4,
            centerSpaceRadius: 40,
          )),
        ),
      ],
    );
  }

  Widget buildLeaderboard() {
    List<Map<String, dynamic>> leaderboardData = [
      {'name': 'Alice', 'score': 80},
      {'name': 'Bob', 'score': 70},
      {'name': 'Charlie', 'score': 60},
      {'name': 'David', 'score': 50},
      {'name': 'Eve', 'score': 40},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leaderboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: leaderboardData.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text((index + 1).toString()),
              ),
              title: Text(leaderboardData[index]['name']),
              trailing: Text(leaderboardData[index]['score'].toString()),
            );
          },
        ),
      ],
    );
  }
}
