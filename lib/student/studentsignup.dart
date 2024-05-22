import 'package:attendance_management_system/student/studentsigin.dart';
import 'package:attendance_management_system/view_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class studentSignuppage extends StatefulWidget {
  @override
  _Example createState() => _Example();
}

class _Example extends State  <studentSignuppage> {
  final TextEditingController _studentidController =TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _studentnameController = TextEditingController();
  bool _isstudentnameValid = true;
  bool _isPhoneNumberValid = true;

  bool _isstudentidValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _signUpInProgress = false;
  String? _passwordErrorText;
  void _validatestudentname(String studentname) {
    final studentnameRegExp = RegExp(r'^[a-zA-Z ]+$');
    setState(() {
      _isstudentnameValid = studentnameRegExp.hasMatch(studentname);
    });
  }
  void  _validateFacultid (String studentid) {
    final studentnameRegExp = RegExp(r'^[a-zA-Z 0-9]+$');
    setState(() {
      _isstudentidValid = studentnameRegExp.hasMatch(studentid);
    });
  }
  void _validateEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    setState(() {
      _isEmailValid = emailRegExp.hasMatch(email);
    });
  }

  void _PhoneNumberValid(String phoneNumber) {
    final phoneNumberRegExp = RegExp(r'^\+?[1-9]\d{9}$');
    setState(() {
      _isPhoneNumberValid = phoneNumberRegExp.hasMatch(phoneNumber);
    });
  }


  void _validatePassword(String password) {
    final passwordRegExp =
    RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W_]).{8,}$');
    setState(() {
      _isPasswordValid =
          password.isNotEmpty && passwordRegExp.hasMatch(password);
    });

    if (password.isNotEmpty) {
      if (!passwordRegExp.hasMatch(password)) {
        setState(() {
          _passwordErrorText = ' please enter your password';
        });
      } else {
        setState(() {
          _passwordErrorText = ' password must be 8 character';
        });
      }
    } else {
      setState(() {
        _passwordErrorText = 'Password  okk';
      });
    }
  }

  void _validateConfirmPassword(String confirmPassword) {
    setState(() {
      _isConfirmPasswordValid = _passwordController.text == confirmPassword;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  Future<void> _signUpWithEmailAndPassword(
      String studentid,
      String studentname,
      String email,
      String password,
      String confirmPassword,
      String phoneNumber,
      ) async {
    setState(() {
      _signUpInProgress = true;
    });
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential userCredential  =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if ( userCredential.user != null) {
        await _savestudentDataToFirestore(
          studentid,
          studentname,
          email,
          password,
          phoneNumber,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up successful!'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>ViewStudent()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email or Password is wrong or already registered?.'),
          duration: Duration(seconds: 3),
        ),
      );

      print('Error signing up: $e');
    } finally {
      setState(() {
        _signUpInProgress = false;
      });
    }
  }

  Future<void> _savestudentDataToFirestore(
      String studentid, String studentname, String email, String password,String PhoneNumber) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('student').doc(uid).set({
          'studentid': studentid,
          'studentname': studentname,
          'email': email,
          'password': password,
          'phone Number':PhoneNumber,
        });
        print('student data saved to Firestore: $email, $password');
      }
    } catch (e) {
      print('Error saving student data to Firestore: $e');
    }
  }
  void _submitForm() {
    String phoneNumber = _phoneNumberController.text;
    if (!_isPhoneNumberValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid phone number')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Image.asset(
                'assets/psg logo.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text('Sign Up',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  )),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _studentidController,
                onChanged: _validateFacultid,
                decoration: InputDecoration(
                  labelText: 'studentid',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  errorText: _isstudentidValid
                      ? null
                      : 'Please enter your Student ID',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: _studentnameController,
                onChanged: _validatestudentname,
                decoration: InputDecoration(
                  labelText: 'Student name',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  errorText: _isstudentnameValid
                      ? null
                      : 'Please enter your name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                keyboardType: TextInputType. phone,
                controller: _phoneNumberController,
                onChanged: _PhoneNumberValid,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blueAccent,
                  ),
                  errorText: _isPhoneNumberValid
                      ? null
                      : 'please enter values of 10 digits.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        color: Colors.blueAccent), // Outline border color
                  ),
                ),
              ),
              SizedBox(height: 22),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                onChanged: _validateEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.blueAccent,
                  ),
                  errorText: _isEmailValid
                      ? null
                      : 'please enter valid email ex.abc@gmail.com.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 22),
              TextField(
                controller: _passwordController,
                onChanged: _validatePassword,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blueAccent,
                  ),
                  errorText: _isPasswordValid
                      ? null
                      : 'Password contains one uppercase,lowercase letter, one digit, and one special character.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        color: Colors.blueAccent), // Outline border color
                  ),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22),
              TextField(
                controller: _confirmPasswordController,
                onChanged: _validateConfirmPassword,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  errorText: _isConfirmPasswordValid
                      ? null
                      : 'Passwords does not match',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide
                      (color: Colors.blueAccent),
                    // Outline border color
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blueAccent,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleConfirmPasswordVisibility,
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _signUpInProgress
                    ? null
                    : () {
                  if (_studentnameController.text.isEmpty) {
                    setState(() {
                      _isstudentnameValid = false;
                    });
                  }
                  if (_emailController.text.isEmpty) {
                    setState(() {
                      _isEmailValid = false;
                    });
                  }
                  if (_passwordController.text.isEmpty) {
                    setState(() {
                      _isPasswordValid = false;
                    });
                  }

                  if (_confirmPasswordController.text.isEmpty) {
                    setState(() {
                      _isConfirmPasswordValid = false;
                    });
                  } else {
                    _signUpWithEmailAndPassword(
                      _studentidController.text,
                      _studentnameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text,
                      _phoneNumberController.text,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3, // Shadow elevation
                ),
                child: Text(
                  'Add Student',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),

            ],
          ),
        ),
      ),
    );
  }
}