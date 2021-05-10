import 'package:flutter/material.dart';
import '../providers/prescription.dart';
import '../screens/prescription_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth.dart';

class PrescriptionItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // PrescriptionItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final prescription = Provider.of<Prescription>(context, listen: false);
    //   final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PrescriptionDetailScreen.routeName,
              arguments: prescription.id,
            );
          },
          child: Container(),
        ),
        footer: GridTileBar(
          leading: Consumer<Prescription>(
            builder: (ctx, prescription, child) => IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
          ),
          backgroundColor: Colors.black38,
          title: Text(
            prescription.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              // cart.addItem(
              //   prescription.id,
              //   prescription.price,
              //   prescription.title,
              // );
              // ScaffoldMessenger.of(context).hideCurrentSnackBar();
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       'Added Item To Cart',
              //     ),
              //     duration: Duration(seconds: 2),
              //     action: SnackBarAction(
              //       label: 'UNDO',
              //       onPressed: () {
              //         cart.removeSingleItem(prescription.id);
              //       },
              //     ),
              //   ),
              // );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
