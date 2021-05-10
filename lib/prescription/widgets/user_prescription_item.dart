import 'package:flutter/material.dart';
import '../screens/edit_prescription_screen.dart';
import 'package:provider/provider.dart';
import '../providers/prescriptions.dart';

class UserPrescriptionItem extends StatelessWidget {
  final String id;
  final String title;

  UserPrescriptionItem(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://tinyurl.com/yu5ryaju'),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditPrescriptionScreen.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  //print("aschi");
                  //print(id);
                  await Provider.of<Prescriptions>(context, listen: false)
                      .deletePrescription(id);
                } catch (error) {
                  print(error);
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting Failed',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
