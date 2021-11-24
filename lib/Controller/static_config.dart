import 'package:manda_bai/Model/user.dart';

late User user;

String description_mandabai = 'MandaBai é uma empresa criada em 25-10-2018 no concelho de Santa Catarina, ilha de Santiago Cabo Verde.\nSurgiu da ideia de que deveria haver uma alternativa para o envio de produtos para familiares e amigos em Cabo-Verde com a mesma ou melhor rapidez e segurança com que se envia dinheiro.\n Sendo assim Carlos Sedoneo Pereira , criou um site online onde se pode encontrar uma variedade de produtos que vai desde generos alimenticios, electrodomésticos a materiais escolares, que podem ser comprados para presentear e\ou ajudar amigos, familiares e instituições de caridade em Cabo Verde.\nUma mais valia que se pode obter em preferir a MandaBai é que quando se compra os produtos expostos no site, a entrega desses produtos é oferecida gratuitamente pela Mandabai para todo Cabo Verde.\nA Mandabai abrange todas as 9 ilhas habitadas de Cabo Verde assim como o envio gratuito á essas ilhas na casa do destinatário.\nPara o uso do nosso serviço é lhe cobrado apenas uma taxa de 5 euros.\nSurpreenda alguém com uma encomenda com rapidez, seriedade, simpatia e segurança';
String ver_dados_pessoais="Dados Pessoais \n Nome: "+user.name+"\n Email: "+user.email+"\n Telefone: "+user.telefone+"\n Morada: \n";
String description_carlos = 'Mentor por trás do  empreendimento Mandabai. Acreditou que era possível o envio de produtos para familiares e amigos,através de processos online, provando ser um método eficaz e fazendo a diferença na vida de muitos cabo-verdianos.';
String description_missao = 'Contribuir para o aprofundamento e fortalecimento das relações familiares e de amizade entre os nossos clientes ;\nFazer com que os Cabo-Verdianos espalhados pela diáspora se sintam cada vez mais próximos de Cabo Verde ;\nOferecer produtos e serviços de qualidade com rapidez e simpatia.';
String description_visao ='Ser o melhor e maior site de Cabo Verde na mente e no coração dos consumidores e dos funcionários.\nColocar á disposição dos nossos clientes um serviço que seja visto como qualitativamente diferenciador no curto, médio e longo prazo.\nSer uma startup reconhecida pela sua excelência, rapidez, qualidade e simpatia.';
String description_valores ='Integridade e honestidade;\nEmpenho para com os clientes e parceiros;\nAbertura e respeito para com os outros e empenho para contribuir para o seu desenvolvimento;\nQualidade, excelência e rapidez;/nResponsabilidade social e ambiental;\nCo-prosperidades;\nConfiança, respeito para com os clientes, funcionários e parceiros;\nLiderança e diversidade.';





//! Configuração de serviços

const String link="https://www.mandabai.com/wp-json/wc/v3/";
const String consumer_key="ck_99b6b6151e8db4d15190cd8fef823839f2595594";
const String consumer_secret="cs_2f6fd0fc9ff05307dada1a8104e6f27c39b6cd86";

const String categorias=link+"products/categories?consumer_key="+consumer_key+"&consumer_secret="+consumer_secret;
const String productCategorias=link+"products?consumer_key="+consumer_key+"&consumer_secret="+consumer_secret+"&category=";