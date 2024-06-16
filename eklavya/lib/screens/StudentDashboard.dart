import 'package:eklavya/screens/CoursesModules.dart';
import 'package:eklavya/screens/feedbackForm.dart';
import 'package:eklavya/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

class StudentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Eklavya'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'My Mentor'),
              Tab(text: 'Job Posting'),
              Tab(text: 'My Favourites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            CoursesTab(),
            CommunitiesTab(),
            FavouritesTab(),
          ],
        ),
        drawer: AppDrawer(),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(
                  context,
                  '0',
                  'ENROLLED',
                  const Color.fromRGBO(156, 39, 176, 1),
                  CoursesEnrolledScreen()),
              _buildStatCard(
                  context,
                  '0',
                  'COMPLETED',
                  const Color.fromARGB(255, 50, 169, 102),
                  CoursesCompletedScreen()),
            ],
          ),
          SizedBox(height: 32),
          _buildSectionTitle('Your Courses'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CourseCompletionCard(
                  imageUrl:
                      'https://images.shiksha.com/mediadata/images/articles/1664461243phpY2xZ72.jpeg', // Replace with actual image URL
                  courseTitle: 'LAW',
                  instructorName: 'Mr. Ashutosh Kumar',
                  isCompleted: false,
                  screen: CourseModulesScreen(
                    courseId: "jhasgdjhewgfue",
                  ), // Example completion status
                ),
                CourseCompletionCard(
                  imageUrl:
                      'https://iimtu.edu.in/blog/wp-content/uploads/2023/10/Chemistry-1.jpg', // Replace with actual image URL
                  courseTitle: 'LAW',
                  instructorName: 'Mr. Ashutosh Kumar',
                  isCompleted: false,
                  screen: StudentDashboard(), // Example completion status
                ),
                CourseCompletionCard(
                  imageUrl:
                      'https://images.shiksha.com/mediadata/images/articles/1664461243phpY2xZ72.jpeg', // Replace with actual image URL
                  courseTitle: 'LAW',
                  instructorName: 'Mr. Ashutosh Kumar',
                  isCompleted: false, // Example completion status,
                  screen: StudentDashboard(),
                ),
                CourseCompletionCard(
                  imageUrl:
                      'https://iimtu.edu.in/blog/wp-content/uploads/2023/10/Chemistry-1.jpg', // Replace with actual image URL
                  courseTitle: 'LAW',
                  instructorName: 'Mr. Ashutosh Kumar',
                  isCompleted: false,
                  screen: StudentDashboard(), // Example completion status
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildSectionTitle('Upcoming Exams'),
          SizedBox(height: 15),
          TestContainer(testName: 'National Exam', testDate: '19/08/04'),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String count, String label,
      Color color, Widget targetScreen) {
    return Container(
      child: Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetScreen),
            );
          },
          child: Card(
            elevation: 4,
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    count,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSlidableCard() {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: const [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Icon(Icons.info_outline, color: Colors.blue),
          title: Text('No Records Found'),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}

class CoursesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor Details'),
        // leading: IconButton(onPressed: () {  },

        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lottie animation at the top
              Center(
                child: Lottie.asset(
                  'images/hi.json', // Ensure you have the 'hi' Lottie file in the assets directory
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              // Mentor details
              Text(
                'Mentor Details:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Name: John Doe',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                'Position: Senior Software Engineer',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                'Email: john.doe@example.com',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              // Contact via Phone Card
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone, color: Colors.green),
                  title: Text('Contact via Phone'),
                  onTap: () {
                    // Add phone contact functionality here
                  },
                ),
              ),
              SizedBox(height: 10),
              // Video Call Card
              Card(
                child: ListTile(
                  leading: Icon(Icons.video_call, color: Colors.blue),
                  title: Text('Video Call'),
                  onTap: () {
                    // Add video call functionality here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunitiesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Communities'));
  }
}

class FavouritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('My Favourites Tab'));
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              color: Colors.red,
            ),
          ),
          _buildDrawerItem(Icons.feedback, 'Feedback', context),
          _buildDrawerItem(Icons.logout, 'Logout', context),
          SwitchListTile(
            title: Text('Allow Notifications'),
            value: true,
            onChanged: (bool value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (title == 'Feedback')
          MaterialPageRoute(builder: (context) => FeedbackForm());
        else if (title == 'Logout')
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginSignupPage()),
          );
      },
    );
  }
}

// Define new screens for navigation

class CoursesEnrolledScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending'),
      ),
      body: Center(
        child: Text('Completed'),
      ),
    );
  }
}

class CoursesCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed'),
      ),
      body: Center(
        child: Text('Pending'),
      ),
    );
  }
}

class CertificatesAchievedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificates Achieved'),
      ),
      body: Center(
        child: Text('Certificates Achieved Screen'),
      ),
    );
  }
}

class CommunitiesSubscribedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Communities Subscribed'),
      ),
      body: Center(
        child: Text('Communities Subscribed Screen'),
      ),
    );
  }
}

class CourseCompletionCard extends StatelessWidget {
  final String imageUrl;
  final String courseTitle;
  final String instructorName;
  final bool isCompleted;
  final Widget screen;

  CourseCompletionCard({
    required this.imageUrl,
    required this.courseTitle,
    required this.instructorName,
    required this.screen,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Image at the top
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 100,
              ),
              // Course details in the middle
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      courseTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Instructor: $instructorName',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      isCompleted ? 'Completed' : 'Not Completed',
                      style: TextStyle(
                        fontSize: 16,
                        color: isCompleted ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceCard extends StatefulWidget {
  @override
  _AttendanceCardState createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Card'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'User Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Name:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Email:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Attendance Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    // Animated bar graph
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: _animation.value * 300,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${(_animation.value * 100).toInt()}% Attendance',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TestContainer extends StatelessWidget {
  final String testName;
  final String testDate;

  TestContainer({
    required this.testName,
    required this.testDate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: InkWell(
        splashColor: Colors.black,
        child: Container(
          width: 320,
          height: 120,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 242, 239, 243),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                  height: 95,
                  width: 95,
                  child: Lottie.asset("images/exam.json")),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      testName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      testDate,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
