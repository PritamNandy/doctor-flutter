import 'dart:convert';
import 'package:flutter/material.dart';
import '../../home/models/http_exception.dart';
import '../providers/prescription.dart';
import 'package:http/http.dart' as http;

class Prescriptions with ChangeNotifier {
  List<Prescription> _items = [
    // Prescription(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Prescription(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Prescription(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Prescription(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;

  final String authToken;
  final String userId;

  Prescriptions(this.authToken, this.userId, this._items);

  List<Prescription> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // } else {
    return [..._items];
    // }
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Prescription findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetPrescriptions([bool filterByUser = false]) async {
    var url = 'https://codearistos.net/dev/hmz/api/myPrescription';

    try {
      var response = await http.get(url);
      //print(json.decode(response.body));
      // for (var i = 0; i < 2; i++) {
      //   print("i" + response.body[i]);
      // }
      // print("hello");
      //print('Allah Akbar');
      // final response = [
      //   {
      //     "1": {
      //       "id": "101",
      //       "date": "1614056400",
      //       "patient": "62",
      //       "doctor": "162",
      //       "symptom": "",
      //       "advice": null,
      //       "state": null,
      //       "dd": null,
      //       "medicine": "",
      //       "validity": null,
      //       "note": "",
      //       "patientname": "Mr Patient",
      //       "doctorname": "Mr Doctor",
      //       "hospital_id": "466"
      //     }
      //   },
      //   {
      //     "2": {
      //       "id": "102",
      //       "date": "1615438800",
      //       "patient": "62",
      //       "doctor": "162",
      //       "symptom": "gkjvjkdfjkv<\/p>\r\n",
      //       "advice": "dfgdfklng<\/p>\r\n",
      //       "state": null,
      //       "dd": null,
      //       "medicine": "",
      //       "validity": null,
      //       "note": "kkjdfvkfkvjkx<\/p>\r\n",
      //       "patientname": "Mr Patient",
      //       "doctorname": "Mr Doctor",
      //       "hospital_id": "466"
      //     }
      //   }
      // ];
      print("hello");
      //final extractedData = response as Map<String, dynamic>;
      List<dynamic> extractedData = jsonDecode(response.body);

      //print(extractedData);

      if (extractedData == null) {
        print('CHeck');
      } else {
        print('CHeck 2');
      }

      // final List<Prescription> loadedPrescriptions = [
      //   Prescription(
      //     id: 'jgjg',
      //     title: 'jjjgj',
      //     description: 'jhgjjg',
      //     price: 'jgggjg',
      //   )
      // ];

      final List<Prescription> loadedPrescriptions = [];
      extractedData.forEach((prodData) {
        loadedPrescriptions.add(Prescription(
          id: prodData['id'],
          title: prodData['patientname'],
          price: prodData['doctorname'],
          description: prodData['note'],
        ));
      });
      _items = loadedPrescriptions;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addPrescription(Prescription prescription) async {
    final url = 'https://codearistos.net/dev/hmz/api/addNewPrescription';
    try {
      print(prescription.title);
      final response = await http.post(
        url,
        body: <String, String>{
          // 'title': prescription.title,
          // 'description': prescription.description,
          // 'price': prescription.price,
          // 'creatorId': userId,

          'patient': prescription.title,
          'note': prescription.description,
          'doctor': prescription.price,
          'creatorId': userId,
        },
      );
      print(json.decode(response.body));
      final newPrescription = Prescription(
        title: prescription.title,
        description: prescription.description,
        price: prescription.price,
        id: "123",
      );
      _items.add(newPrescription);
      // _items.insert(0, newPrescription); // at te start of te list
      //  _items.add(value);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updatePrescription(String id, Prescription newPrescription) {
    print(id);
    print(newPrescription.title);
    print(newPrescription.price);
    print(newPrescription.description);
    return http.put(
      'https://codearistos.net/dev/hmz/api/editNewPrescription?id=$id',
      body: <String, String>{
        'patient': newPrescription.title,
        'note': newPrescription.description,
        'doctor': newPrescription.price,
        'symptom': "",
        'medicine': "",
        'advice': ""
      },
    );

    //print('updated');
    //print(json.decode(response.body));
    // final prodIndex = _items.indexWhere((prod) => prod.id == id);
    // if (prodIndex >= 0) {
    //   // final url = 'https://codearistos.net/dev/hmz/api/editNewPrescription';
    //   // final response = await http.post(url, body: <String, String>{
    //   //   // 'title': newPrescription.title,
    //   //   // 'description': newPrescription.description,
    //   //   // 'price': newPrescription.price,
    //   //   'patient': newPrescription.title,
    //   //   'note': newPrescription.description,
    //   //   'doctor': newPrescription.price,
    //   //   'id': id
    //   // });
    //   // print(json.decode(response.body));
    //   _items[prodIndex] = newPrescription;
    //   notifyListeners();
    // } //else {}
  }

  Future<void> deletePrescription(String id) async {
    // final url = 'https://codearistos.net/dev/hmz/api/deletePrescription?id=$id';
    // final existingPrescriptionIndex =
    //     _items.indexWhere((prod) => prod.id == id);
    // print("hello");
    // print(existingPrescriptionIndex);
    // var existingPrescription = _items[existingPrescriptionIndex];
    // _items.removeAt(existingPrescriptionIndex);
    // _items.removeAt(existingPrescriptionIndex);
    // notifyListeners();
    // final response = await http.get(url);
    // if (response.statusCode >= 400) {
    //   _items.insert(existingPrescriptionIndex, existingPrescription);
    //   notifyListeners();
    //   throw HttpException('Could not delete prescription.');
    // }
    // existingPrescription = null;
    final http.Response response = await http.delete(
      'https://codearistos.net/dev/hmz/api/deletePrescription?id=$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(json.decode(response.body));
    print('Checked');
  }
}
