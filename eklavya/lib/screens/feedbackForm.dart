import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eklavya/constants/strings.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String? _overallSatisfaction;
  String? _courseContent;
  String? _courseMaterials;
  String? _pacing;
  String? _instructorEffectiveness;
  String? _courseOrganization;
  String _additionalComments = '';

  final List<String> satisfactionOptions = [
    'Very Satisfied',
    'Satisfied',
    'Neutral',
    'Dissatisfied',
    'Very Dissatisfied'
  ];

  final List<String> contentOptions = [
    'Excellent',
    'Good',
    'Average',
    'Poor',
    'Very Poor'
  ];

  final List<String> materialsOptions = [
    'Very Useful',
    'Useful',
    'Neutral',
    'Not Useful',
    'Very Not Useful'
  ];

  final List<String> pacingOptions = ['Too Fast', 'Just Right', 'Too Slow'];

  final List<String> effectivenessOptions = [
    'Very Effective',
    'Effective',
    'Neutral',
    'Ineffective',
    'Very Ineffective'
  ];

  final List<String> organizationOptions = [
    'Very Well Organized',
    'Well Organized',
    'Neutral',
    'Poorly Organized',
    'Very Poorly Organized'
  ];

  void submitFeedback() async {
    final url = Uri.parse('$uri/api/feedback');
    final Map<String, dynamic> feedbackData = {
      'overallSatisfaction': _overallSatisfaction,
      'courseContent': _courseContent,
      'courseMaterials': _courseMaterials,
      'pacing': _pacing,
      'instructorEffectiveness': _instructorEffectiveness,
      'courseOrganization': _courseOrganization,
      'additionalComments': _additionalComments,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(feedbackData),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit feedback')),
      );
    }
  }

  Widget _buildRadioGroup(String label, List<String> options,
      String? groupValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...options.map((option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: groupValue,
              onChanged: onChanged,
            )),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Feedback Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildRadioGroup(
                'Overall Satisfaction',
                satisfactionOptions,
                _overallSatisfaction,
                (value) => setState(() => _overallSatisfaction = value),
              ),
              _buildRadioGroup(
                'Course Content',
                contentOptions,
                _courseContent,
                (value) => setState(() => _courseContent = value),
              ),
              _buildRadioGroup(
                'Course Materials',
                materialsOptions,
                _courseMaterials,
                (value) => setState(() => _courseMaterials = value),
              ),
              _buildRadioGroup(
                'Pacing',
                pacingOptions,
                _pacing,
                (value) => setState(() => _pacing = value),
              ),
              _buildRadioGroup(
                'Instructor Effectiveness',
                effectivenessOptions,
                _instructorEffectiveness,
                (value) => setState(() => _instructorEffectiveness = value),
              ),
              _buildRadioGroup(
                'Course Organization',
                organizationOptions,
                _courseOrganization,
                (value) => setState(() => _courseOrganization = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Additional Comments'),
                maxLines: 4,
                onSaved: (value) => _additionalComments = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    submitFeedback();
                    _formKey.currentState!.reset();
                    setState(() {
                      _overallSatisfaction = null;
                      _courseContent = null;
                      _courseMaterials = null;
                      _pacing = null;
                      _instructorEffectiveness = null;
                      _courseOrganization = null;
                      _additionalComments = '';
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
