import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_intermediate_story_app/provider/auth_provider.dart';
import 'package:flutter_intermediate_story_app/widgets/flag_icon.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  final Function() onLogin;
  final Function() onRegister;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.loginAppBar),
        actions: const [FlagIcon()],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.emailValidator;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.email,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.password,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.passwordValidator;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                if (context.watch<AuthProvider>().isLoadingLogin)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final scaffoldMessenger = ScaffoldMessenger.of(context);

                        final authRead = context.read<AuthProvider>();

                        final result = await authRead.login(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('${result.message}')),
                        );

                        if (result.error != true) widget.onLogin();
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.loginButton),
                  ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    widget.onRegister();
                  },
                  child: Text(AppLocalizations.of(context)!.registerButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
