import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/users/login_register/loginpage.dart';
import 'package:drawer/screens/users/Home_Screen/home.dart';
import 'package:drawer/services/auth_hepler.dart';
import 'package:drawer/screens/users/user_widget/beveled_button.dart';
import 'package:drawer/screens/users/user_widget/custom_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namecontroller = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String SelectedRole = "User";
  bool isLoading = false;
  bool showDropdown = false;
  final AuthenticationHelper authenticationHelper = AuthenticationHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Sign Up to your account to continue",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  CustomTextField(
                      hint: 'Enter Name',
                      label: 'Name',
                      ispass: false,
                      controller: namecontroller),
                  const SizedBox(height: 10),
                  CustomTextField(
                      ispass: false,
                      hint: 'Enter Email',
                      label: 'Email',
                      controller: emailController),
                  const SizedBox(height: 10),
                  CustomTextField(
                      ispass: false,
                      hint: 'Enter Phone Number',
                      label: 'Phone Number',
                      controller: phoneController),
                  const SizedBox(height: 10),
                  CustomTextField(
                      ispass: false,
                      hint: 'Enter Address',
                      label: 'Address',
                      controller: addressController),
                  const SizedBox(height: 10),
                  CustomTextField(
                      ispass: true,
                      hint: 'Enter Password',
                      label: 'Password',
                      controller: passwordController),
                  const SizedBox(height: 10),
                  if (showDropdown)
                    DropdownButtonFormField(
                        value: SelectedRole,
                        decoration: const InputDecoration(
                            labelText: 'Role', border: OutlineInputBorder()),
                        items: ["Admin", "User"].map((role) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            SelectedRole = newValue!;
                          });
                        }),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : BeveledButton(
                            title: 'Sign Up',
                            width: MediaQuery.of(context).size.width,
                            onTap: () async {
                              try {
                                setState(() {
                                  isLoading = true;
                                });

                                UserCredential? userCredential =
                                    await authenticationHelper.signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                if (userCredential != null) {
                                  await authenticationHelper.storeUserData(
                                    name: namecontroller.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                    role: SelectedRole,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Signup Successful')),
                                  );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Signup Failed: ${e.toString()}')),
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // void _signUpUser() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   await authenticationHelper
  //       .signUp(email: emailController.text, password: passwordController.text)
  //       .then((value) {
  //     return authenticationHelper.storeUserData(name, email, password, phone, address, role)
  //   });

  //   setState(() {
  //     isLoading = false;
  //   });

  // if (result == null) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Signup Successful')),
  //   );
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const LoginPage()));
  // } else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Signup Failed: $result')),
  //   );
  // }
}
