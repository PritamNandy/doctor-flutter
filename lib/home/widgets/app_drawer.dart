import 'package:flutter/material.dart';
import '../../prescription/screens/user_prescriptions_screen.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth.dart';

import '../../appointment/appointment.dart';
import '../../appointment/showAppointment.dart';



import '../../jitsi/jitsi.dart';




class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Hospital Care'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),

            //  appointment
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Appointment'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppointmentDetailsScreen.routeName);
              },
            ),

            // appointment list
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Appointment List'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ShowAppointmentScreen.routeName);
              },
            ),

           
           

           

            // Jitsi list
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.calendar_today),
            //   title: Text('Jitsi'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed(Jitsi.routeName);
            //   },
            // ),

           


            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.calendar_today),
            //   title: Text('Today\'s Appointment'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.medical_services),
            //   title: Text('Diagnostic Report'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.details),
            //   title: Text('Prescription'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed(UserPrescriptionsScreen.routeName);
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.calendar_today_rounded),
            //   title: Text('Appointment Calendar'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.report),
            //   title: Text('Case'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.image),
            //   title: Text('Documents'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.picture_as_pdf),
            //   title: Text('Other Reports'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.pin_drop),
            //   title: Text('Donor'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.money),
            //   title: Text('Payment'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.picture_as_pdf),
            //   title: Text('Profile'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.shop),
            //   title: Text('Shop'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed('/');
            //   },
            // ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                // Navigator.of(context)
                //     .pushReplacementNamed(UserProductsScreen.routeName);
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
