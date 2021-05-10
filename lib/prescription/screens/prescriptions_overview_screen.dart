import 'package:flutter/material.dart';
import '../../home/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../../prescription/widgets/prescriptions_grid.dart';
import '../../home/widgets/badge.dart';
import '../providers/prescriptions.dart';


enum FilterOptions {
  Favorites,
  All,
}

class PrescriptionsOverviewScreen extends StatefulWidget {
  @override
  _PrescriptionsOverviewScreenState createState() => _PrescriptionsOverviewScreenState();
}

class _PrescriptionsOverviewScreenState extends State<PrescriptionsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //  Provider.of<Prescriptions>(context).fetchAndSetPrescriptions(); // Won't Work
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<Prescriptions>(context).fetchAndSetPrescriptions();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Prescriptions>(context).fetchAndSetPrescriptions().then((_) {
        _isLoading = false;
      });
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),

        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PrescriptionsGrid(_showOnlyFavorites),
    );
  }
}
