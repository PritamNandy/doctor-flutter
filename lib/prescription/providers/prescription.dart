import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Prescription with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String price;


  Prescription({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
  });


}
