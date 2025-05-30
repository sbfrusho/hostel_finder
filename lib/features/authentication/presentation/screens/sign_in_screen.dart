import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hostel_finder/core/constants/app_colors.dart';
import 'package:hostel_finder/core/constants/app_strings.dart';
import 'package:hostel_finder/shared/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final imageHeight = MediaQuery.of(context).size.height * 0.3;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows app bar to overlap image
      body: Column(
        children: [
          // Image section (full width, behind app bar)
          SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: Image.asset(
              'imgs/home_image.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // White background form section
          Expanded(
            
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.signIn,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 5, 90, 49),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: emailController,
                        validator: (value) =>
                            value!.isEmpty ? AppStrings.emailRequired : null,
                        hintText: AppStrings.email,
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.passwordRequired;
                          } else if (value.length < 6) {
                            return AppStrings.passwordTooShort;
                          }
                          return null;
                        }, 
                        hintText: AppStrings.password, 
                        prefixIcon: Icons.lock,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: loading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    try {
                                      await auth.signIn(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                      if (mounted) context.go('/home');
                                    } catch (e) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(e.toString())),
                                        );
                                      }
                                    }
                                    setState(() => loading = false);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 5, 90, 49),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: loading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  AppStrings.signIn,
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
                          text: "${AppStrings.dontHaveAccount} ",
                          style: const TextStyle(color: Colors.black87, fontSize: 14),
                          children: [
                            TextSpan(
                              text: AppStrings.signUp,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.push('/signup'),
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