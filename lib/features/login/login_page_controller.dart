

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udit_assesment/features/login/auth_controller.dart';
import 'package:udit_assesment/routing/routes_constant.dart';

class LoginPageController extends GetxController {
  @override

  final AuthController authController = Get.put(AuthController());

  RxBool islight = false.obs;
  RxString nameValue = "Login Page".obs;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter password";
    } else if (value.length < 6) {
      return "Password should contain 6 letters";
    }
    return null;
  }

  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Get.toNamed(RoutesConstant.login);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Warning", "Signin/login failed $e");
    }
  }

  void signup() {
    Get.toNamed(RoutesConstant.signup);
  }

  Future<void> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential).then((e) async {
        bool isExist = await isEmailExist(email: e.user!.email!);
        if (isExist) {
          Get.snackbar('Successful', 'Sign in with Google!');
          Get.toNamed(RoutesConstant.home);
        } else {
          Get.snackbar('Warning', "Invalid credential");
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Google: $e');
    } finally {
      await GoogleSignIn().disconnect();
    }
  }

  



  static Future<bool> isEmailExist({required String email}) async {
    var checkEmail = await firestore.collection('registerUser').where('email', isEqualTo: email).get();
    return checkEmail.docs.isEmpty;
  }

  static Future<bool> addUser({required String password, required String email}) async {
    bool emailExists = await isEmailExist(email: email);
    if (emailExists) {
      print("Adding user in Firestore database");
      return true;
    } else {
      print("Failed to add user");
    }
    return false;
  }

  void logInWithPhone() {
    Get.toNamed(RoutesConstant.otpAuthentication);
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Sign in to Firebase with Facebook credential
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        // Check if the email is already registered through other methods
        if (userCredential.additionalUserInfo!.isNewUser) {
          // New user, add data to Firestore
          await firestore.collection('users').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'email': userCredential.user!.email,
            'name': userCredential.user!.displayName,
            'photoURL': userCredential.user!.photoURL,
          });
        } else {
          // Existing user, link accounts if necessary
          if (userCredential.user!.email != null) {
            // Get the existing user
            User? existingUser = _auth.currentUser;

            // Check if the existing user has a different provider (like Google)
            if (existingUser != null && existingUser.email != userCredential.user!.email) {
              // Link the Facebook credential to the existing account
              await existingUser.linkWithCredential(credential);
              // Refresh the user data after linking
              existingUser = _auth.currentUser;
            }

            // Update user data in Firestore if needed
            await firestore.collection('users').doc(existingUser!.uid).update({
              'name': existingUser.displayName,
              'photoURL': existingUser.photoURL,
            });
          }
        }

        // Update authController with current user info
        authController.user = userCredential.user;
        authController.isSignedIn.value = true;

        Get.snackbar('Success', 'Signed in with Facebook!');
        Get.toNamed(RoutesConstant.home);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to sign in with Facebook: $e');
    }
  }


}
