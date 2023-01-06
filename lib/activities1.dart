import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class activities1 extends StatefulWidget {
  final String user;
  final String activity;
  const activities1(
      @required this.user,this.activity,
      {Key? key}) : super(key: key
  );

  @override
  State<activities1> createState() => _activities1State();
}
class _activities1State extends State<activities1>{
  String dateconvert(DateTime d){
    String date;
    String _date1=new DateTime(d.year,d.month,d.day,d.hour,d.minute,d.second).toString();
    String date1=_date1.substring(8,10);
    String date2=monthnames[int.parse(_date1.substring(5,7))];
    String date3=_date1.substring(11,16);
    date=date1+" "+date2+" "+date3;
    return date;
  }
  var monthnames=['Jan','Feb','March','April','May','June','July','Aug','Sept','Oct','Nov','Dec'];
  late final DateTime _selecteddate;
  Future <void> opendatepicker(BuildContext context) async{
    final DateTime? d=DateTime.now();
    if (d!=null){
      setState(() {
        _selecteddate=d;
      });

    }
  }
  var message=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Column(
            children:[
              SizedBox(height: 10,),
              StreamBuilder(
                stream: readUsers(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Container();
                  }
                  else{
                    final users=snapshot.data!;
                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: users.map((User user) {
                        if (user.name == widget.user) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                                120.0, 5.0, 0.0, 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ListTile(
                                title: Text(user.name+"(${dateconvert(user.date)})",
                                  textAlign: TextAlign.right,),
                                subtitle: Text(user.chat,
                                  textAlign: TextAlign.right,),
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(
                              0.0, 5.0, 120.0, 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ListTile(
                              title: Text(user.name+"(${dateconvert(user.date)})"),
                              subtitle: Text(user.chat),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              SizedBox(
                height: 80,
              ),
            ]
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.fromLTRB(4,0,4,10),
          child: TextField(
            controller: message,
            style:TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintStyle: TextStyle(color:Colors.black),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send,color: Colors.grey,),
                onPressed: (){
                  final name1=widget.user;
                  createmesaage(name:name1,chat:message.text,date:DateTime.now());
                  message.clear();
                },
              ),
              hintText: "Enter your message here",
            ),
          ),
        ),
      ),
    );
  }
  Stream<List<User>> readUsers()=>FirebaseFirestore.instance.collection(widget.activity).orderBy('date',descending: false).snapshots().map(
          (snapshot) => snapshot.docs.map((doc)=>User.fromJson(doc.data())).toList()
  );
  Future createmesaage({required String name,required String chat,required DateTime date}) async{
    final docUser=FirebaseFirestore.instance.collection(widget.activity).doc();
    final json={
      'name':name,
      'chat':chat,
      'date':date,
    };
    await docUser.set(json);
  }
}

class User{
  final String name;
  final String chat;
  final DateTime date;

  User({
    required this.name,
    required this.chat,
    required this.date,
});

  static User fromJson(Map<String,dynamic> json)=>User(
    name:json['name'],
    chat: json['chat'],
    date: (json['date'] as Timestamp).toDate(),
  );
}