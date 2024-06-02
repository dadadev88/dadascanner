import 'package:dadascanner/providers/global_app_provider.dart';
import 'package:dadascanner/screens/home_screen.dart';
import 'package:dadascanner/ui/input_decorations.dart';
import 'package:dadascanner/utils/colors.dart';
import 'package:dadascanner/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginLayout(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: CustomCard(
            child: _LoginForm(),
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
    final GlobalAppProvider appProvider = Provider.of<GlobalAppProvider>(context);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text('Hello World', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.primary( hintText: 'example@email.com', labelText: 'Email address', icon: Icons.alternate_email, ),
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value!) ? null : 'Invalid email';
            },
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.primary( hintText: '***********', labelText: 'Password', icon: Icons.alternate_email, ),
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'Password required min 6 characters';
            },
          ),
          const SizedBox(height: 20),
          MaterialButton(
            color: AppColors.primary,
            disabledColor: Colors.grey,
            onPressed: appProvider.isLoading ? null : () async {
              // FocusScope.of(context).unfocus();
              final bool isFormValid = formKey.currentState?.validate() ?? false;

              if (isFormValid) {
                appProvider.openLoader();
                
                await Future.delayed(const Duration(seconds: 2));

                appProvider.closeLoader();
                Navigator.pushReplacementNamed( context, HomeScreen.routeName);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 35 ),
              child: Text(
                appProvider.isLoading ? 'Wait a moment...' : 'Login',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
