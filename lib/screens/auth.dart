import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    final SyncCardProvider syncCardProvider = Provider.of(context, listen: false);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(decoration: kAuthScreenInputDecoration(context).copyWith(labelText: appLocalizations.authEmailLabel)),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: kAuthScreenInputDecoration(context).copyWith(
                        labelText: appLocalizations.authPasswordLabel,
                        suffixIcon: Row(
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
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios_rounded),
                              )
                          ],
                        ),
                      ),
                      obscureText: _isObscurePassword,
                    ),
                    if (!syncCardProvider.isLoginMode) const SizedBox(height: 12),
                    if (!syncCardProvider.isLoginMode)
                      TextFormField(
                        decoration: kAuthScreenInputDecoration(context).copyWith(
                          labelText: appLocalizations.authConfirmPasswordLabel,
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscureConfirmPassword = !_isObscureConfirmPassword;
                                  });
                                },
                                icon: Icon(_isObscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                              ),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded))
                            ],
                          ),
                        ),
                        obscureText: _isObscureConfirmPassword,
                      ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              syncCardProvider.toggleAuth();
                              syncCardProvider.setLoginMode(true);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                syncCardProvider.setLoginMode(!syncCardProvider.isLoginMode);
                              });
                            },
                            child: Text(
                              syncCardProvider.isLoginMode ? appLocalizations.authCreateAccountButton : appLocalizations.authAlreadyHaveAccountButton,
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            )),
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
