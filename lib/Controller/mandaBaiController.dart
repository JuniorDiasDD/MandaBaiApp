import 'package:get/get.dart';
import 'package:manda_bai/Model/background.dart';
import 'package:manda_bai/Model/banner.dart';
import 'package:manda_bai/Model/discount.dart';
import 'package:manda_bai/Model/employee.dart';
import 'package:manda_bai/constants/controllers.dart';
import 'package:manda_bai/service/app_data_services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MandaBaiController extends GetxController {
  static MandaBaiController instance = Get.find();
  var discountData = <Discount>[].obs;
  var bannerData = <Banner>[].obs;
  var destaque = ''.obs;
  var imageBackground=''.obs;

  RxList<Employee> listEmployee = <Employee>[].obs;
  RxList<Employee> listEmployeeMandatarios = <Employee>[].obs;


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
  carregarEmployee(context)  {
 listEmployee.clear();
      listEmployee.add(Employee(
        name: 'Carlos Pereira',
        cargo: AppLocalizations.of(context)!.text_role_carlos,
        image:
        'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/img-16-pbkbaaof0qxdaun3rdjj72eggo8xuf1tzefuxajdjk.jpg',
        description: AppLocalizations.of(context)!.text_description_carlos,
        tel: '+31639838997',
        email: 'pereirac2207@gmail.com',
      ));
      listEmployee.add(Employee(
        name: 'Eveline Tavares',
        cargo: AppLocalizations.of(context)!.text_role_eveline,
        image:
        'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/Design-sem-nome-4-pbwjcdm6kbjiw14u4pb8kvevyan7bq0lqfaqzjbqds.jpg',
        description: AppLocalizations.of(context)!.text_description_eveline,
        tel: '+2389724140',
        email: 'eveline.mandabai@gmail.com',
      ));
      listEmployee.add(Employee(
        name: 'Junior Silva',
        cargo: AppLocalizations.of(context)!.text_role_junior,
        image:
        'https://santiago.mandabai.com/wp-content/uploads/2022/10/181D76A8-7427-4783-AED9-DAA9A318651F_1_201_a-scaled.jpg',
        description: AppLocalizations.of(context)!.text_description_junior,

        tel: '+351 939779618',
        email: 'juniormandabai@gmail.com',
      ));
 listEmployeeMandatarios.clear();
 listEmployeeMandatarios.add(Employee(
     name: 'Celly Fontes',
     cargo: AppLocalizations.of(context)!.text_role_antonio,
     image:
     'https://santiago.mandabai.com/wp-content/uploads/2022/01/Design-sem-nome-37.jpg',
     description: AppLocalizations.of(context)!.text_description_antonio,
     tel: '+774 3812002 ',
     email: 'bellisimacosmeticsusa@gmail.com'));
 listEmployeeMandatarios.add(Employee(
     name: 'António Coelho Monteiro',
     cargo: AppLocalizations.of(context)!.text_role_antonio,
     image:
     'https://santiago.mandabai.com/wp-content/uploads/2022/01/Design-sem-nome-35.jpg',
     description: AppLocalizations.of(context)!.text_description_antonio,
     tel: '+1 3057786138',
     email: 'acmonteiro48@gmail.com'));
 listEmployeeMandatarios.add(Employee(
     name: 'Francisco de Pina',
     cargo: AppLocalizations.of(context)!.text_role_estevao,
     image:
     'https://santiago.mandabai.com/wp-content/uploads/2022/01/Design-sem-nome-36.jpg',
     description: AppLocalizations.of(context)!.text_description_estevao,
     tel: '+351913098511\n+351938880906',
     email: 'francisco.r.depina@gmail.com'));
  }

}
