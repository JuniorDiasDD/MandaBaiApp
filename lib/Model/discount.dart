import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manda_bai/data/madaBaiData.dart';

class Discount {
  Discount(String? title, String? description, String? code) {
    _title = title;
    _description = description;
    _code = code;
  }
  String? _title;
  String? _description;
  String? _code;

  String? get title => _title;
  String? get description => _description;
  String? get code => _code;

  Discount.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _title = snapshot.data()![DESCONTO_TITLE];
    _description = snapshot.data()![DESCONTO_DESCRIPTION];
    _code = snapshot.data()![DESCONTO_CODE];
  }
}
