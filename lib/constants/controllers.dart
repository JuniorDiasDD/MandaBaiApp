import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manda_bai/Controller/authentication_controller.dart';
import 'package:manda_bai/Controller/cart_controller.dart';
import 'package:manda_bai/Controller/category_controller.dart';
import 'package:manda_bai/Controller/full_controller.dart';
import 'package:manda_bai/Controller/location_controller.dart';
import 'package:manda_bai/Controller/mandaBaiController.dart';
import 'package:manda_bai/Controller/product_controller.dart';
import 'package:manda_bai/UI/category_filter/controller/mandaBaiProductController.dart';
import 'package:manda_bai/firebase_options.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

MandaBaiController mandaBaiController = MandaBaiController.instance;
MandaBaiProductController mandaBaiProductController = MandaBaiProductController.instance;
FullController fullControllerController = FullController.instance;
CategoryController categoryController = CategoryController.instance;
ProductController productController = ProductController.instance;
AuthenticationController authenticationController = AuthenticationController.instance;
CartPageController cartPageController = CartPageController.instance;
LocationController locationController = LocationController.instance;
