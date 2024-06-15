import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eklavya/constants/strings.dart';

class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Fields for demographic information
  String? ageGroup;
  String? gender;
  String? educationLevel;

  // Fields for academic background
  String? fieldOfStudy;
  String? currentStatus;

  // Fields for learning preferences
  List<String> learningStyles = [];
  String? studyEnvironment;
  int? studyHours;

  // Fields for technology use
  List<String> devicesUsed = [];
  String? onlineResourceUsage;

  // Fields for course and curriculum feedback
  int? courseSatisfaction;
  int? curriculumRelevance;
  int? instructorQuality;

  // Fields for support and resources
  int? advisingHelpfulness;
  List<String> academicResources = [];

  // Fields for challenges and improvements
  List<String> challenges = [];
  String? suggestions;

  // Fields for future plans
  String? postGraduationPlans;
  String? careerAspirations;

  // Fields for overall experience
  int? overallSatisfaction;
  int? recommendationLikelihood;

  Future<void> submitSurvey() async {
    final url = Uri.parse('$uri/api/surveys');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'ageGroup': ageGroup,
        'gender': gender,
        'educationLevel': educationLevel,
        'fieldOfStudy': fieldOfStudy,
        'currentStatus': currentStatus,
        'learningStyles': learningStyles,
        'studyEnvironment': studyEnvironment,
        'studyHours': studyHours,
        'devicesUsed': devicesUsed,
        'onlineResourceUsage': onlineResourceUsage,
        'courseSatisfaction': courseSatisfaction,
        'curriculumRelevance': curriculumRelevance,
        'instructorQuality': instructorQuality,
        'advisingHelpfulness': advisingHelpfulness,
        'academicResources': academicResources,
        'challenges': challenges,
        'suggestions': suggestions,
        'postGraduationPlans': postGraduationPlans,
        'careerAspirations': careerAspirations,
        'overallSatisfaction': overallSatisfaction,
        'recommendationLikelihood': recommendationLikelihood,
      }),
    );

    if (response.statusCode == 201) {
      // Handle success
      print('Survey submitted successfully');
    } else {
      // Handle error
      print('Failed to submit survey: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Survey Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Demographic Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Age Group'),
                items: [
                  'Under 18',
                  '18-24',
                ].map((age) {
                  return DropdownMenuItem(
                    value: age,
                    child: Text(age),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    ageGroup = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                items: [
                  'Male',
                  'Female',
                  'Non-binary/Third gender',
                  'Prefer not to say'
                ].map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration:
                    InputDecoration(labelText: 'Highest Education Level'),
                items: [
                  'High school or equivalent',
                  'Some college, no degree',
                  'Bachelor’s degree',
                  'Other'
                ].map((education) {
                  return DropdownMenuItem(
                    value: education,
                    child: Text(education),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    educationLevel = value;
                  });
                },
              ),
              Text('Academic Background',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: InputDecoration(labelText: 'Field of Study'),
                onChanged: (value) {
                  setState(() {
                    fieldOfStudy = value;
                  });
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Current Academic Status'),
                onChanged: (value) {
                  setState(() {
                    currentStatus = value;
                  });
                },
              ),
              Text('Learning Preferences',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: Text('Visual'),
                value: learningStyles.contains('Visual'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      learningStyles.add('Visual');
                    } else {
                      learningStyles.remove('Visual');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Auditory'),
                value: learningStyles.contains('Auditory'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      learningStyles.add('Auditory');
                    } else {
                      learningStyles.remove('Auditory');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Kinesthetic'),
                value: learningStyles.contains('Kinesthetic'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      learningStyles.add('Kinesthetic');
                    } else {
                      learningStyles.remove('Kinesthetic');
                    }
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration:
                    InputDecoration(labelText: 'Preferred Study Environment'),
                items: ['Online', 'Classroom', 'Home', 'Other'].map((env) {
                  return DropdownMenuItem(
                    value: env,
                    child: Text(env),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    studyEnvironment = value;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                decoration:
                    InputDecoration(labelText: 'Average Study Hours Per Day'),
                items: List.generate(24, (index) => index + 1).map((hour) {
                  return DropdownMenuItem(
                    value: hour,
                    child: Text('$hour hours'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    studyHours = value;
                  });
                },
              ),
              Text('Scholarship Received',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: Text('70%-80%'),
                value: devicesUsed.contains('Laptop'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      devicesUsed.add('Laptop');
                    } else {
                      devicesUsed.remove('Laptop');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('80%-90%'),
                value: devicesUsed.contains('Tablet'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      devicesUsed.add('Tablet');
                    } else {
                      devicesUsed.remove('Tablet');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('100%'),
                value: devicesUsed.contains('Smartphone'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      devicesUsed.add('Smartphone');
                    } else {
                      devicesUsed.remove('Smartphone');
                    }
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText:
                        'Frequency of Using Online Educational Resources'),
                items: [
                  'Daily',
                  'Several times a week',
                  'Weekly',
                  'Monthly',
                  'Rarely'
                ].map((frequency) {
                  return DropdownMenuItem(
                    value: frequency,
                    child: Text(frequency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    onlineResourceUsage = value;
                  });
                },
              ),
              Text('Course and Curriculum Feedback',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<int>(
                decoration:
                    InputDecoration(labelText: 'Course Satisfaction (1-5)'),
                items: List.generate(5, (index) => index + 1).map((rating) {
                  return DropdownMenuItem(
                    value: rating,
                    child: Text('$rating'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    courseSatisfaction = value;
                  });
                },
              ),
              Text('Admission Stage',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: Text('Looking for opportunities'),
                value: academicResources.contains('Library'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      academicResources.add('Library');
                    } else {
                      academicResources.remove('Library');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Applied'),
                value: academicResources.contains('Tutoring Services'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      academicResources.add('Tutoring Services');
                    } else {
                      academicResources.remove('Tutoring Services');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Offer Received'),
                value: academicResources.contains('Online Forums'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      academicResources.add('Online Forums');
                    } else {
                      academicResources.remove('Online Forums');
                    }
                  });
                },
              ),
              Text('Challenges and Improvements',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: Text('Time Management'),
                value: challenges.contains('Time Management'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      challenges.add('Time Management');
                    } else {
                      challenges.remove('Time Management');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Course Load'),
                value: challenges.contains('Course Load'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      challenges.add('Course Load');
                    } else {
                      challenges.remove('Course Load');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Balancing Work and Study'),
                value: challenges.contains('Balancing Work and Study'),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      challenges.add('Balancing Work and Study');
                    } else {
                      challenges.remove('Balancing Work and Study');
                    }
                  });
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Suggestions for Improvement'),
                onChanged: (value) {
                  setState(() {
                    suggestions = value;
                  });
                },
              ),
              Text('Future Plans',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: InputDecoration(labelText: 'Post-Graduation Plans'),
                onChanged: (value) {
                  setState(() {
                    postGraduationPlans = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Career Aspirations'),
                onChanged: (value) {
                  setState(() {
                    careerAspirations = value;
                  });
                },
              ),
              Text('Overall Experience',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                    labelText:
                        'Overall Satisfaction with Educational Experience (1-5)'),
                items: List.generate(5, (index) => index + 1).map((rating) {
                  return DropdownMenuItem(
                    value: rating,
                    child: Text('$rating'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    overallSatisfaction = value;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                    labelText:
                        'Likelihood to Recommend the Institution to Others (1-5)'),
                items: List.generate(5, (index) => index + 1).map((rating) {
                  return DropdownMenuItem(
                    value: rating,
                    child: Text('$rating'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    recommendationLikelihood = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitSurvey();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
