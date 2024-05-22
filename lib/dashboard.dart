import 'package:attendance_management_system/facultylogin.dart';
import 'package:attendance_management_system/facultysignuppage.dart';
import 'package:attendance_management_system/student/studentsigin.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  @override
  _Second createState() => _Second();
}

class _Second extends State<Dashboard> {
  String _greeting = '';

  @override
  void initState() {
    super.initState();
    _updateGreeting();
  }

  void _updateGreeting() {
    final currentTime = DateTime.now();
    final currentTimeOfDay = currentTime.hour;
    String newGreeting = '';

    if (currentTimeOfDay >= 0 && currentTimeOfDay < 12) {
      newGreeting = 'Good Morning';
    } else if (currentTimeOfDay >= 12 && currentTimeOfDay < 17) {
      newGreeting = 'Good Afternoon';
    } else {
      newGreeting = 'Good Evening';
    }

    setState(() {
      _greeting = newGreeting;
    });
  }

  void _AdminPressed() {
    // Navigate to the next page (replace NextPage with your actual page)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signuppage()),
    );
  }
  void _LoginPressed() {
    // Navigate to the next page (replace NextPage with your actual page)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => studentLogin()),
    );
  }

  // void _SignupPressed() {
  //   // Navigate to the next page (replace NextPage with your actual page)
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => SignupScreen()),
  //   );
  // }
  void _Adminlogin() {
    // Navigate to the next page (replace NextPage with your actual page)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/psg logo.jpg",
                width: 400,
                height: 400,
              ),
            ),
            Text(
              _greeting,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20), // Adding some space between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Adding space below buttons
                Center(
                  child: ElevatedButton(
                    onPressed: _AdminPressed,
                    child: Text('Faculty Signup',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .blueAccent, // Make button background transparent
                      elevation: 0, // Remove button elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.black), // Add border
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _Adminlogin,
                    child: Text('Faculty Login',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .blueAccent, // Make button background transparent
                      elevation: 0, // Remove button elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.black), // Add border
                      ),
                    ),
                  ),

                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.blue, // Customize the button color
              ),
              child: ElevatedButton(
                onPressed: _LoginPressed,
                child: Text('Student Signin',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Make button background transparent
                  elevation: 0, // Remove button elevation
                ),
              ),

            ),
            SizedBox(height: 20), // Increased space between buttons
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(80),
            //     color: Colors.blueAccent, // Customize the button color
            //   ),
            //   child: ElevatedButton(
            //     onPressed: _LoginPressed,
            //     child: Text(' Security Login',
            //         style: TextStyle(
            //           fontSize: 20,
            //         )),
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors
            //           .transparent, // Make button background transparent
            //       elevation: 0, // Remove button elevation
            //     ),
            //   ),
            // ),
          ],
        ),



      ),

    );
  }
}