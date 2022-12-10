import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Model/order.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  final _island = ''.obs;
  final dataOrder=''.obs;
  final horaOrder=''.obs;

  set island(String island) {
    _island.value = island;
  }

  String get island {
    return _island.value;
  }

  var dropdownValue = 'Santiago'.obs;
  List<String> listIsland = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boa Vista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava',
  ];

  var listOrder = <Order>[].obs;
  Future carregar() async {
    if (island.isEmpty || dropdownValue.value != island) {
      listOrder.value = await ServiceRequest.loadOrder(dropdownValue.value);
      if (listOrder.isEmpty) {
        return null;
      }
      island = dropdownValue.value;
    }
    return listOrder;
  }

  data(String date) {
    var data = DateTime.parse(date);
    horaOrder.value=data.hour.toString()+":"+data.minute.toString();
    dataOrder.value=data.day.toString()+"/"+data.month.toString()+"/"+data.year.toString();

  }
  getData(String date) {
    var data = DateTime.parse(date);

   return data.day.toString()+"/"+data.month.toString()+"/"+data.year.toString();

  }
}
