import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/location.dart';

class NewDestination extends StatefulWidget {
  const NewDestination({Key? key}) : super(key: key);

  @override
  State<NewDestination> createState() => _NewDestinationState();
}

class _NewDestinationState extends State<NewDestination> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final input_nome = TextEditingController();
  final input_cidade = TextEditingController();
  final input_endereco = TextEditingController();
  final input_tel = TextEditingController();

  String dropdownValue = 'Santiago';
  List<String> list_island = [
    'Santo Antão',
    'São Vicente',
    'São Nicolau',
    'Sal',
    'Boavista',
    'Maio',
    'Santiago',
    'Fogo',
    'Brava',
  ];
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Location novo = new Location(
          id: 1,
          name: input_nome.text,
          city: input_cidade.text,
          endereco: input_endereco.text,
          island: dropdownValue,
          phone: input_tel.text);
      bool check = await ServiceRequest.addLocation(novo);
      if (check == true) {
        Navigator.pushReplacementNamed(context, '/Destination');
      }
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
                Text(
                  'Novo Destino',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  width: 10,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.05),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.02,
                        ),
                        child: Text(
                          'Prencher os seguintes campos com o dados do destino pretendido:',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_nome,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText: "Nome do destinatário",
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide:
                                new BorderSide(color: Colors.red, width: 2.0),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Insira o nome' : null,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.06,
                      padding: EdgeInsets.only(
                        left: Get.width * 0.04,
                        right: Get.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Theme.of(context).indicatorColor,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        iconSize: Get.width * 0.05,
                        elevation: 16,
                        style: Theme.of(context).textTheme.headline4,
                        borderRadius: BorderRadius.circular(15.0),
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: list_island
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_cidade,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText: "Cidade",
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Insira a cidade' : null,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_endereco,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText: "Endereço",
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Insira o Endereço' : null,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_tel,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText: "Telefone ou Telemovel",
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Insira o número' : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(" "),
          Padding(
            padding: EdgeInsets.only(
              right: 15,
              bottom: 10,
            ),
            child: Container(
              height: Get.height * 0.05,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardColor,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // changes position of shadow
                  ),
                ],
              ),
              child: TextButton(
                  child: Text(
                    'Guardar',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsRegularFont,
                        fontSize: Get.width * 0.035,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    validateAndSave();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
