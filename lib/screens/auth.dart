import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final auth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isObscurePassword = true;

  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final SyncCardProvider syncCardProvider = Provider.of(context, listen: false);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    try {
      if (syncCardProvider.isLoginMode) {
        final userCredential = await auth.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
        print(userCredential);
      } else {
        final userCredentials = await auth.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(appLocalizations.emailAlreadyInUse),
          ),
        );
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(appLocalizations.authFailed),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final SyncCardProvider syncCardProvider = Provider.of(context, listen: false);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (syncCardProvider.isLoginMode)
                      TextButton.icon(
                        icon: Icon(
                          Icons.drive_file_move,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () {
                          syncCardProvider.toggleLocalBackUp();
                        },
                        label: Text(
                          appLocalizations.localImportExport,
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    if (syncCardProvider.isLoginMode) const SizedBox(height: 6),
                    TextFormField(
                        controller: _emailController,
                        onSaved: (value) {
                          _enteredEmail = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return appLocalizations.emailValidationError;
                          }
                          return null;
                        },
                        decoration: kAuthScreenInputDecoration(context).copyWith(labelText: appLocalizations.authEmailLabel)),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return appLocalizations.passwordValidationError;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                      decoration: kAuthScreenInputDecoration(context).copyWith(
                        labelText: appLocalizations.authPasswordLabel,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscurePassword = !_isObscurePassword;
                                  });
                                },
                                icon: Icon(_isObscurePassword ? Icons.visibility : Icons.visibility_off),
                              ),
                              if (syncCardProvider.isLoginMode)
                                IconButton(
                                  onPressed: _submit,
                                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                                ),
                            ],
                          ),
                        ),
                      ),
                      obscureText: _isObscurePassword,
                    ),
                    if (!syncCardProvider.isLoginMode) const SizedBox(height: 12),
                    if (!syncCardProvider.isLoginMode)
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (_passwordController.text != _confirmPasswordController.text) {
                            return appLocalizations.passwordConfirmValidationError;
                          }
                          return null;
                        },
                        decoration: kAuthScreenInputDecoration(context).copyWith(
                          labelText: appLocalizations.authConfirmPasswordLabel,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              onPressed: _submit,
                              icon: const Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ),
                        ),
                        obscureText: _isObscurePassword,
                      ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              syncCardProvider.setLoginMode(!syncCardProvider.isLoginMode);
                            });
                          },
                          child: Text(
                            syncCardProvider.isLoginMode ? appLocalizations.authCreateAccountButton : appLocalizations.authAlreadyHaveAccountButton,
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            syncCardProvider.setPasswordResetMode(true);
                            syncCardProvider.setLoginMode(true);
                          },
                          child: Text(
                            appLocalizations.forgotMyPassword,
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
