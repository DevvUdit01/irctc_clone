import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/login/login_page_view.dart';
import 'package:udit_assesment/routing/get_pages_constant.dart';
import 'package:udit_assesment/routing/routes_constant.dart';
import 'package:udit_assesment/features/signup/signup_page_view.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
    runApp(const MyApp());
    
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      initialRoute: RoutesConstant.splashscreen,
      getPages: getpage,
    );
  }
}

