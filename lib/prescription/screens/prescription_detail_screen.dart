import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prescriptions.dart';

class PrescriptionDetailScreen extends StatelessWidget {
  static const routeName = '/prescription-detail';

  @override
  Widget build(BuildContext context) {
    final prescriptionId = ModalRoute.of(context).settings.arguments as String;
    final loadedPrescription = Provider.of<Prescriptions>(
      context,
      listen: false,
    ).findById(prescriptionId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedPrescription.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,

            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedPrescription.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedPrescription.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
