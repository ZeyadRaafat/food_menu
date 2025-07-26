import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reco_genie/constants.dart';
import 'package:reco_genie/core/utils/assets.dart';

import 'package:reco_genie/features/auth_controller.dart';
import 'package:reco_genie/views/widgets/AccountCheck.dart';
import 'package:reco_genie/views/widgets/elevated_button.dart';
import 'package:reco_genie/views/widgets/text_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final AuthController viewModel = Get.put(AuthController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            
            const SizedBox(height: 100),

             Lottie.asset(
                AssetsData.hotdog,
                width: double.infinity,
                height: 350,
                fit: BoxFit.contain
              ),

            TextFieldFor(
              prefixIcon: Icons.verified_user,
              controller: nameController,
              hintText: 'Username',
            ),
            const SizedBox(height: 16),

            TextFieldFor(
              prefixIcon: Icons.email,
              controller: emailController,
              hintText: 'Email Address',
            ),
            const SizedBox(height: 16),

            TextFieldFor(
              prefixIcon: Icons.password,
              controller: passwordController,
              hintText: 'Password',
              isPasswordField: true,
            ),
            const SizedBox(height: 30),

            Obx(
                  () => viewModel.isLoading.value
                  ? CircularProgressIndicator()
                  : CustomElevatedButton(
                text: 'Sign Up',
                backgroundColor: primaryColor,
                onPressed: () {
                  viewModel.register(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text,
                  );
                },
              ),
            ),

            // Fix error message display
            Obx(() {
              if (viewModel.errorMessage.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    viewModel.errorMessage.value,
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

            const SizedBox(height: 20),

            AccountCheck(
              login: false,
              press: () {
                viewModel.clearError(); // Clear error before navigating
                Get.toNamed('/login');
              },
            ),

          ],),
        )
      ),
    );
  }
}
