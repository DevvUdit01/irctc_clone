import 'package:get/get.dart';
import 'package:udit_assesment/features/BottomNavigation/bottom_navigation_bar_binding.dart';
import 'package:udit_assesment/features/BottomNavigation/bottom_navigation_bar_view.dart';
import 'package:udit_assesment/features/add%20pessenger/Add_Passenger_View.dart';
import 'package:udit_assesment/features/add%20pessenger/Add_Passenger_binding.dart';
import 'package:udit_assesment/features/edit%20pessenger/Edit_Passenger_View.dart';
import 'package:udit_assesment/features/edit%20pessenger/Edit_Passenger_binding.dart';
import 'package:udit_assesment/features/homepage/home_page_binding.dart';
import 'package:udit_assesment/features/homepage/home_page_view.dart';
import 'package:udit_assesment/features/login/login_page_binding.dart';
import 'package:udit_assesment/features/login/login_page_view.dart';
import 'package:udit_assesment/features/otp%20authentication/otp_authentication_binding.dart';
import 'package:udit_assesment/features/otp%20authentication/otp_authentication_view.dart';
import 'package:udit_assesment/features/passenger%20master%20list/passenger_master_list_binding.dart';
import 'package:udit_assesment/features/passenger%20master%20list/passenger_master_list_view.dart';
import 'package:udit_assesment/features/search%20train/Search_Train_View.dart';
import 'package:udit_assesment/features/search%20train/Search_Train_binding.dart';
import 'package:udit_assesment/routing/routes_constant.dart';
import 'package:udit_assesment/features/signup/signup_page_binding.dart';
import 'package:udit_assesment/features/signup/signup_page_view.dart';
import 'package:udit_assesment/features/splash%20screen/splash_screen_binding.dart';
import 'package:udit_assesment/features/splash%20screen/splash_screen_view.dart';


List <GetPage> getpage= [
  GetPage(
    name: RoutesConstant.login, 
    page:()=>const LoginPageView(),
    binding: LoginPageBinding(),
    ),
  GetPage(
    name: RoutesConstant.signup, 
    page:()=>SignupPageView(),
    binding: SignupPageBinding(),
    ),
  GetPage(
    name: RoutesConstant.home, 
    page:()=>HomePageView(),
    binding: HomePageBinding(),
    ),
  GetPage(
    name: RoutesConstant.bottomnavigation, 
    page:()=>const BottomNavigationBarView(),
    binding: BottomNavigationBarBinding(),
    ),

  // GetPage(
  //   name: RoutesConstant.settings, 
  //   page:()=>SettingsPageView(),
  //   binding: SettingsPageBinding(),
  //   ),

  // GetPage(
  //   name: RoutesConstant.profile, 
  //   page:()=>const ProfilePageView(),
  //   binding: ProfilePageBinding(),
  //   ),
    
    GetPage(
    name: RoutesConstant.splashscreen, 
    page:()=>const SplashScreenView(),
    binding: SplashScreenBinding(),
    ),
    GetPage(
    name: RoutesConstant.editPessenger, 
    page:()=>const EditPassengerView(),
    binding: EditPassengerBinding(),
    ),
  //   GetPage(
  //   name: RoutesConstant.imageupload, 
  //   page:()=>const ImageUploadView(),
  //   binding: ImageUploadBinding(),
  //   ),
    GetPage(
    name: RoutesConstant.otpAuthentication, 
    page:()=> OtpAuthenticationView(),
    binding: OtpAuthenticationBinding(),
    ),
    GetPage(
    name: RoutesConstant.searchtrain, 
    page:()=> SearchTrainView(),
    binding: SearchTrainBinding(),
    ),
    GetPage(
    name: RoutesConstant.addPessenger, 
    page:()=> AddPassengerView(),
    binding: AddPassengerBinding(),
    ),
    GetPage(
    name: RoutesConstant.passengerMasterList, 
    page:()=> PassengerMasterListView(),
    binding: PassengerMasterListBinding(),
    ),
];