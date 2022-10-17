import 'package:manda_bai/Model/user.dart';


const String version="1.0.2";

User user = new User(
    name: " ",
    nickname: " ",
    telefone: " ",
    senha: "",
    email: "",
    avatar: "",
    username: "",
    city: "",
    country: "");

//! Configuração de serviços
//?links- urls
const String url_consulta_Dolar =
    "https://economia.awesomeapi.com.br/all/USD-EUR";
const String url_pricipal = "https://www.mandabai.com/wp-json/";
const String cocart = "cocart/v2/";
const String wc_v3 = "wc/v3/";
const String link = url_pricipal + wc_v3;
const String link_2 = url_pricipal + cocart;

//?key access
const String consumer_key = "ck_99b6b6151e8db4d15190cd8fef823839f2595594";
const String consumer_secret = "cs_2f6fd0fc9ff05307dada1a8104e6f27c39b6cd86";
const String key =
    "consumer_key=" + consumer_key + "&consumer_secret=" + consumer_secret;

//santo Antao
const String consumer_keySantoAntao = "ck_750587a2a9ea64bb63d8d86e3cd2418d316ab1e4";
const String consumer_secretSantoAntao = "cs_5b5b59161d6690d8a94994c3533028bf4d5a4fad";
const String keySantoAntao =
    "consumer_key=" + consumer_keySantoAntao + "&consumer_secret=" + consumer_secretSantoAntao;
//Sao Vicente
const String consumer_keySaoVicente = "ck_749676a21d0e6947ee14a5e000e0f85bf40056d6";
const String consumer_secretSaoVicente = "cs_5aa3e5f3a971bc6055723a69339ffbffa772cb59";
const String keySaoVicente=
    "consumer_key=" + consumer_keySaoVicente + "&consumer_secret=" + consumer_secretSaoVicente;
//Sao Nicolau
const String consumer_keySaoNicolau = "ck_737959933c2914b9775831918987a50bfd4d68f3";
const String consumer_secretSaoNicolau = "cs_c231a60a87be3000d80ad1365a2b9fcd2482a478";
const String keySaoNicolau=
    "consumer_key=" + consumer_keySaoNicolau + "&consumer_secret=" + consumer_secretSaoNicolau;
//Sal
const String consumer_keySal = "ck_9e7dc5af779dfc36aed4c40f3f6e10014488e06b";
const String consumer_secretSal = "cs_b7c42b1a221c769390d65bd8b45b21daffba480a";
const String keySal=
    "consumer_key=" + consumer_keySal + "&consumer_secret=" + consumer_secretSal;
//BoaVista
const String consumer_keyBoaVista = "ck_58aa38110f2467be36515ec328880f551bbfb2d3";
const String consumer_secretBoaVista = "cs_194b0ae37ffb8d1b5b19c617ba62a1965fb33148";
const String keyBoaVista=
    "consumer_key=" + consumer_keyBoaVista + "&consumer_secret=" + consumer_secretBoaVista;
//Maio
const String consumer_keyMaio = "ck_9d060abcc84c8b810274d37d8d4c8292f3c2be75";
const String consumer_secretMaio = "cs_6a14d1e1badc78a1ed926db79fd05dcc183c9f46";
const String keyMaio=
    "consumer_key=" + consumer_keyMaio + "&consumer_secret=" + consumer_secretMaio;
//Santiago
const String consumer_keySantiago = "ck_5b8868070c4aae7f15f7e0e6fd5c39ce12433c29";
const String consumer_secretSantiago = "cs_4108643bd11724cf508638ab5b69aef45f96f4a4";
const String keySantiago=
    "consumer_key=" + consumer_keySantiago + "&consumer_secret=" + consumer_secretSantiago;
//Fogo
const String consumer_keyFogo = "ck_9bd6da9f8f5b956570cbcd49cb23584acd8d3925";
const String consumer_secretFogo= "cs_edc1dc6966245eb24833491f4d0b2718953d01a8";
const String keyFogo=
    "consumer_key=" + consumer_keyFogo + "&consumer_secret=" + consumer_secretFogo;
