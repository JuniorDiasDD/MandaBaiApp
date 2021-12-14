import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupInfo extends StatelessWidget {
  const PopupInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height * 0.6,
          margin: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.08,
                    ),
                    Text(
                      'Instruções',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Informações do Formulário',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Neste formulário, deverá completar com os dados da pessoa receptora da encomenda (produtos).',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '1º "Nome"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        ' Escreva o Nome da Pessoa que irá receber a encomenda;',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '2º "Cidade"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        'Escreva a Cidade onde reside essa Pessoa acima referida;',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '3º "Endereço"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        'Escreva o Endereço onde deverá ser entregue a encomenda;',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '4º "Telemovel/Telefone"',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        'Introduza o Contacto do receptor para podermos lhe contactar.',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text(
                        'Informação Adicional',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Neste campo, poderá adicionar qualquer informação extra que deseja informar a Empresa. Exemplo: a data que deseja a ser entregue.',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
