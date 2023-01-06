import 'package:flutter/material.dart';
import 'package:dummyproject/activities1.dart';

class newmeassage extends StatefulWidget {
  final String username;
  const newmeassage(
      @required this.username,
      {Key? key}) : super(key: key
  );
  @override
  State<newmeassage> createState() => _newmeassageState();
}

class _newmeassageState extends State<newmeassage> {
  var activities12=['Football','Photography','Singing','Painting'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Room'),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child:Column(
            children: [
              SizedBox(
                child:Icon(Icons.account_box,color: Colors.green,size: 180),
                height: 200,
              ),
              SizedBox(
                child:Text(widget.username,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                height:20,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Container(
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          minimumSize: Size(350,50),
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          backgroundColor: Colors.white,
                        ),
                        child:Row(
                          children: [
                            SizedBox(child:Text(activities12[index],style: TextStyle(color: Colors.grey),)),
                          ],
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>activities1(widget.username.toString(),activities12[index])));
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 10,);
                  },
                  itemCount: activities12.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
