import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmz/home/widgets/app_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';

import 'dart:async';
import 'dart:convert';
import 'showAppointment.dart';



class Patient {
  final String id;
  final String image;
  final String name;
  

  Patient({
    this.id,
    this.image,
    this.name,
    
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['img_url'] as String,
      image: json['name'] as String,
    );
  }
}

class AppointmentDetailsScreen extends StatefulWidget {
  static const routeName = '/Appointmentdetail';

  String idd;
  String useridd;
  AppointmentDetailsScreen(this.idd,this.useridd);


  @override
  AppointmentDetailsScreenState createState() => AppointmentDetailsScreenState(this.idd,this.useridd);
}

class AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {

  String idd;
  String useridd;
  AppointmentDetailsScreenState(this.idd,this.useridd);


  final _formKey = GlobalKey<FormState>();
  String patient ;  
  var patientlist = "";
  Future<List<Patient>> users ;
 

  String _mySelection;
  String _mySelection2;
  String _mySelection3;

  final String url = "http://codearistos.net/dev/hmz/api/getPatientList?id=";
  final String url2 = "https://my-json-server.typicode.com/adsaurnab/jsondays/days";

  List data = List(); 
  List data2 = List(); 
  List data3 = ['Confirmed','Pending','Requested']; 
  String availableSlot = '';
  String appointmentStatus ;
  TextEditingController _doctor = TextEditingController();
  DateTime selectedDate;

  
  _doctorVal(){
    return _doctor;
  }
  String _date ="";
  final _remarks = TextEditingController();


 

  Future<String> getDoctorSlot(getslot) async {
    var res = await http
        .get(Uri.encodeFull(getslot), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);    

    setState(() {
      data2 = resBody;
      
    });

    return "success";
  }

  Future<String> getSWData() async {

    String urrr1 =url+"${this.useridd}";
    print(urrr1);
    var res = await http
        .get(urrr1, headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print(res);

    setState(() {
      data = resBody;
      
    });
    

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
    _doctor = new TextEditingController(text: this.idd );
  }

  

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment"),
        
      ),
      drawer: AppDrawer(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              
              height: 700,
              child: ListView(
                padding: EdgeInsets.all(20) ,
                children: [
                  Container(
                    child: Center(
                      child: Text("Add Appointment",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 25,                          
                        ),  

                      ),
                    ),
                  ),
                  Divider(),
                  Padding(padding: EdgeInsets.only(bottom: 30)),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: <Widget>[   

                        

                        
                          
                          Center(child: Text("Patient",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              
                              
                                child: Container(
                                 
                                  width: double.infinity,
                                  
                                  child: new DropdownButton(
                                      items: data.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item['name']),
                                          value: item['id'],
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          this._mySelection = newVal;
                                          this .patient = newVal;
                                        });
                                      },
                                      value: this._mySelection,
                                    ),
                             

                                  ),
                               
                            ),
                          ),
                          

                        Divider(),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              
                                child: Container(
                                  
                                  width: double.infinity,
                                  
                                  
                                  child: TextFormField(
                                    controller: _doctor,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: 'Doctor',
                                      border: OutlineInputBorder(),
                                      hintText: 'Doctors name'
                                    ),
                                  
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Choose the doctor';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              
                            ),
                          ),

                        
                        Divider(),                        
        
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              
                                child: Container(
                                  
                                  width: double.infinity,
                                  
                                  
                                  child: Center(
                                    child: DateTimeField(
                                      dateFormat: DateFormat("y/M/d"),
                                      
                                      decoration: const InputDecoration(
                                          hintText: 'Select the date '),
                                      selectedDate: selectedDate,

                                      mode: DateTimeFieldPickerMode.date,
                                        
                                      onDateSelected: (DateTime value) {
                                        setState(() {
                                          selectedDate = value;
                                          String formattedDate = DateFormat('yyyy-MM-dd').format(value);
                                          this._date = formattedDate ;

                                          
                                          String getslot = 'https://codearistos.net/dev/hmz/api/getDoctorTimeSlop?doctor_id='+_doctor.text+'&date='+formattedDate;
                                          getDoctorSlot(getslot);
                                          
                                          

                                        });
                                      }
                                    ),
                                  ),
                                  
                                ),
                              
                            ),
                          ),


                        Divider(),
                        
                          Center(child: Text("Available Slots",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              
                                child: Container(
                                  
                                  width: double.infinity,
                                  
                                  child: new DropdownButton(
                                      items: data2.map((item2) {
                                        return new DropdownMenuItem(
                                          child: new Text(item2['s_time']+" - "+item2['e_time']),
                                          value: item2['s_time']+" To "+item2['e_time'],
                                        );
                                      }).toList(),
                                      onChanged: (newVal2) {
                                        setState(() {
                                          this._mySelection2 = newVal2;
                                          this.availableSlot = newVal2;
                                        });
                                      },
                                      value: this._mySelection2,
                                    ),
                                  

                                ),
                              
                            ),
                          ),


                        Divider(),  
                          
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              
                                child: Container(
                                  
                                  width: double.infinity,
                                  
                                  child: TextFormField(
                                    controller: _remarks,

                                    decoration: InputDecoration(
                                      labelText: 'Remarks',
                                      border: OutlineInputBorder(),
                                      hintText: 'Give your remarks'
                                    ),
                                  
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              
                            ),
                          ),


                        Divider(),                        
                                                
                          Center(child: Text("Appointment status",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          
                          )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              
                                child: Container( 
                                  
                                  width: double.infinity,
                                  
                                  child: new DropdownButton(
                                      items: data3.map((item3) {
                                        return new DropdownMenuItem(
                                          child: new Text(item3),
                                          value: item3,
                                        );
                                      }).toList(),
                                      onChanged: (newVal3) {
                                        setState(() {
                                          this._mySelection3 = newVal3;
                                          this.appointmentStatus = newVal3;
                                        });
                                      },
                                      value: this._mySelection3,
                                    ),

                                  
                                ),
                              
                            ),
                          ),
                       

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: leaveApplicationscaffold(_formKey,patient,_doctor.text,_date,availableSlot, _remarks.text, appointmentStatus ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ]
        )
      )

    );
  } 



}