//Brava
const String consumer_keyBrava = "ck_2f24a67d5e3249fc2b7615b282bb8cce10703112";
const String consumer_secretBrava= "cs_8d3cd39a3a1545f663bef7b3d5cee2255808f425";
const String keyBrava=
    "consumer_key=" + consumer_keyBrava + "&consumer_secret=" + consumer_secretBrava;

//? SubDominios
//!Santiago
const String urlSantiago = "https://santiago.mandabai.com/wp-json/";
const String linkSantiago = urlSantiago + wc_v3;
const String CocartSantiago = urlSantiago + cocart;
//!Santo Antao
const String urlSantoAntao = "https://santoantao.mandabai.com/wp-json/";
const String linkSantoAntao = urlSantoAntao + wc_v3;
const String CocartSantoAntao = urlSantoAntao + cocart;
//!São Vicente
const String urlSaoVicente = "https://saovicente.mandabai.com/wp-json/";
const String linkSaoVicente = urlSaoVicente + wc_v3;
const String CocartSaoVicente = urlSaoVicente + cocart;
//!São Nicolau
const String urlSaoNicolau = "https://saonicolau.mandabai.com/wp-json/";
const String linkSaoNicolau = urlSaoNicolau + wc_v3;
const String CocartSaoNicolau = urlSaoNicolau + cocart;
//!Sal
const String urlSal = "https://sal.mandabai.com/wp-json/";
const String linkSal = urlSal + wc_v3;
const String CocartSal = urlSal + cocart;
//!BoaVista
const String urlBoaVista = "https://boavista.mandabai.com/wp-json/";
const String linkBoaVista = urlBoaVista + wc_v3;
const String CocartBoaVista = urlBoaVista + cocart;
//!Maio
const String urlMaio = "https://maio.mandabai.com/wp-json/";
const String linkMaio = urlMaio + wc_v3;
const String CocartMaio = urlMaio + cocart;
//!Fogo
const String urlFogo = "https://fogo.mandabai.com/wp-json/";
const String linkFogo = urlFogo + wc_v3;
const String CocartFogo = urlFogo + cocart;
//!Brava
const String urlBrava = "https://brava.mandabai.com/wp-json/";
const String linkBrava = urlBrava + wc_v3;
const String CocartBrava = urlBrava + cocart;

//! Categories
const String categorias = link + "products/categories?" + key;
const String categoriasSantiago = linkSantiago + "products/categories?" + keySantiago;
const String categoriasSaoAntao = linkSantoAntao + "products/categories?" + keySantoAntao;
const String categoriasSaoNicolau =
    linkSaoNicolau + "products/categories?" + keySaoNicolau;
const String categoriasSaoVicente =
    linkSaoVicente + "products/categories?" + keySaoVicente;
const String categoriasBoaVista = linkBoaVista + "products/categories?" + keyBoaVista;
const String categoriasSal = linkSal + "products/categories?" + keySal;
const String categoriasMaio = linkMaio + "products/categories?" + keyMaio;
const String categoriasFogo = linkFogo + "products/categories?" + keyFogo;
const String categoriasBrava = linkBrava + "products/categories?" + keyBrava;

//!Products get category
const String productCategorias = link + "products?" + key + "&category=";
const String productCategoriasSantiago =
    linkSantiago + "products?" + keySantiago + "&category=";
const String productCategoriasSaoAntao =
    linkSantoAntao + "products?" + keySantoAntao + "&category=";
const String productCategoriasSaoVicente =
    linkSaoVicente + "products?" + keySaoVicente + "&category=";
const String productCategoriasSaoNicolau =
    linkSaoNicolau + "products?" + keySaoNicolau + "&category=";
const String productCategoriasBoaVista =
    linkBoaVista + "products?" + keyBoaVista + "&category=";
