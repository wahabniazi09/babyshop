import 'package:BabyShop/screens/users/user_widget/beveled_button.dart';
import 'package:BabyShop/screens/users/user_widget/custom_form.dart';
import 'package:BabyShop/services/auth_hepler.dart';
import 'package:BabyShop/services/validation_services.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Forget Password!",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Forget Password in to your account to continue",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    CustomTextField(
                        validator: validateEmail,
                        hint: 'Enter Your Email',
                        label: 'Email',
                        ispass: false,
                        controller: emailController),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: isLoding
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : BeveledButton(
                              title: 'Forget Password',
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoding = true;
                                  });

                                  AuthenticationHelper authHelper =
                                      AuthenticationHelper();
                                  await authHelper.resetPassword(
                                      email: emailController.text.trim());

                                  setState(() {
                                    isLoding = false;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Password reset email sent! Check your inbox.")),
                                  );
                                }
                              },
                              width: MediaQuery.of(context).size.width,
                            ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
