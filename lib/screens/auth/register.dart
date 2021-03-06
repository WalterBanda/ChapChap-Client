import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/user.dart';
import '../../core/providers/user.dart';
import '../../core/routes/router.dart';
import '../../core/routes/routes.dart';
import '../../styles/icons/chap_chap_icons.dart';
import '../../styles/ui/colors.dart';
import 'login.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  static const id = "register";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => AuthRouter.router.currentState!
              .popAndPushNamed(AuthRoutes.onboarding),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Create your Account",
                style: TextStyle(
                  fontFamily: "SF Pro Rounded",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  authInput(
                    hint: "Your Username",
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    inputType: TextInputType.name,
                    validator: (value) => Validator.validateName(name: value),
                    prefix: const Icon(
                      ChapChap.user,
                      size: 15,
                    ),
                  ),
                  const SizedBox(height: 15),
                  authInput(
                    hint: "Enter your Email",
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    inputType: TextInputType.emailAddress,
                    validator: (value) => Validator.validateEmail(email: value),
                    prefix: const Icon(
                      Icons.email_rounded,
                      size: 15,
                    ),
                  ),
                  const SizedBox(height: 15),
                  authInput(
                    hint: "Enter your Password",
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    validator: (value) =>
                        Validator.validatePassword(password: value),
                    inputType: TextInputType.visiblePassword,
                    private: true,
                    prefix: const Icon(
                      Icons.lock_rounded,
                      size: 15,
                    ),
                  ),
                  const SizedBox(height: 15),
                  authInput(
                    hint: "Enter your Phone Number",
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    inputType: TextInputType.phone,
                    validator: (value) => Validator.validatePhone(phone: value),
                    prefix: const Icon(
                      Icons.phone_rounded,
                      size: 15,
                    ),
                  ),
                  const SizedBox(height: 15),
                  authInput(
                    hint: "Enter your Address",
                    controller: _addressController,
                    focusNode: _addressFocusNode,
                    inputType: TextInputType.streetAddress,
                    validator: (value) =>
                        Validator.validateAddress(address: value),
                    prefix: const Icon(
                      ChapChap.location,
                      size: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _userRegister(
                          context: context,
                          username: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          phone: _phoneController.text,
                          address: _addressController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _userRegister({
    required String username,
    required BuildContext context,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) {
    Provider.of<UserProvider>(context, listen: false).createUser(
        context: context,
        signInMethods: SignInMethods.email,
        payload: UserModel(
          name: username,
          email: email,
          password: password,
          phone: phone,
          address: address,
          roles: [Roles.user],
        ));
  }
}
