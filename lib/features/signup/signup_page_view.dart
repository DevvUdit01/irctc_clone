import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udit_assesment/features/signup/signup_page_controller.dart';

class SignupPageView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignupPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupPageController controller = Get.put(SignupPageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      'Hello, there!  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.hand_raised,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 80,
                  child: Image.asset(
                    'assets/logo3.png',
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.mobileController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value.length != 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signUpWithEmailPassword();
                    }
                  },
                  child: const Text('SignUp'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.black),
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
                      child: Divider(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: controller.signUpWithFacebook,
                      child: Container(
                        height: Get.height * 0.063,
                        width: Get.width * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Get.height * 0.01),
                        ),
                        child: Icon(
                          Icons.facebook,
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
                        child: Icon(
                          Icons.phone,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
