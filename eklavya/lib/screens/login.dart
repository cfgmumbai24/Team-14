import 'dart:convert';
import 'package:eklavya/constants/error_handling.dart';
import 'package:eklavya/screens/StudentDashboard.dart';
import 'package:eklavya/screens/admin_dashboard.dart';
import 'package:eklavya/screens/dashboard_mentor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum Auth {
  signup,
  signin,
}

class LoginSignupPage extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const LoginSignupPage({super.key});

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  Auth _auth = Auth.signup;
  bool isLogin = false; // Toggle between login and signup
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _adharCardController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();
  final TextEditingController _preferableLanguageController =
      TextEditingController();
  String selectedRole = 'Student'; // Default role
  String selectedEducation = 'Secondary'; // Default level of education

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
      _auth = isLogin ? Auth.signin : Auth.signup;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _dobController.dispose();
    _adharCardController.dispose();
    _panController.dispose();
    _interestController.dispose();
    _languagesController.dispose();
    _preferableLanguageController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    final url = Uri.parse('http://100.72.54.241:3000/api/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': _emailController.text,
      'password': _passwordController.text,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'location': _locationController.text,
      'dateOfBirth': _dobController.text,
      'adharCard': _adharCardController.text,
      'pan': _panController.text,
      'interest': _interestController.text,
      'languagesKnown': _languagesController.text,
      'preferableLanguage': _preferableLanguageController.text,
      'role': selectedRole,
      'levelOfEducation': selectedEducation,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Signup Successful');
        // Optionally, store user data in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', response.body);
        if (selectedRole == 'Student')
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentDashboard()),
          );
        else if (selectedRole == 'Mentor') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
          );
        }
      } else {
        Fluttertoast.showToast(msg: 'Signup Failed');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<void> login() async {
    final url = Uri.parse('http://100.72.54.241:3000/api/login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Login Successful');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', response.body);
        if (selectedRole == 'Student')
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentDashboard()),
          );
        else if (selectedRole == 'Mentor') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
          );
        }
      } else {
        Fluttertoast.showToast(msg: 'Login Failed');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget _buildRoleSpecificFields() {
    if (selectedRole == 'Student' || selectedRole == 'Mentor') {
      return Column(
        children: [
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone number'),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Level of Education'),
            value: selectedEducation,
            items: ['Secondary', 'Diploma', 'UG', 'PG', 'PhD']
                .map((String education) {
              return DropdownMenuItem<String>(
                value: education,
                child: Text(education),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedEducation = newValue!;
              });
            },
          ),
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Location'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a location';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _dobController,
            decoration: InputDecoration(labelText: 'Date of Birth'),
            keyboardType: TextInputType.datetime,
            readOnly: true,
            onTap: () => selectDate(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your date of birth';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _adharCardController,
            decoration: InputDecoration(labelText: 'Adhaar number'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Adhaar number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _interestController,
            decoration: InputDecoration(labelText: 'Area of interest'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your area of interest';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _languagesController,
            decoration: InputDecoration(labelText: 'Languages known'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the languages you know';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _preferableLanguageController,
            decoration: InputDecoration(labelText: 'Preferred language'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your preferred language';
              }
              return null;
            },
          ),
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                if (_auth == Auth.signup)
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                // if (_auth == Auth.signup)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Role'),
                  value: selectedRole,
                  items: ['Student', 'Mentor', 'Admin'].map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                ),
                if (_auth == Auth.signup) _buildRoleSpecificFields(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isLogin) {
                        login();
                      } else {
                        signup();
                      }
                    }
                  },
                  child: Text(isLogin ? 'Login' : 'Signup'),
                ),
                TextButton(
                  onPressed: toggleForm,
                  child: Text(isLogin
                      ? "Don't have an account? Sign up"
                      : "Already have an account? Log in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
