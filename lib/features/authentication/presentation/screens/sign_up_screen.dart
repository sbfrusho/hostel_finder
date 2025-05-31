import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hostel_finder/core/constants/app_colors.dart';
import 'package:hostel_finder/core/constants/app_strings.dart';
import 'package:hostel_finder/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final imageHeight = MediaQuery.of(context).size.height * 0.3;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows app bar to overlap image
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // Remove shadow
        title: Text(
          AppStrings.signUp,
          style: TextStyle(
            color: Colors.white, // White text for contrast
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white), // White back button
      ),
      body: Column(
        children: [
          // Image section (covers top part including behind app bar)
          SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: Image.asset('imgs/home_image.png', fit: BoxFit.cover),
          ),

          // White background form section
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.register,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        hintText: AppStrings.email,
                        prefixIcon: Icons.person,
                        controller: emailController,
                        validator: (val) => val == null || val.isEmpty
                            ? AppStrings.hintEmail
                            : null,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: AppStrings.password,
                        prefixIcon: Icons.lock_outlined,
                        controller: passwordController,
                        obscureText: true,
                        validator: (val) => val != null && val.length >= 6
                            ? null
                            : AppStrings.passwordTooShort,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: AppStrings.confirmPassword,
                        prefixIcon: Icons.lock_outlined,
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return AppStrings.confirmYourPassword;
                          } else if (val != passwordController.text) {
                            return AppStrings.passwrodDoNotMatch;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: loading
                              ? null
                              : () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    setState(() => loading = true);
                                    try {
                                      await authProvider.signUp(
                                        emailController.text.trim(),
                                        passwordController.text,
                                      );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInScreen(),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                    setState(() => loading = false);
                                  }
                                },
                          child: loading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: AppStrings.alreadyHaveAccount,
                          style: const TextStyle(color: Colors.black87),
                          children: [
                            TextSpan(
                              text: AppStrings.signIn,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
