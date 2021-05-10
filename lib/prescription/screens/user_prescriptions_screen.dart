import 'package:flutter/material.dart';
import 'edit_prescription_screen.dart';
import '../widgets/user_prescription_item.dart';
import 'package:provider/provider.dart';
import '../providers/prescriptions.dart';
import '../../home/widgets/app_drawer.dart';

class UserPrescriptionsScreen extends StatelessWidget {
  static const routeName = '/userPrescriptions';

  Future<void> _refreshPrescription(BuildContext context) async {
    await Provider.of<Prescriptions>(context, listen: false)
        .fetchAndSetPrescriptions(false);
  }

  @override
  Widget build(BuildContext context) {
    //  final prescriptionsData = Provider.of<Prescriptions>(context);
    //print('SubhanAllah!');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Prescriptions'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditPrescriptionScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshPrescription(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshPrescription(context),
                    child: Consumer<Prescriptions>(
                      builder: (ctx, prescriptionsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: prescriptionsData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: <Widget>[
                              UserPrescriptionItem(
                                prescriptionsData.items[i].id,
                                prescriptionsData.items[i].title,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
