import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewStudent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ViewStudentState();

}

class _ViewStudentState extends State<ViewStudent>{

  FirebaseFirestore storage = FirebaseFirestore.instance;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  void _showEditDialog(DocumentSnapshot? data){
    _nameController.text = data?['studentname'];
    _emailController.text = data?['email'];
    _phoneController.text = data?['phone Number'];
    _idController.text = data?['studentid'];

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit Student Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Student ID'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update details in Firestore
                FirebaseFirestore.instance
                    .collection('student')
                    .doc(data?.id)
                    .update({
                  'studentid' : _idController,
                  'studentname': _nameController.text,
                  'email': _emailController.text,
                  'phone Number': _phoneController.text,
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Student',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),

      body:
      StreamBuilder(
        stream: storage.collection('student').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                var data = snapshot.data?.docs[index];
                return Card(
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
                            Text('Student Name : ${data?['studentname']}'),
                            Text('Student Email : ${data?['email']}'),
                            Text('Student Mobile : ${data?['phone Number']}')
                          ],
                        ),

                        ElevatedButton(
                            onPressed: (){
                              _showEditDialog(data);
                            },
                            child: Icon(Icons.edit)
                        ),

                        ElevatedButton(
                            onPressed: (){
                              showDialog(context: context, builder: (context)=>
                                  AlertDialog(content: Text('Want to remove student?'),
                                    actions: [
                                      IconButton(
                                          onPressed: (){
                                            FirebaseFirestore.instance
                                                .collection('student')
                                            .doc(data?.id)
                                                .delete().then((value) => Navigator.of(context).pop());
                                          },
                                          icon: Icon(Icons.check)
                                      ),
                                      IconButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.close)
                                      )
                                    ],
                                  )
                              );
                            },
                            child: Icon(Icons.delete)
                        )
                      ],
                    )
                  ),
                );
              }
          );
        },
      )
    );
  }
}