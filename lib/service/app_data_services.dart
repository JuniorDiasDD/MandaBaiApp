import 'package:manda_bai/Model/background.dart';
import 'package:manda_bai/Model/banner.dart';
import 'package:manda_bai/Model/discount.dart';
import 'package:manda_bai/constants/controllers.dart';

class AppDataServices {
  final String _appDataCollectionVersion = "version";
  final String _versionControlDoc = "s5TCIiMHOV9Jdn9n9m5L";
  final String _geoDataVersionField = "value";

  final String _appDataCollectionDesconto = "desconto";
  final String _appDataCollectionDestaque = "destaque";
  final String _controlDestaque = "value";
  final String _appDataCollectionBanner = "banner";
  final String _appDataCollectionBackground = "background";

  Future<String> getGeoDataVersion() async => firebaseFirestore
      .collection(_appDataCollectionVersion)
      .doc(_versionControlDoc)
      .get()
      .then((value) => value.data()![_geoDataVersionField]);

  Future<List<Discount>> getAllDiscount() async => firebaseFirestore
          .collection(_appDataCollectionDesconto)
          .get()
          .then((result) {
        List<Discount> discounts = [];
        for (var discount in result.docs) {
          discounts.add(Discount.fromSnapshot(discount));
        }
        return discounts;
      });

  Future<String> getDestaque() async => firebaseFirestore
      .collection(_appDataCollectionDestaque)
      .doc(_controlDestaque)
      .get()
      .then((value) => value.data()![_controlDestaque]);

  Future<List<Banner>> getBanner() async => firebaseFirestore
          .collection(_appDataCollectionBanner)
          .get()
          .then((result) {
        List<Banner> banners = [];
        for (var banner in result.docs) {
          banners.add(Banner.fromSnapshot(banner));
        }
        return banners;
      });

  Future<List<Background>> getBackground() async => firebaseFirestore
          .collection(_appDataCollectionBackground)
          .get()
          .then((result) {
        List<Background> list = [];
        for (var element in result.docs) {
          list.add(Background.fromSnapshot(element));
        }
        return list;
      });
}
