
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manda_bai/data/madaBaiData.dart';

class Background {
  Background(String? image,String? island) {
    _image = image;
    _island=island;
  }

  String? _image;
  String? _island;


  String? get image => _image;
  String? get island => _island;

  Background.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _image = snapshot.data()![IMAGE];
    _island = snapshot.data()![ISLAND];
  }
}