import 'package:attendance_management_system/add_attendance/course1.dart';
import 'package:attendance_management_system/add_attendance/course2.dart';
import 'package:attendance_management_system/add_attendance/course4.dart';
import 'package:attendance_management_system/add_attendance/course5.dart';
import 'package:flutter/material.dart';

import 'add_attendance/course3.dart';

class AddAttendance extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddAttendance();
}

class _AddAttendance extends State<AddAttendance>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course List',
        style:  TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent
              ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Course1())
                  );
                },
                child: Text('C Programming',
                  style: TextStyle(color: Colors.white),
                )
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Course2()
                      ));
                },
                child: Text('C++',
                  style: TextStyle(color: Colors.white),
                ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> Course3())
                  );
                },
                child: Text('Python',
                  style: TextStyle(color: Colors.white),
                )
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Course4())
                  );
                },
                child: Text('Cloud Computing',
                  style: TextStyle(color: Colors.white),
                )
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Course5()
                      ));
                },
                child: Text('Machine Learning',
                  style: TextStyle(color: Colors.white),
                )
            ),
          ],
        ),
      )
    );
  }

}