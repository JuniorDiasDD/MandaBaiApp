import 'package:manda_bai/Model/user.dart';

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
const String cocart="cocart/v2/";
const String wc_v3="wc/v3/";
const String link = url_pricipal + wc_v3;
const String link_2 = url_pricipal +cocart ;
//?key access
const String consumer_key = "ck_99b6b6151e8db4d15190cd8fef823839f2595594";
const String consumer_secret = "cs_2f6fd0fc9ff05307dada1a8104e6f27c39b6cd86";
const String key =
    "consumer_key=" + consumer_key + "&consumer_secret=" + consumer_secret;


//? SubDominios
//!Santiago
const String urlSantiago="https://santiago.mandabai.com/wp-json/";
const String linkSantiago=urlSantiago+wc_v3;
const String CocartSantiago=urlSantiago+cocart;
//!Santo Antao
const String urlSantoAntao="https://santoantao.mandabai.com/wp-json/";
const String linkSantoAntao=urlSantoAntao+wc_v3;
const String CocartSantoAntao=urlSantoAntao+cocart;
//!São Vicente
const String urlSaoVicente="https://saovicente.mandabai.com/wp-json/";
const String linkSaoVicente=urlSaoVicente+wc_v3;
const String CocartSaoVicente=urlSaoVicente+cocart;
//!São Nicolau
const String urlSaoNicolau="https://saonicolau.mandabai.com/wp-json/";
const String linkSaoNicolau=urlSaoNicolau+wc_v3;
const String CocartSaoNicolau=urlSaoNicolau+cocart;
//!Sal
const String urlSal="https://sal.mandabai.com/wp-json/";
const String linkSal=urlSal+wc_v3;
const String CocartSal=urlSal+cocart;
//!BoaVista
const String urlBoaVista="https://boavista.mandabai.com/wp-json/";
const String linkBoaVista=urlBoaVista+wc_v3;
const String CocartBoaVista=urlBoaVista+cocart;
//!Maio
const String urlMaio="https://maio.mandabai.com/wp-json/";
const String linkMaio=urlMaio+wc_v3;
const String CocartMaio=urlMaio+cocart;
//!Fogo
const String urlFogo="https://fogo.mandabai.com/wp-json/";
const String linkFogo=urlFogo+wc_v3;
const String CocartFogo=urlFogo+cocart;
//!Brava
const String urlBrava="https://brava.mandabai.com/wp-json/";
const String linkBrava=urlBrava+wc_v3;
const String CocartBrava=urlBrava+cocart;

//! Categories
const String categorias = link + "products/categories?" + key;
const String categoriasSantiago = linkSantiago + "products/categories?" + key;
const String categoriasSaoAntao = linkSantoAntao + "products/categories?" + key;
const String categoriasSaoNicolau = linkSaoNicolau + "products/categories?" + key;
const String categoriasSaoVicente = linkSaoVicente + "products/categories?" + key;
const String categoriasBoaVista = linkBoaVista + "products/categories?" + key;
const String categoriasSal = linkSal + "products/categories?" + key;
const String categoriasMaio = linkMaio + "products/categories?" + key;
const String categoriasFogo = linkFogo + "products/categories?" + key;
const String categoriasBrava = linkBrava + "products/categories?" + key;



//!Products get category
const String productCategorias = link + "products?" + key + "&category=";
const String productCategoriasSantiago = linkSantiago + "products?" + key + "&category=";
const String productCategoriasSaoAntao = linkSantoAntao + "products?" + key + "&category=";
const String productCategoriasSaoVicente = linkSaoVicente + "products?" + key + "&category=";
const String productCategoriasSaoNicolau = linkSaoNicolau + "products?" + key + "&category=";
const String productCategoriasBoaVista = linkBoaVista+ "products?" + key + "&category=";
const String productCategoriasSal = linkSal + "products?" + key + "&category=";
const String productCategoriasMaio = linkMaio + "products?" + key + "&category=";
const String productCategoriasFogo = linkFogo + "products?" + key + "&category=";
const String productCategoriasBrava = linkBrava + "products?" + key + "&category=";

const String get_Produto = link + "products/";


//! Cart
const String getCart = link_2 + "cart";
const String getCartSantiago = CocartSantiago + "cart";
const String getCartSaoAntao = CocartSantoAntao+ "cart";
const String getCartSaoVicente = CocartSaoVicente + "cart";
const String getCartSaoNicolau = CocartSaoNicolau+ "cart";
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
const String register_client_SantoAntao = linkSantoAntao + "customers?" + key;
const String register_client_SaoVicente = linkSaoVicente + "customers?" + key;
const String register_client_SaoNicolau = linkSaoNicolau + "customers?" + key;
const String register_client_Sal =linkSal + "customers?" + key;
const String register_client_BoaVista = linkBoaVista + "customers?" + key;
const String register_client_Maio = linkMaio + "customers?" + key;
const String register_client_Santiago = linkSantiago + "customers?" + key;
const String register_client_Fogo = linkFogo + "customers?" + key;
const String register_client_Brava = linkBrava + "customers?" + key;

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

const String request_login_cocart_="";
const String request_loginCocart_SantoAntao = CocartSantoAntao + "login";
const String request_loginCocart_SaoVicente = CocartSaoVicente + "login";
const String request_loginCocart_SaoNicolau = CocartSaoNicolau + "login";
const String request_loginCocart_Sal = CocartSal + "login";
const String request_loginCocart_BoaVista = CocartBoaVista + "login";
const String request_loginCocart_Maio = CocartMaio+ "login";
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
const String getOrderSantoAntao = linkSantoAntao + "orders?" + key;
const String getOrderSaoVicente = linkSaoVicente+ "orders?" + key;
const String getOrderSaoNicolau = linkSaoNicolau + "orders?" + key;
const String getOrderSal = linkSal + "orders?" + key;
const String getOrderBoaVista = linkBoaVista + "orders?" + key;
const String getOrderMaio = linkMaio + "orders?" + key;
const String getOrderSantiago = linkSantiago + "orders?" + key;
const String getOrderFogo = linkFogo + "orders?" + key;
const String getOrderBrava = linkBrava + "orders?" + key;




const String getOrderId =link+"orders/";
const String getOrderIdSantoAntao =linkSantoAntao+"orders/";
const String getOrderIdSaoVicente =linkSaoVicente+"orders/";
const String getOrderIdSaoNicolau =linkSaoNicolau+"orders/";
const String getOrderIdSal =linkSal+"orders/";
const String getOrderIdBoaVista =linkBoaVista+"orders/";
const String getOrderIdMaio =linkMaio+"orders/";
const String getOrderIdSantiago =linkSantiago+"orders/";
const String getOrderIdFogo =linkFogo+"orders/";
const String getOrderIdBrava =linkBrava+"orders/";
