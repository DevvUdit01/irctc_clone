import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:udit_assesment/core/model.dart';
import 'package:udit_assesment/features/login/auth_controller.dart';
import 'package:udit_assesment/routing/routes_constant.dart';

class SignupPageController extends GetxController {
final AuthController authController = Get.put(AuthController());

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  logInWithPhone() {
    Get.toNamed(RoutesConstant.otpAuthentication);
  }

  static Future<bool> isEmailExist({required String email}) async {
    var checkEmail = await FirebaseFirestore.instance.collection('registerUser').where('email', isEqualTo: email).get();
    return checkEmail.docs.isEmpty;
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

  Future<void> signUpWithFacebook() async {
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

  Future<void> signUpWithEmailPassword() async {
    try {
      //UserCredential userCredential = 
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      SignupModel userdata = SignupModel(
        emailid: emailController.text,
        name: nameController.text,
        mobile: mobileController.text,
        password: passwordController.text,
      );

      await firestore.collection('SignupUsers').add(userdata.toMap());
      
      Get.snackbar('Success', 'User signed up successfully!');
      Get.toNamed(RoutesConstant.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The email address is already in use by another account.');
      } else if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'The email address is not valid.');
      } else {
        Get.snackbar('Error', 'Failed to sign up: ${e.message}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    }
  }
}
