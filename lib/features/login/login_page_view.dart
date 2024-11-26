import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/login/login_page_controller.dart';
import 'package:udit_assesment/routing/routes_constant.dart';


class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05), // Add some top padding
              Text(
                "Login to your account",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.height * 0.006),
              Row(
                children: [
                  Text(
                    "Hello, welcome back!",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    CupertinoIcons.hand_raised,
                    size: 20,
                  )
                ],
              ),
              SizedBox(height: Get.height*0.04),
              Center(
                child:   CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Get.height*0.1,
                  backgroundImage: const AssetImage('assets/logo3.png',
                   ),
                ),
              ),
              SizedBox(height: Get.height*0.07),
              Column(
                children: [
                  TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: controller.validateEmail,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: controller.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                    validator: controller.validatePassword,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.04),
              SizedBox(
                height: Get.height*0.06,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                  onPressed: () {
                      controller.login(controller.emailController.text, controller.passwordController.text);
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.height * 0.0235,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.lightBlue),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or sign in with",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: Get.height * 0.0225,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.lightBlue),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: controller.signInWithFacebook,
                    child: Container(
                      height: Get.height * 0.063,
                      width: Get.width * 0.14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Get.height * 0.01),
                      
                      ),
                      child: Icon(Icons.facebook,
                      size: 55,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.logInWithGoogle,
                    child: Container(
                      height: Get.height * 0.063,
                      width: Get.width * 0.14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Get.height * 0.01),
                      
                      ),
                      child: Center(
                        child: Container(
                          height: Get.height * 0.058,
                          width: Get.width * 0.1,
                          child: Image.asset("assets/google_icon.jpg"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.logInWithPhone,
                    child: Container(
                      height: Get.height * 0.063,
                      width: Get.width * 0.14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Get.height * 0.01),
                        
                      ),
                      child: Icon(Icons.phone,
                      size: 45,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: Get.height * 0.023,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Get.toNamed(RoutesConstant.signup);
                    },//controller.signup,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: Get.height * 0.023,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
