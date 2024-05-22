
import 'package:attendance_management_system/forgotpassword.dart';
import 'package:attendance_management_system/student/studentsignup.dart';
import 'package:attendance_management_system/view_attendance/viewattendance.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class studentLogin extends StatefulWidget {
  @override
  State<studentLogin> createState() => _LoginState();
}

class _LoginState extends State<studentLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailValid = true;
  bool _isPasswordVisible = false;
  bool _isPasswordValid = true;

  void _validateEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,7}$');
    setState(() {
      _isEmailValid = emailRegExp.hasMatch(email);
    });
  }

  void _validatePassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W_]).{8,}$');
    setState(() {
      _isPasswordValid = password.isNotEmpty && passwordRegExp.hasMatch(password);
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<User?> _loginUsingEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential studentCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return studentCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "student-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No student found for that email")),
        );
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:30, top: 20),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Center(
                child: Image.asset('assets/psg logo.jpg', width: 100),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                onChanged: _validateEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  errorText: _isEmailValid ? null : 'Please enter a valid email, e.g., abc@gmail.com.',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                onChanged: _validatePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  errorText: _isPasswordValid
                      ? null
                      : 'Password must contain upper, lower, digit, special char.',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text('Login'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.cyan),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () async {
                final student = await _loginUsingEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context,
                );
                if (student != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>ViewAttendance()),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  Forgotpassword()),
                );
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
