import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final auth = FirebaseAuth.instance;

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isObscurePassword = true;

  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final syncCardNotifier = ref.read(syncCardProvider.notifier);
    final syncCardState = ref.watch(syncCardProvider);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    try {
      if (syncCardState.isLoginMode) {
        await auth.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        syncCardNotifier.getFileMetadata();
      } else {
        await auth.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        syncCardNotifier.setLoginMode(true);
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
    final syncCardNotifier = ref.read(syncCardProvider.notifier);
    final syncCardState = ref.watch(syncCardProvider);

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
                    if (syncCardState.isLoginMode)
                      TextButton.icon(
                        icon: Icon(
                          Icons.drive_file_move,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () {
                          syncCardNotifier.toggleLocalBackUp();
                        },
                        label: Text(
                          appLocalizations.localImportExport,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    if (syncCardState.isLoginMode) const SizedBox(height: 6),
                    TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s'))
                        ],
                        controller: _emailController,
                        onSaved: (value) {
                          _enteredEmail = value!;
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return appLocalizations.emailValidationError;
                          }
                          return null;
                        },
                        decoration: kAuthScreenInputDecoration(context)
                            .copyWith(
                                labelText: appLocalizations.authEmailLabel)),
                    const SizedBox(height: 12),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s'))
                      ],
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
                                icon: Icon(_isObscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              if (syncCardState.isLoginMode)
                                IconButton(
                                  onPressed: _submit,
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                ),
                            ],
                          ),
                        ),
                      ),
                      obscureText: _isObscurePassword,
                    ),
                    if (!syncCardState.isLoginMode) const SizedBox(height: 12),
                    if (!syncCardState.isLoginMode)
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s'))
                        ],
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return appLocalizations
                                .passwordConfirmValidationError;
                          }
                          return null;
                        },
                        decoration:
                            kAuthScreenInputDecoration(context).copyWith(
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
                              syncCardNotifier
                                  .setLoginMode(!syncCardState.isLoginMode);
                            });
                          },
                          child: Text(
                            syncCardState.isLoginMode
                                ? appLocalizations.authCreateAccountButton
                                : appLocalizations.authAlreadyHaveAccountButton,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            syncCardNotifier.setPasswordResetMode(true);
                            syncCardNotifier.setLoginMode(true);
                          },
                          child: Text(
                            appLocalizations.forgotMyPassword,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
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
