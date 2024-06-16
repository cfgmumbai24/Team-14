import 'package:eklavya/screens/StudentDashboard.dart';
import 'package:eklavya/screens/feedbackForm.dart';
import 'package:eklavya/screens/login.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Aditya Jeevan Jethani'),
              accountEmail: Text('Last Login: 15-06-2024 13:30:00'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  'A',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 203, 80, 252),
              ),
            ),
            _buildDrawerItem(Icons.feedback, 'Feedback'),
            _buildDrawerItem(Icons.logout, 'Logout'),
            SwitchListTile(
              title: Text('Allow Notifications'),
              value: true,
              onChanged: (bool value) {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://www.shutterstock.com/image-vector/user-profile-icon-vector-avatar-600nw-2247726673.jpg'), // Add your placeholder image in assets
                ),
                SizedBox(width: 16),
                Text(
                  'Shrey Pachauri',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildGridItem(
                      context, Icons.person, 'My Courses', StudentDashboard()),
                  _buildGridItem(
                      context, Icons.school, 'Tests', StudentDashboard()),
                  _buildGridItem(context, Icons.location_city,
                      'Scholarships Tracker', StudentDashboard()),
                  _buildGridItem(context, Icons.category, 'Admissions ',
                      StudentDashboard()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (title == 'Feedback')
          MaterialPageRoute(builder: (context) => FeedbackForm());
        else if (title == 'Logout')
          MaterialPageRoute(builder: (context) => LoginSignupPage());
      },
    );
  }

  Widget _buildGridItem(
      BuildContext context, IconData icon, String title, Widget screen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
