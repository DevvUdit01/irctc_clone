import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'otp_authentication_controller.dart';
import 'package:pinput/pinput.dart';

class OtpAuthenticationView extends GetView<OtpAuthenticationController> {
  const OtpAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter your mobile number to receive an',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    'OTP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: '1234567890',
                      prefixText: '+91 ',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: controller.verifynum,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text(
                            'Get OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                  const SizedBox(height: 20),
                  Obx(() => controller.isCodeSent.value
                      ? AutofillGroup(
                          child: Column(
                            children: [
                              Text(
                                'Enter the code sent to your number',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                controller.phoneController.text,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // TextField(
                              //   controller: controller.otpController,
                              //   decoration: const InputDecoration(
                              //     labelText: 'OTP',
                              //     border: OutlineInputBorder(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(20)),
                              //     ),
                              //   ),
                              //   autofillHints: [AutofillHints.oneTimeCode],
                              //   keyboardType: TextInputType.number,
                              //   onEditingComplete: () {
                              //     controller.verifyotp();
                              //   },
                              // ),

                Pinput(
              length: 6,
              //smsRetriever: controller.smsRetriever,
              controller: controller.otpController,
              defaultPinTheme: PinTheme(
                 width: 56,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF19F420),
              ),
              
              ),
            ),
                              const SizedBox(height: 15),
                              Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Remaining Time : ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        '${controller.remainingTime.value}s',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: controller.verifyotp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Verify OTP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
