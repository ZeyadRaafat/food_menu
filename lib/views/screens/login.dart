import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reco_genie/constants.dart';
import 'package:reco_genie/core/utils/assets.dart';
import 'package:reco_genie/features/auth_controller.dart';
import 'package:reco_genie/views/widgets/AccountCheck.dart';
import 'package:reco_genie/views/widgets/elevated_button.dart';
import 'package:reco_genie/views/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Text(
                "Let's have a meal",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w900
                  ),
              ),
              Lottie.asset(
                AssetsData.burger,
                width: 350,
                height: 350,
                fit: BoxFit.contain
              ),
              const SizedBox(height: 10),
              TextFieldFor(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 10),
              TextFieldFor(
                controller: passwordController,
                hintText: 'Your Password',
                isPasswordField: true,
                prefixIcon: Icons.password,
              ),
              const SizedBox(height: 20),
              Obx(() {
                return authController.isLoading.value
                    ? CircularProgressIndicator()
                    : CustomElevatedButton(
                        backgroundColor:primaryColor,
                        text: 'Login',
                        onPressed: () {
                          authController.login(
                            emailController.text,
                            passwordController.text,
                          );
                        },
                      );
              }),
              const SizedBox(height: 15),
              // Add error message display
              Obx(() {
                if (authController.errorMessage.value.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      authController.errorMessage.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
              const SizedBox(height: 15),
              AccountCheck(press: () {
                authController.clearError(); // Clear error before navigating
                Get.toNamed('/register');
              }),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