const String productCategoriasSal = linkSal + "products?" + keySal + "&category=";
const String productCategoriasMaio =
    linkMaio + "products?" + keyMaio + "&category=";
const String productCategoriasFogo =
    linkFogo + "products?" + keyFogo + "&category=";
const String productCategoriasBrava =
    linkBrava + "products?" + keyBrava + "&category=";

const String get_Produto = link + "products/";
const String get_ProdutoSantiago = linkSantiago + "products/";
const String get_ProdutoSaoAntao = linkSantoAntao + "products/";
const String get_ProdutoSaoVicente = linkSaoVicente + "products/";
const String get_ProdutoSaoNicolau = linkSaoNicolau + "products/";
const String get_ProdutoBoaVista = linkBoaVista + "products/";
const String get_ProdutoSal = linkSal + "products/";
const String get_ProdutoMaio = linkMaio + "products/";
const String get_ProdutoFogo = linkFogo + "products/";
const String get_ProdutoBrava = linkBrava + "products/";

//! Cart
const String getCart = link_2 + "cart";
const String getCartSantiago = CocartSantiago + "cart";
const String getCartSaoAntao = CocartSantoAntao + "cart";
const String getCartSaoVicente = CocartSaoVicente + "cart";
const String getCartSaoNicolau = CocartSaoNicolau + "cart";
const String getCartBoaVista = CocartBoaVista + "cart";
const String getCartSal = CocartSal + "cart";
const String getCartMaio = CocartMaio + "cart";
const String getCartFogo = CocartFogo + "cart";
const String getCartBrava = CocartBrava + "cart";
//! remove de cart
const String removeItemCart = link_2 + "cart/item/";
const String removeItemCartSantiago = CocartSantiago + "cart/item/";
const String removeItemCartSantoAntao = CocartSantoAntao + "cart/item/";
const String removeItemCartSaoNicolau = CocartSaoNicolau + "cart/item/";
const String removeItemCartSaoVicente = CocartSaoVicente + "cart/item/";
const String removeItemCartBoaVista = CocartBoaVista + "cart/item/";
const String removeItemCartSal = CocartSal + "cart/item/";
const String removeItemCartMaio = CocartMaio + "cart/item/";
const String removeItemCartFogo = CocartFogo + "cart/item/";
const String removeItemCartBrava = CocartBrava + "cart/item/";

//!addcart
const String addItemCart = link_2 + "cart/add-item";
const String addItemCartSantiago = CocartSantiago + "cart/add-item";
const String addItemCartSantoAntao = CocartSantoAntao + "cart/add-item";
const String addItemCartSaoVicente = CocartSaoVicente + "cart/add-item";
const String addItemCartSaoNicolau = CocartSaoNicolau + "cart/add-item";
const String addItemCartBoaVista = CocartBoaVista + "cart/add-item";
const String addItemCartSal = CocartSal + "cart/add-item";
const String addItemCartMaio = CocartMaio + "cart/add-item";
const String addItemCartFogo = CocartFogo + "cart/add-item";
const String addItemCartBrava = CocartBrava + "cart/add-item";

//! register
const String register_client = link + "customers?" + key;
const String register_client_SantoAntao = linkSantoAntao + "customers?" + keySantoAntao;
const String register_client_SaoVicente = linkSaoVicente + "customers?" + keySaoVicente;
const String register_client_SaoNicolau = linkSaoNicolau + "customers?" + keySaoNicolau;
const String register_client_Sal = linkSal + "customers?" + keySal;
const String register_client_BoaVista = linkBoaVista + "customers?" + keyBoaVista;
const String register_client_Maio = linkMaio + "customers?" + keyMaio;
const String register_client_Santiago = linkSantiago + "customers?" + keySantiago;
const String register_client_Fogo = linkFogo + "customers?" + keyFogo;
const String register_client_Brava = linkBrava + "customers?" + keyBrava;

