import 'package:eklavya/screens/quiz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shimmer/shimmer.dart';

class CourseModulesScreen extends StatefulWidget {
  final String courseId;

  CourseModulesScreen({required this.courseId});

  @override
  _CourseModulesScreenState createState() => _CourseModulesScreenState();
}

class _CourseModulesScreenState extends State<CourseModulesScreen> {
  List<String> youtubeLinks = [];
  List<String> moduleTitles = [];
  Map<String, String> videoTitles = {};
  Map<String, String> videoThumbnails = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourseData(widget.courseId);
  }

  Future<void> fetchCourseData(String courseId) async {
    youtubeLinks = [
      'https://www.youtube.com/watch?v=rwjdY-MAIBg',
      'https://www.youtube.com/watch?v=3JZ_D3ELwOQ',
      'https://www.youtube.com/watch?v=l482T0yNkeo',
      'https://www.youtube.com/watch?v=fJ9rUzIMcZQ',
      'https://www.youtube.com/watch?v=2Vv-BfVoq4g',
    ];

    await fetchYouTubeData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchYouTubeData() async {
    const apiKey = '';
    for (var link in youtubeLinks) {
      final videoId = Uri.parse(link).queryParameters['v'];
      if (videoId != null) {
        final url = 'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$apiKey';
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final snippet = data['items'][0]['snippet'];
          final title = snippet['title'];
          final thumbnail = snippet['thumbnails']['high']['url'];
          setState(() {
            videoTitles[link] = title;
            videoThumbnails[link] = thumbnail;
          });
        } else {
          setState(() {
            videoTitles[link] = 'Title not found';
            videoThumbnails[link] = '';
          });
        }
      } else {
        setState(() {
          videoTitles[link] = 'Invalid link';
          videoThumbnails[link] = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Modules'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            for (int i = 0; i < youtubeLinks.length; i++)
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ShimmerVideoCard(),
                    )
                  : YouTubeVideoCard(
                      videoTitle: videoTitles[youtubeLinks[i]] ?? 'Loading...',
                      videoId: Uri.parse(youtubeLinks[i]).queryParameters['v'] ?? '',
                      thumbnailUrl: videoThumbnails[youtubeLinks[i]] ?? '',
                    ),
          ],
        ),
      ),
    );
  }
}

class ShimmerVideoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 20,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100,
              height: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class YouTubeVideoCard extends StatefulWidget {
  final String videoTitle;
  final String videoId;
  final String thumbnailUrl;

  YouTubeVideoCard({
    required this.videoTitle,
    required this.videoId,
    required this.thumbnailUrl,
  });

  @override
  _YouTubeVideoCardState createState() => _YouTubeVideoCardState();
}

class _YouTubeVideoCardState extends State<YouTubeVideoCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.thumbnailUrl.isNotEmpty
              ? Image.network(
                  widget.thumbnailUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 200,
                  color: Colors.grey,
                  child: Icon(Icons.image, size: 50),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.videoTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YouTubePlayerScreen(videoId: widget.videoId),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow),
                      SizedBox(width: 5),
                      Text('Play Video'),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(),
                    ),
                  );
                },
                child: Text('Go to Test'),
              ),
            ),
        ],
      ),
    );
  }
}

class YouTubePlayerScreen extends StatelessWidget {
  final String videoId;

  YouTubePlayerScreen({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Player'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  final String testId;

  TestScreen({required this.testId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: Text('Test ID: $testId'),
      ),
    );
  }
}
