import 'package:dadascanner/providers/providers.dart';
import 'package:dadascanner/screens/screens.dart';
import 'package:dadascanner/ui/input_decorations.dart';
import 'package:dadascanner/utils/colors.dart';
import 'package:dadascanner/utils/regex_util.dart';
import 'package:dadascanner/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: LoginLayout(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomCard(
            screenWidth: screenSize.width,
            child: const _LoginForm(),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final GlobalAppProvider appProvider =
        Provider.of<GlobalAppProvider>(context);
    final Map<String, dynamic> successData = {
      'email': 'dhanieldiaz@flutter.dev',
      'password': '123456'
    };
    TextEditingController emailController =
        TextEditingController(text: successData['email']);
    TextEditingController passwordController =
        TextEditingController(text: successData['password']);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text('Login', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.primary(
              hintText: 'example@email.com',
              labelText: 'Email address',
              icon: Icons.alternate_email,
            ),
            validator: (value) {
              return RegexUtil.isValidEmail(value!) ? null : 'Invalid email';
            },
          ),
          TextFormField(
            controller: passwordController,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.primary(
              hintText: '***********',
              labelText: 'Password',
              icon: Icons.alternate_email,
            ),
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'Password required min 6 characters';
            },
          ),
          const SizedBox(height: 20),
          MaterialButton(
            color: AppColors.primary,
            disabledColor: Colors.grey,
            onPressed: appProvider.isLoading
                ? null
                : () async {
                    final bool isFormValid =
                        formKey.currentState?.validate() ?? false;

                    if (isFormValid) {
                      appProvider.openLoading();
                      await Future.delayed(const Duration(seconds: 2));
                      appProvider.closeLoading();

                      final isSuccessLogin = emailController.text ==
                              successData['email'] &&
                          passwordController.text == successData['password'];

                      SnackBar snackBar = _getSnackbar(isSuccessLogin, context);

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              child: Text(
                appProvider.isLoading ? 'Wait a moment...' : 'Login',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            ),
            child: const Text('Back to home'),
          )
        ],
      ),
    );
  }

  SnackBar _getSnackbar(bool isSuccessLogin, BuildContext context) {
    if (isSuccessLogin) {
      return SnackBar(
        content: const Text(
          'Login success...',
          style: TextStyle(color: Colors.green),
        ),
        action: SnackBarAction(
          label: 'Back',
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          ),
        ),
      );
    }

    return const SnackBar(
      content: Text('Login failed...', style: TextStyle(color: Colors.red)),
    );
  }
}
