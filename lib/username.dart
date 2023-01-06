import 'package:dummyproject/newmessage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyproject/newmessage.dart';

void main()=>{
  runApp(MaterialApp(
    home: username()
))
};

class username extends StatefulWidget {
  const username({Key? key}) : super(key: key);

  @override
  State<username> createState() => _usernameState();
}

class _usernameState extends State<username> {
  var username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 540,
              ),
              Container(
                width: 350,
                child: TextField(
                  controller: username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.account_box, color: Colors.green,),
                      onPressed: () {},
                    ),
                    hintText: 'Enter your username',
                    labelText: 'Username',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(350, 50),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: Text('Continue'),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            newmeassage(username.text)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
