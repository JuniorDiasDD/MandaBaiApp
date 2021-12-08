import 'package:manda_bai/Model/user.dart';



String ver_dados_pessoais = "Dados Pessoais \n Nome: ";/* +
    user.name +
    "\n Email: " +
    user.email +
    "\n Telefone: " +
    user.telefone +
    "\n Morada: \n";*/

//! Configuração de serviços
//?links- urls
const String url_pricipal="https://www.mandabai.com/wp-json/";
const String link =url_pricipal+ "wc/v3/";
const String link_2 = url_pricipal+"cocart/v2/";
//?key access
const String consumer_key = "ck_99b6b6151e8db4d15190cd8fef823839f2595594";
const String consumer_secret = "cs_2f6fd0fc9ff05307dada1a8104e6f27c39b6cd86";
const String key =
    "consumer_key=" + consumer_key + "&consumer_secret=" + consumer_secret;

//! Categories
const String categorias = link + "products/categories?" + key;

//!Products get category
const String productCategorias = link + "products?" + key + "&category=";
const String get_Produto = link+"products/";

//! register
const String register_client = link + "customers?" + key;
//! login
const String request_login = url_pricipal + "custom-plugin/login";

//! Get User
const String getUser = link + "customers/";

//! Cart
const String getCart = link_2 + "cart";
//! remove de cart
const String removeItemCart=link_2+"cart/item/";

//!addcart
const String addItemCart=link_2+"cart/add-item";