//! login Cocart
const String request_login_SantoAntao = urlSantoAntao + "custom-plugin/login";
const String request_login_SaoVicente = urlSaoVicente + "custom-plugin/login";
const String request_login_SaoNicolau = urlSaoNicolau + "custom-plugin/login";
const String request_login_Sal = urlSal + "custom-plugin/login";
const String request_login_BoaVista = urlBoaVista + "custom-plugin/login";
const String request_login_Maio = urlMaio + "custom-plugin/login";
const String request_login_Santiago = urlSantiago + "custom-plugin/login";
const String request_login_Fogo = urlFogo + "custom-plugin/login";
const String request_login_Brava = urlBrava + "custom-plugin/login";
const String request_login = url_pricipal + "custom-plugin/login";

const String request_login_cocart_ = "";
const String request_loginCocart_SantoAntao = CocartSantoAntao + "login";
const String request_loginCocart_SaoVicente = CocartSaoVicente + "login";
const String request_loginCocart_SaoNicolau = CocartSaoNicolau + "login";
const String request_loginCocart_Sal = CocartSal + "login";
const String request_loginCocart_BoaVista = CocartBoaVista + "login";
const String request_loginCocart_Maio = CocartMaio + "login";
const String request_loginCocart_Santiago = CocartSantiago + "login";
const String request_loginCocart_Fogo = CocartFogo + "login";
const String request_loginCocart_Brava = CocartBrava + "login";
//! update user
const String updateUser = link + "customers/";

//! Get User
const String getUser = link + "customers/";
const String getUserSantoAntao = linkSantoAntao + "customers/";
const String getUserSaoVicente = linkSaoVicente + "customers/";
const String getUserSaoNicolau = linkSaoNicolau + "customers/";
const String getUserSal = linkSal + "customers/";
const String getUserBoaVista = linkBoaVista + "customers/";
const String getUserMaio = linkMaio + "customers/";
const String getUserSantiago = linkSantiago + "customers/";
const String getUserFogo = linkFogo + "customers/";
const String getUserBrava = linkBrava + "customers/";
//!orders
const String getOrder = link + "orders?" + key;
const String getOrderSantoAntao = linkSantoAntao + "orders?" + keySantoAntao;
const String getOrderSaoVicente = linkSaoVicente + "orders?" + keySaoVicente;
const String getOrderSaoNicolau = linkSaoNicolau + "orders?" + keySaoNicolau;
const String getOrderSal = linkSal + "orders?" + keySal;
const String getOrderBoaVista = linkBoaVista + "orders?" + keyBoaVista;
const String getOrderMaio = linkMaio + "orders?" + keyMaio;
const String getOrderSantiago = linkSantiago + "orders?" + keySantiago;
const String getOrderFogo = linkFogo + "orders?" + keyFogo;
const String getOrderBrava = linkBrava + "orders?" + keyBrava;

const String getOrderId = link + "orders/";
const String getOrderIdSantoAntao = linkSantoAntao + "orders/";
const String getOrderIdSaoVicente = linkSaoVicente + "orders/";
const String getOrderIdSaoNicolau = linkSaoNicolau + "orders/";
const String getOrderIdSal = linkSal + "orders/";
const String getOrderIdBoaVista = linkBoaVista + "orders/";
const String getOrderIdMaio = linkMaio + "orders/";
const String getOrderIdSantiago = linkSantiago + "orders/";
const String getOrderIdFogo = linkFogo + "orders/";
const String getOrderIdBrava = linkBrava + "orders/";

//reset password
const String resetPasswordSantiado = urlSantiago + "bdpwr/v1/reset-password";
//validate code
const String validateCodeSantiado = urlSantiago + "bdpwr/v1/validate-code";
//set Password
const String setPasswordSantiado = urlSantiago + "bdpwr/v1/set-password";

int loadProdutoPage = 1;
int loadProdutoTotal = 0;
String statusLoadProdutoPage = "init";
