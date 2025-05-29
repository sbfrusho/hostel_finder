import 'package:flutter/material.dart';
import 'package:hostel_finder/core/constants/app_strings.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.signIn)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: AppStrings.email),
                  validator: (value) =>
                  value!.isEmpty ? AppStrings.emailRequired : null,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: AppStrings.password),
                  obscureText: true,
                  validator: (value) =>
                  value!.isEmpty ? AppStrings.passwordRequired :
                  value.length < 6 ? AppStrings.passwordTooShort : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : () async {
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
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text(AppStrings.signIn),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.push('/signup'),
                  child: Text(
                    AppStrings.dontHaveAccount + AppStrings.signUp,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}