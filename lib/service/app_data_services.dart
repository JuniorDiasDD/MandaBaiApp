

import 'package:manda_bai/constants/controllers.dart';

class AppDataServices {
  final String _appDataCollection = "version";
  final String _versionControlDoc = "s5TCIiMHOV9Jdn9n9m5L";
  final String _geoDataVersionField = "value";


  Future<String> getGeoDataVersion() async => firebaseFirestore
      .collection(_appDataCollection)
      .doc(_versionControlDoc)
      .get()
      .then((value) => value.data()![_geoDataVersionField]);



}