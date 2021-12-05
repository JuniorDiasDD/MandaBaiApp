import 'package:manda_bai/Model/user.dart';

User user = new User(
    name: " ",
    nickname: " ",
    telefone: " ",
    senha: "",
    email: "",
    avatar: "",
    username: "");

const String description_mandabai =
    'MandaBai é uma empresa criada em 25-10-2018 no concelho de Santa Catarina, ilha de Santiago Cabo Verde.\nSurgiu da ideia de que deveria haver uma alternativa para o envio de produtos para familiares e amigos em Cabo-Verde com a mesma ou melhor rapidez e segurança com que se envia dinheiro.\n Sendo assim Carlos Sedoneo Pereira , criou um site online onde se pode encontrar uma variedade de produtos que vai desde generos alimenticios, electrodomésticos a materiais escolares, que podem ser comprados para presentear e\ou ajudar amigos, familiares e instituições de caridade em Cabo Verde.\nUma mais valia que se pode obter em preferir a MandaBai é que quando se compra os produtos expostos no site, a entrega desses produtos é oferecida gratuitamente pela Mandabai para todo Cabo Verde.\nA Mandabai abrange todas as 9 ilhas habitadas de Cabo Verde assim como o envio gratuito á essas ilhas na casa do destinatário.\nPara o uso do nosso serviço é lhe cobrado apenas uma taxa de 5 euros.\nSurpreenda alguém com uma encomenda com rapidez, seriedade, simpatia e segurança';
String ver_dados_pessoais = "Dados Pessoais \n Nome: " +
    user.name +
    "\n Email: " +
    user.email +
    "\n Telefone: " +
    user.telefone +
    "\n Morada: \n";
const String description_carlos =
    ' Mentor por trás do  empreendimento Mandabai. Acreditou que era possível o envio de produtos para familiares e amigos,através de processos online, provando ser um método eficaz e fazendo a diferença na vida de muitos cabo-verdianos.';
const String description_missao =
    '-Contribuir para o aprofundamento e fortalecimento das relações familiares e de amizade entre os nossos clientes ;\n-Fazer com que os Cabo-Verdianos espalhados pela diáspora se sintam cada vez mais próximos de Cabo Verde ;\n-Oferecer produtos e serviços de qualidade com rapidez e simpatia.';
const String description_visao =
    '-Ser o melhor e maior site de Cabo Verde na mente e no coração dos consumidores e dos funcionários;\n-Colocar á disposição dos nossos clientes um serviço que seja visto como qualitativamente diferenciador no curto, médio e longo prazo;\n-Ser uma startup reconhecida pela sua excelência, rapidez, qualidade e simpatia.';
const String description_valores =
    ' 1º-Integridade e honestidade;\n 2º-Empenho para com os clientes e parceiros;\n 3º-Abertura e respeito para com os outros e empenho para contribuir para o seu desenvolvimento;\n 4º-Qualidade, excelência e rapidez;/nResponsabilidade social e ambiental;\n 5º-Co-prosperidades;\n 6º-Confiança, respeito para com os clientes, funcionários e parceiros;\n 7º-Liderança e diversidade.';

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
