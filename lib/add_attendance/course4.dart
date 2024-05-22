import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class Course4 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_course4();
}

class _course4 extends State<Course4>{

  final _cloudAttendance = FirebaseFirestore.instance.collection('CloudAttendance');
  FirebaseFirestore storage = FirebaseFirestore.instance;
  DateTime _selectedDate = DateTime.now();
  String convertedDate ='';
  TextEditingController _convertedController = TextEditingController();
  Map<String, bool> attendanceMap = {};

  TextEditingController dateInput = TextEditingController();

  Future<void> updateAttendance(String studentid, bool present) async {
    try{
      var document = await storage.collection('CloudAttendance').doc('$studentid - $convertedDate').get();
      if(document.exists){
        await storage.collection('CloudAttendance').doc('$studentid - $convertedDate')
            .update({
          'studentid' : studentid,
          'present' : present,
          'timestamp' : _selectedDate
        });
      }
      else{
        await storage.collection('CloudAttendance').doc('$studentid - $convertedDate').set(
            {
              'studentid' : studentid,
              'present' : present,
              'timestamp' : _selectedDate
            }
        );
      }
      print('Attendance updated');
    }
    catch(e) {
      print('Fialed to update $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cloud Attendance',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('Select Date',
                style: TextStyle(fontSize: 20,),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _convertedController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                onTap: () async{
                  DateTime? pick = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  setState(() {
                    _selectedDate = pick!;
                    var date = DateTime.parse(_selectedDate.toString());
                    convertedDate = "${date.month}-${date.day}-${date.year}";
                    _convertedController.text = convertedDate;
                  });
                },

              ),
              SizedBox(
                height: 10,
              ),

              StreamBuilder(
                  stream: storage.collection('student').snapshots()
                  , builder: (context , snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                return Container(
                  height: MediaQuery.of(context).size.height - 320,
                  child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder:(context, index){
                        var data = snapshot.data?.docs[index];
                        bool present = attendanceMap.containsKey(data?['studentid']) ? attendanceMap[data?['studentid']]! : false;
                        return Card(
                          color: Colors.blue.shade100,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Student ID : ${data?['studentid']}'),
                                      Text('Student Name : ${data?['studentname']}')
                                    ],
                                  ),
                                  Switch(
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    value: present,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        attendanceMap[data?['studentid']] = newValue;
                                        updateAttendance(data?['studentid'], newValue);
                                      });
                                    },
                                  )
                                ],
                              )
                          ),
                        );
                      }
                  ),
                );
              }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('Save',
                    style: TextStyle(color: Colors.white),
                  )
              )
            ],
          ),
        )
    );
  }
}