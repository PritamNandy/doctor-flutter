import 'package:flutter/material.dart';
import 'package:hmz/prescription/screens/user_prescriptions_screen.dart';
import 'prescription/screens/prescriptions_overview_screen.dart';
import 'auth/providers/auth.dart';
import 'auth/screens/auth_screen.dart';
import 'prescription/screens/edit_prescription_screen.dart';
import 'prescription/screens/prescription_detail_screen.dart';
import 'package:provider/provider.dart';
import 'prescription/providers/prescriptions.dart';
import 'prescription/screens/user_prescriptions_screen.dart';
import 'home/screens/splash-screen.dart';

import 'appointment/appointment.dart';
import 'appointment/showAppointment.dart';

import 'jitsi/jitsi.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // 
  
  @override
  Widget build(BuildContext context) {
    print(Auth().userId);


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Prescriptions>(
          update: (ctx, auth, previousPrescriptions) => Prescriptions(
            auth.token,
            auth.userId,
            previousPrescriptions == null ? [] : previousPrescriptions.items,
          ),
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => Cart(),
        // ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Hospital Manager',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? UserPrescriptionsScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            PrescriptionDetailScreen.routeName: (ctx) =>
                PrescriptionDetailScreen(),
            AppointmentDetailsScreen.routeName: (ctx) => AppointmentDetailsScreen(auth.particularId,auth.userId),
            // Aptemp.routeName: (ctx) => Aptemp(),
            ShowAppointmentScreen.routeName: (ctx) => ShowAppointmentScreen(auth.particularId),
            Jitsi.routeName: (ctx) => Jitsi(),



            PrescriptionDetailScreen.routeName: (ctx) => PrescriptionDetailScreen(),
            //  CartScreen.routeName: (ctx) => CartScreen(),
            UserPrescriptionsScreen.routeName: (ctx) =>
                UserPrescriptionsScreen(),
            EditPrescriptionScreen.routeName: (ctx) => EditPrescriptionScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
