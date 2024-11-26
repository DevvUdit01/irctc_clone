import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udit_assesment/core/globals.dart' as glb;
import 'package:udit_assesment/routing/routes_constant.dart';
import 'dart:async';

class OtpAuthenticationController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  String otp = '';
  //late final SmsRetriever smsRetriever;

  late String _verificationId;
  RxBool isCodeSent = false.obs;
  RxBool isLoading = false.obs;
  RxInt remainingTime = 60.obs;
  Timer? timer;

  @override


  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    timer?.cancel();
    super.onClose();
  }

  Future<void> verifynum() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text.trim()}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback gets called when the SMS code is auto-retrieved or the instant verification is completed
          await FirebaseAuth.instance.signInWithCredential(credential);
          otpController.text = credential.smsCode ?? '';
          Get.toNamed(RoutesConstant.home);
        },
        verificationFailed: (FirebaseAuthException ex) {
          isLoading.value = false;
          Get.snackbar("Verification Failed", ex.message ?? "Unknown error");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          isCodeSent.value = true;
          isLoading.value = false;
          startTimer();
          print("Code sent to ${phoneController.text}");
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          print("Auto retrieval timeout");
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
      print("Exception: $e");
    }
  }

  Future<void> verifyotp() async {
    try {
      isLoading.value = true;
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text.trim(),
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      isLoading.value = false;

      if (userCredential != null) {
        glb.islogin.value = true;
        await setLoginValue();
        Get.defaultDialog(
          barrierDismissible: false,
          title: 'Success',
          content: Column(
            children: [
              Image.asset('assets/successful.png', height: 100,),
              Text('OTP Verified Successfully!', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutesConstant.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text('Ok', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),),
            )
          ]
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar("FirebaseAuthException", e.message ?? "Unknown error");
      print("FirebaseAuthException: $e");
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
      print("Exception: $e");
    }
  }

  void startTimer() {
    remainingTime.value = 60; // Reset the timer
    timer?.cancel(); // Cancel any previous timers
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> setLoginValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", glb.islogin.value);
  }

  Future<void> getLoginValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    glb.islogin.value = prefs.getBool("isLogin") ?? false;
  }
}

/// You, as a developer should implement this interface.
/// You can use any package to retrieve the SMS code. in this example we are using SmartAuth
// class SmsRetrieverImpl implements SmsRetriever {
//   const SmsRetrieverImpl(this.smartAuth);

//   final SmartAuth smartAuth;

//   @override
//   Future<void> dispose() {
//     return smartAuth.removeSmsListener();
//   }

//   @override
//   Future<String?> getSmsCode() async {
//     final signature = await smartAuth.getAppSignature();
//     debugPrint('App Signature: $signature');
//     final res = await smartAuth.getSmsCode(
//       useUserConsentApi: true,
//     );
//     if (res.succeed && res.codeFound) {
//       return res.code!;
//     }
//     return null;
//   }

//   @override
//   bool get listenForMultipleSms => false;
// }
