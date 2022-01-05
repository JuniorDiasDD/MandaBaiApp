import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Controller/request.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Model/location.dart';
import 'package:manda_bai/UI/cart/pages/checkout_page_step_2.dart';
import 'package:manda_bai/UI/location_destination/components/popup_info.dart';
import 'package:manda_bai/UI/location_destination/page/destination_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewDestination extends StatefulWidget {
  String route;
  Location? location;
  NewDestination({Key? key, required this.route, required this.location})
      : super(key: key);

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
    'Boa Vista',
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
          phone: input_tel.text,
          email: "");
      if (widget.location != null) {
        await ServiceRequest.removeLocation(widget.location!.id);
      }
      bool check = await ServiceRequest.addLocation(novo);
      if (check == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Destination_Page(route: widget.route)));
      }
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.location != null) {
      input_nome.text = widget.location!.name;
      input_cidade.text = widget.location!.city;
      input_endereco.text = widget.location!.endereco;
      input_tel.text = widget.location!.phone;
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Destination_Page(route: widget.route)));
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.title_new_destiny,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PopupInfo();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.info,
                    ),
                    iconSize: Get.width * 0.05,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
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
                          AppLocalizations.of(context)!.text_fill_the_field,
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
                          labelText:
                              AppLocalizations.of(context)!.text_recipient_name,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide:
                                new BorderSide(color: Colors.red, width: 2.0),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.validator_name
                            : null,
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
                          labelText:
                              AppLocalizations.of(context)!.textfield_city,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.validator_city
                            : null,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: input_endereco,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.text_address,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!
                                .validator_enter_address
                            : null,
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
                          labelText:
                              AppLocalizations.of(context)!.textfield_phone,
                          labelStyle: Theme.of(context).textTheme.headline4,
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              "+238",
                              style: Theme.of(context).textTheme.headline4,
                            ), // icon is 48px widget.
                          ),
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        validator: (value) => value!.length == 7
                            ? null
                            : AppLocalizations.of(context)!.validator_number,
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
                    AppLocalizations.of(context)!.button_save,
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
