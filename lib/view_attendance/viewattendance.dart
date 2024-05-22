import 'package:attendance_management_system/add_attendance/course1.dart';
import 'package:attendance_management_system/add_attendance/course2.dart';
import 'package:attendance_management_system/add_attendance/course4.dart';
import 'package:attendance_management_system/add_attendance/course5.dart';
import 'package:attendance_management_system/view_attendance/viewcourse1.dart';
import 'package:attendance_management_system/view_attendance/viewcourse2.dart';
import 'package:attendance_management_system/view_attendance/viewcourse3.dart';
import 'package:attendance_management_system/view_attendance/viewcourse4.dart';
import 'package:attendance_management_system/view_attendance/viewcourse5.dart';
import 'package:flutter/material.dart';


class ViewAttendance extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _viewAttendanceState();
}

class _viewAttendanceState extends State<ViewAttendance>{
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
                        MaterialPageRoute(builder: (context)=>ViewCourse1()
                        ));
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
                      MaterialPageRoute(builder: (context)=>ViewCourse2())
                  );
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
                        MaterialPageRoute(builder: (context)=>ViewCourse3()
                        ));
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
                        MaterialPageRoute(builder: (context)=>ViewCourse4()
                        ));
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
                        MaterialPageRoute(builder: (context)=>ViewCourse5()
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