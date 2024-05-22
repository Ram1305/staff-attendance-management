import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewCourse1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _viewCourse1();
}

class _viewCourse1 extends State<ViewCourse1>{

  FirebaseFirestore storage = FirebaseFirestore.instance;
  DateTime _selectedDate = DateTime.now();
  String convertedDate ='';
  TextEditingController _convertedController = TextEditingController();
  String myText ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'C Attendance List',
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
                 hintText: 'Select Date',
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
                   convertedDate = "${date.day}-${date.month}-${date.year}";
                   _convertedController.text = convertedDate;
                 });
               },
             ),

             SizedBox(
               height: 10,
             ),

             StreamBuilder(
                 stream: storage.collection('CAttendance').snapshots(),
                 builder: (context, snapshot){
                   if(!snapshot.hasData){
                     return CircularProgressIndicator();
                   }
                   return Container(
                     height: MediaQuery.of(context).size.height - 320,
                     child: ListView.builder(
                       itemCount: snapshot.data?.docs.length,
                         itemBuilder: (context, index){
                            var data = snapshot.data?.docs[index];

                            Timestamp timestamp = data?['timestamp'];
                            DateTime date = timestamp.toDate();

                            String myText = 'Absent';
                            if(data?['present'] == true){
                            myText = 'Present';
                            }
                            else{
                            myText = 'Absent';
                            }
                            if(date.day == _selectedDate.day &&
                            date.month == _selectedDate.month &&
                            date.year == _selectedDate.year
                            ){
                            return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text('Student ID : ${data?['studentid']}'),
                                      Text("Date : ${date.day}-${date.month}-${date.year }"),
                                      Row(
                                          children: [
                                          Text('Attendance : '),
                                          Text(myText)
                                      ],
                                     )
                                   ],
                               ),
                              ),
                              );
                            }
                            else{
                              return SizedBox.shrink();
                            }
                         }
                     ),
                   );
                 }
             )
           ],
         ),
       ),
    );
  }
}
