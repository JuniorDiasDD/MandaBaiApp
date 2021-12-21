import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/employee.dart';
import 'package:manda_bai/UI/about/components/item_bio.dart';
import 'package:manda_bai/UI/about/components/item_mandatario.dart';
import 'package:manda_bai/UI/about/pages/about_app.dart';
import 'package:manda_bai/data/madaBaiData.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<Employee> list_employee = [];
  List<Employee> list_employee_Mandatarios = [];
  Future _carregar() async {
    list_employee.add(Employee(
      name: 'Carlos Pereira',
      cargo: 'Fundador da empresa',
      image:
          'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/img-16-pbkbaaof0qxdaun3rdjj72eggo8xuf1tzefuxajdjk.jpg',
      description:
          'Mentor por trás do empreendimento Mandabai. Acreditou que era possível o envio de produtos para familiares e amigos, através de processos online, provando ser um método eficaz e fazendo a diferença na vida de muitos cabo-verdianos.',
      tel: '+31639838997',
      email: 'pereirac2207@gmail.com',
    ));
    list_employee.add(Employee(
      name: 'Eveline Tavares',
      cargo: 'CEO',
      image:
          'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/Design-sem-nome-4-pbwjcdm6kbjiw14u4pb8kvevyan7bq0lqfaqzjbqds.jpg',
      description:
          'Licenciada em Economia e Ciências Empresariais. Acredita que a Mandabai é bem mais que uma empresa, mas sim uma forma de unir os emigrantes cabo-verdianos a Cabo Verde.',
      tel: '+2389724140',
      email: 'eveline.mandabai@gmail.com',
    ));

    if (list_employee.isEmpty) {
      return null;
    }

    return list_employee;
  }

  Future _carregarMandatarios() async {
    list_employee_Mandatarios.add(Employee(
        name: 'António Coelho Monteiro',
        cargo: 'Estados unidos da América',
        image:
            'https://www.mandabai.com/wp-content/uploads/2021/12/Antonio_SemFundo-2.png',
        description: 'Mandatário de Mandabai nos Estados unidos da América',
        tel: '+1 3057786138',
        email: 'acmonteiro48@gmail.com'));
    list_employee_Mandatarios.add(Employee(
        name: 'Francisco de Pina',
        cargo: 'Portugal',
        image:
            'https://www.mandabai.com/wp-content/uploads/2021/12/PicsArt_12-20-08.16.39-scaled.jpg',
        description: 'Mandatário de Mandabai em Portugal',
        tel: '+351 913098511 | +351938880906',
        email: 'francisco.r.depina@gmail.com'));
    list_employee_Mandatarios.add(Employee(
        name: 'Celly Fontes',
        cargo: 'Estados unidos da América',
        image:
        'https://www.mandabai.com/wp-content/uploads/2021/12/1_orig-1000x1000.jpg',
        description: 'Mandatário de Mandabai nos Estados unidos da América',
        tel: '+774 3812002 ',
        email: 'bellisimacosmeticsusa@gmail.com'));

    if (list_employee_Mandatarios.isEmpty) {
      return null;
    }

    return list_employee_Mandatarios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: IconButton(
                      // padding: EdgeInsets.all(0.0),
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
                    AppLocalizations.of(context)!.title_about_us,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Container(
                    width: Get.width * 0.08,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.01, right: Get.width * 0.01),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.text_mandabai,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ReadMoreText(
                      AppLocalizations.of(context)!.text_description_mandabai,
                      trimLines: 2,
                      colorClickableText: AppColors.greenColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText:
                          AppLocalizations.of(context)!.readmoretext_see_more,
                      trimExpandedText:
                          AppLocalizations.of(context)!.readmoretext_close,
                      style: Theme.of(context).textTheme.headline4,
                      moreStyle: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.subtitle_company_members,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: _carregar(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              height: Get.height * 0.2,
                              width: Get.width,
                              child: Center(
                                child: Image.asset(
                                  AppImages.loading,
                                  width: Get.width * 0.2,
                                  height: Get.height * 0.2,
                                  alignment: Alignment.center,
                                ),
                              ),
                            );
                          default:
                            if (snapshot.data == null) {
                              return Container();
                            } else {
                              return Container(
                                height: Get.height * 0.35,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0.0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: list_employee.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var list = list_employee[index];
                                    return Item_Bio(employee: list);
                                  },
                                ),
                              );
                            }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!
                            .subtitle_representative_members,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: _carregarMandatarios(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              height: Get.height * 0.2,
                              width: Get.width,
                              child: Center(
                                child: Image.asset(
                                  AppImages.loading,
                                  width: Get.width * 0.2,
                                  height: Get.height * 0.2,
                                  alignment: Alignment.center,
                                ),
                              ),
                            );
                          default:
                            if (snapshot.data == null) {
                              return Container();
                            } else {
                              return Container(
                                height: Get.height * 0.35,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0.0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: list_employee_Mandatarios.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var list = list_employee_Mandatarios[index];
                                    return ItemMandatario(employee: list);
                                  },
                                ),
                              );
                            }
                        }
                      },
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Container(
                      margin: EdgeInsets.only(
                        left: Get.width * 0.01,
                        right: Get.width * 0.01,
                        top: Get.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                            color: Colors.black12, width: Get.width * 0.001),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Theme.of(context).cardColor,
                        iconColor: AppColors.greenColor,
                        title: Text(
                          AppLocalizations.of(context)!.subtitle_mission,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .text_description_mission,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: Get.width * 0.01,
                        right: Get.width * 0.01,
                        top: Get.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                            color: Colors.black12, width: Get.width * 0.001),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Theme.of(context).cardColor,
                        iconColor: AppColors.greenColor,
                        title: Text(
                          AppLocalizations.of(context)!.subtitle_vision,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .text_description_vision,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: Get.width * 0.01,
                        right: Get.width * 0.01,
                        top: Get.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                            color: Colors.black12, width: Get.width * 0.001),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Theme.of(context).cardColor,
                        iconColor: AppColors.greenColor,
                        title: Text(
                          AppLocalizations.of(context)!.subtitle_values,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .text_description_values,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.headline4),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: new Container(
                            width: Get.width * 0.1,
                            child: Divider(
                              color: Theme.of(context).cardColor,
                              height: 36,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                .text_about_application,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width * 0.4,
                            child: Divider(
                              color: Theme.of(context).cardColor,
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.01, right: Get.width * 0.01),
                      child: Container(
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.security,
                                color:  Theme.of(context).indicatorColor,
                                size: Get.height * 0.025,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textbutton_security,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.01, right: Get.width * 0.01),
                      child: Container(
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            children: [
                              Icon(
                                Icons.description,
                                color:  Theme.of(context).indicatorColor,
                                size: Get.height * 0.025,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textbutton_termos_of_use_and_privacy_police,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Termos_de_Uso_Privacy_Policy(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.01, right: Get.width * 0.01),
                      child: Container(
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textbutton_published_by ,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai ',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
