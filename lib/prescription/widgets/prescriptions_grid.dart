import 'package:flutter/material.dart';
import '../../prescription/widgets/prescription_item.dart';
import 'package:provider/provider.dart';
import '../../prescription/providers/prescriptions.dart';

class PrescriptionsGrid extends StatelessWidget {
  final bool showFavs;
  PrescriptionsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final prescriptionsData = Provider.of<Prescriptions>(context);
    final prescriptions = prescriptionsData.items;
    print("length");
    print(prescriptions.length);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: prescriptions.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: prescriptions[i],
        child: PrescriptionItem(
            // prescriptions[i].id,
            // prescriptions[i].title,
            // prescriptions[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
