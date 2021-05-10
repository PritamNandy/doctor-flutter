import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmz/home/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import '../jitsi/jitsi.dart';


class AppintmentDetails {
  final String id;
  final String patient_name;
  final String doctor_name;
  final String date;
  final String start_time;
  final String end_time;
  final String status;
  final String remarks;
  final String jitsi_link;

  AppintmentDetails(
      {this.id,
      this.patient_name,
      this.doctor_name,
      this.date,
      this.start_time,
      this.end_time,
      this.remarks,
      this.status,
      this.jitsi_link,
      
      });
}

class ShowAppointmentScreen extends StatefulWidget {
  static const routeName = '/showappointmentlist';

  String idd;
  ShowAppointmentScreen(this.idd);


  @override
  ShowAppointmentScreenState createState() => ShowAppointmentScreenState(this.idd);
}

class ShowAppointmentScreenState extends State<ShowAppointmentScreen> {

  String idd;
  ShowAppointmentScreenState(this.idd);

 Future<List<AppintmentDetails>> _responseFuture() async {
   final doctor_id = this.idd;

    var data = await http.get("http://codearistos.net/dev/hmz/api/getMyAllAppoinmentList?group=doctor&id="+doctor_id);
    var jsondata = json.decode(data.body);
    List<AppintmentDetails> _lcdata = [];
    print("asdasd");

    for (var u in jsondata) {
      AppintmentDetails subdata = AppintmentDetails(
          id: u["id"],
          patient_name: u["patient_name"],
          doctor_name: u["doctor_name"],
          date: u["date"],
          start_time: u["start_time"],
          end_time: u["end_time"],          
          remarks: u["remarks"],
          status:  u["status"],
          jitsi_link: u["jitsi_link"],
          );
      _lcdata.add(subdata);
    }
    print('a');
    return _lcdata;
  }




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appointment List")), 
      drawer: AppDrawer(),
      body: new FutureBuilder(
        future: _responseFuture(),
        builder: (BuildContext context, AsyncSnapshot response) {
          // print(response.data);
          if (response.data == null) {
            return Container(
              child: Text(' loading data'),
            );
          } else {
            // List<dynamic> jsonn = json.decode(response.data.body);
            return ListView(
              children: [
                Container(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  "Appointment List",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
                
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                itemCount: response.data.length,
                itemBuilder: (BuildContext context, int index) {
                  // return ListTile(
                  //   title: Text('${response.data[index].name} ${response.data[index].sub_code}'),
                  //   // title: Text(response.data[index].sub_code)
                  // );
                  return Container(
                    margin: EdgeInsets.only(bottom:10 ),
                    child: ExpansionTile(
                    // tilePadding: EdgeInsets.all(30),

                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          Flexible(
                              child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "${response.data[index].id}",
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            Flexible(
                              child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "${response.data[index].patient_name}",
                                  )),
                            ),
                          
                          
                        ],
                      ),
                    ),
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(0, 13, 79, 1),
                                  width: 0.2)),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              
                              title:  Row(
                                  children: [
                                    Text("Title:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].id}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text("Meeting Id:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].patient_name}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text(" Doctor Name:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].doctor_name}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text(" Date:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].date}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text("Start time:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].start_time}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text("End Time:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].end_time}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text("Remarks:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].remarks}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text("Status:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].status}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text("Jitsi link:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(child: Text("${response.data[index].jitsi_link}")),
                                  ],
                                ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 50),
                              title:  Row(
                                  children: [
                                    Text("Action:"),
                                    Padding(padding: EdgeInsets.only(right: 20),),
                                    Flexible(
                                      child:RaisedButton(
                                        onPressed: (){  
                                          print("asd");
                                          print(response.data[index].jitsi_link);
                                          

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Jitsi(link: response.data[index].jitsi_link,d_name: response.data[index].doctor_name,d_date: response.data[index].date,s_time: response.data[index].start_time,e_time: response.data[index].end_time)),
                                            
                                          );
        
                                        },
                                        child: Text('Join Live Class', style: TextStyle(fontSize: 15)),
                                      ), 
                                      ),
                                  ],
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  );
                }),
                )
              ],
            );
          }
        },
      ),  
      
    );


  }
}