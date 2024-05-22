import 'package:attendance_management_system/addattendance.dart';
import 'package:attendance_management_system/student/studentsignup.dart';
import 'package:attendance_management_system/view_attendance/viewattendance.dart';
import 'package:attendance_management_system/view_student.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StaffDashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _staffDashboard();
}

class _staffDashboard extends State<StaffDashboard>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>studentSignuppage())
                  );
                },
                child: Text('Add Student Account',
                  style: TextStyle(color: Colors.white),
                )
            ),

            SizedBox(
              height: 15,
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>ViewStudent())
                  );
                },
                child: Text('View Student',
                  style: TextStyle(color: Colors.white),
                )
            ),

            SizedBox(
              height: 15,
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>AddAttendance())
                  );
                },
                child: Text('Add Attendance',
                  style: TextStyle(color: Colors.white),
                )
            ),

            SizedBox(
              height: 15,
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAttendance()));
                },
                child: Text('View Attendance',
                  style: TextStyle(color: Colors.white),
                )
            ),

            SizedBox(
              height: 15,
            ),

            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blueAccent
            //   ),
            //     onPressed: (){},
            //     child: Text('Report',
            //       style: TextStyle(color: Colors.white),
            //     )
            // )
          ],
        ),
      )
    );
  }

}