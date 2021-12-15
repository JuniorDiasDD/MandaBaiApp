import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_fonts.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/Model/employee.dart';
import 'package:manda_bai/UI/about/components/item_bio.dart';
import 'package:manda_bai/UI/about/components/item_mandatario.dart';
import 'package:manda_bai/data/madaBaiData.dart';
import 'package:readmore/readmore.dart';

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
          'Graduando em Economia e Ciências Empresariais.Acredita que a Mandabai é bem mais que uma empresa, mas sim uma forma de unir os emigrantes cabo-verdianos a Cabo Verde.',
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
            'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/img-16-pbkbaaof0qxdaun3rdjj72eggo8xuf1tzefuxajdjk.jpg',
        description: 'Mandatário de Mandabai nos Estados unidos da América',
        tel: '+1 3057786138',
        email: 'acmonteiro48@gmail.com'));
    list_employee_Mandatarios.add(Employee(
        name: 'Estêvão do Nascimento Gomes',
        cargo: 'Portugal',
        image:
            'https://www.mandabai.com/wp-content/uploads/elementor/thumbs/img-16-pbkbaaof0qxdaun3rdjj72eggo8xuf1tzefuxajdjk.jpg',
        description: 'Mandatário de Mandabai em Portugal',
        tel: '+447442506316',
        email: ''));
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
                    'Sobre Nós',
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
                        'MandaBai, somos mais que uma Empresa!',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ReadMoreText(
                      description_mandabai,
                      trimLines: 2,
                      colorClickableText: AppColors.greenColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Ver mais',
                      trimExpandedText: 'Fechar',
                      style: Theme.of(context).textTheme.headline4,
                      moreStyle: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Constituição da Empresa',
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
                        'Mandatários de MandaBai',
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
                          "Missão",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              description_missao,
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
                          "Visão",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              description_visao,
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
                          "Valores",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(description_valores,
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
                            "Sobre Aplicação",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  'Publicado por',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
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
                                  'Desenvolvido por',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text(
                                  'Termos de Uso',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  ' >',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Text('Politica de Privacidade',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Text(
                                  'MandaBai  >',
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
