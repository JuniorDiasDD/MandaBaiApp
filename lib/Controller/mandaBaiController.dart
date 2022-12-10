import 'package:get/get.dart';
import 'package:manda_bai/Model/background.dart';
import 'package:manda_bai/Model/banner.dart';
import 'package:manda_bai/Model/discount.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/service/app_data_services.dart';

class MandaBaiController extends GetxController {
  static MandaBaiController instance = Get.find();
  var discountData = <Discount>[].obs;
  var bannerData = <Banner>[].obs;
  var destaque = ''.obs;
  var imageBackground=''.obs;
  final AppDataServices _appServices = AppDataServices();

  Future loadDiscountData() async {
    discountData.clear();
    List<Discount> list = await _appServices.getAllDiscount();
    if (discountData.isEmpty) {
      for (var element in list) {
        if (!discountData.contains(element)) {
          discountData.add(element);
        }
      }
      //discountData.addAll(await _appServices.getAllDiscount());
    }

    return discountData;
  }

  loadDestaque() async {
    destaque.value = await _appServices.getDestaque();
  }

  loadBanner() async {
    bannerData.value = await _appServices.getBanner();
  }

  loadBackground() async {
    List<Background> list = [];
    list = await _appServices.getBackground();

    list.forEach((element) {
      if(element.island==fullControllerController.island.value){
        imageBackground.value=element.image!;
      }
    });

  }
}
