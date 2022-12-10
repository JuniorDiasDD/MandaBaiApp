import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manda_bai/data/madaBaiData.dart';

class Banner {
  Banner(String? image) {
    _image = image;
  }

  String? _image;


  String? get image => _image;

  Banner.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _image = snapshot.data()![BANNER_VALUE];
  }
}