class leaveApplicationscaffold extends StatelessWidget {
  final _formKey;
  final  patient;
  final  _doctor; 
  final  _date; 
  final  availableSlot;
  final   _remarks; 
  final  appointmentStatus;

  String success = "";
  
  leaveApplicationscaffold(this._formKey,this.patient,this._doctor,this._date,this.availableSlot, this._remarks, this.appointmentStatus);


  Future<String> makeAppointment(context) async {
    String posturl = "https://codearistos.net/dev/hmz/api/addAppointment";

    final res = await http.post(
        posturl,
        
        body: {
            'patient': this.patient,
            'doctor': this._doctor,
            'date': this._date,
            'status': this.appointmentStatus,
            'time_slot': this.availableSlot,
            'user_type': 'doctor',
            'remarks': this._remarks,
        },
      );
      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        print("khdjfnsdkfnskdfn 1231321223");
        this.success = "success";

         showDialog(
                  context: context,
                  builder: (BuildContext context) {  
                    return  AlertDialog(  
                      title: Text("Success"),  
                      content: Text("This is an success message."),  
                      actions: [  
                        FlatButton(  
                          child: Text("OK"),  
                          onPressed: () {  
                            Navigator.of(context).pushReplacementNamed(ShowAppointmentScreen.routeName);

                          },  
                        )    
                      ],  
                    );
                  });

        return 'success';

      }
      else{
        print("error");
        return "error";
      }


  }


  @override
  Widget build(BuildContext context) {
    bool _firstclick=true;
    
    return ElevatedButton(
      onPressed: () {
        
        if (_formKey.currentState.validate()) {
          
          if(_firstclick){
            _firstclick=false;
            makeAppointment(context);
              

          }
              
        }


      },
      child: Text('Save'),
    );
  }
}


