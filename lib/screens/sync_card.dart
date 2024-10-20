import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/components/export_import_button.dart';
import 'package:honeydo/components/windows_bar_components.dart/sync_status.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:honeydo/screens/auth.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SyncButton extends StatefulWidget {
  const SyncButton({super.key});

  @override
  SyncButtonState createState() => SyncButtonState();
}

class SyncButtonState extends State<SyncButton> with SingleTickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showOverlay(BuildContext context) async {
    final SyncCardProvider syncCardProvider = Provider.of<SyncCardProvider>(context, listen: false);
    final overlay = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: position.dx - (renderBox.size.height * 8),
            top: position.dy + renderBox.size.height,
            child: FadeTransition(
              opacity: _animation,
              child: ScaleTransition(
                scale: _animation,
                alignment: Alignment.topCenter,
                child: const Material(
                  color: Colors.transparent,
                  child: SyncDialogBox(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry);
    _controller.forward();
    Future.delayed(
      Durations.long2,
      () => syncCardProvider.getFileMetadata(),
    );
  }

  void _removeOverlay() {
    SyncCardProvider syncCardProvider = Provider.of(context, listen: false);
    _controller.reverse().then(
      (_) {
        _overlayEntry.remove();
        syncCardProvider.resetSyncCardState();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      child: IconButton(
        onPressed: () {
          Provider.of<SyncCardProvider>(context, listen: false).getFileMetadata;
          _showOverlay(context);
        },
        hoverColor: Theme.of(context).colorScheme.primary,
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(),
          ),
        ),
        icon: Icon(
          Icons.person,
          size: 14,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}

bool isLocalBackUp = false;
bool isLogined = false;
bool isCloudBackUp = false;

class SyncDialogBox extends StatefulWidget {
  const SyncDialogBox({
    super.key,
  });

  @override
  State<SyncDialogBox> createState() => _SyncDialogBoxState();
}

class _SyncDialogBoxState extends State<SyncDialogBox> {
  @override
  Widget build(BuildContext context) {
    final SyncCardProvider syncCardProvider = Provider.of(context, listen: true);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
      ),
      width: 400,
      height: syncCardProvider.isLocalBackUp ? 236 : (syncCardProvider.isLoginMode ? 236 : 310),
      child: syncCardProvider.isPasswordResetMode ? StackBackButton(widget: _buildPasswordReset(context)) : _buildAuthOrSyncScreen(context, syncCardProvider),
    );
  }

  Widget _buildAuthOrSyncScreen(BuildContext context, SyncCardProvider syncCardProvider) {
    return !syncCardProvider.isLocalBackUp
        ? StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return const SyncStatus();
              } else {
                return const AuthScreen();
              }
            },
          )
        : const StackBackButton(widget: LocalSyncButtons());
  }

  Widget _buildPasswordReset(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(appLocalizations.resetPassword, style: kCalendarDayNumberTextStyle(context).copyWith(fontSize: 18)),
                Icon(
                  Icons.lock_reset,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: emailController,
                decoration: kAuthScreenInputDecoration(context).copyWith(
                  label: Text(appLocalizations.authEmailLabel),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(appLocalizations.resetPasswordEmailSent),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Provider.of<SyncCardProvider>(context, listen: false).setPasswordResetMode(false); // Close reset screen
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(appLocalizations.resetPasswordEmailFailed),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StackBackButton extends StatelessWidget {
  final Widget widget;
  const StackBackButton({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    SyncCardProvider syncCardProvider = Provider.of(context, listen: false);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 42,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextButton.icon(
              onPressed: syncCardProvider.resetSyncCardState,
              label: Text(
                appLocalizations.back,
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface,
            ),
            width: double.infinity,
            height: 200,
            child: widget,
          ),
        ),
      ],
    );
  }
}

class LocalSyncButtons extends StatelessWidget {
  const LocalSyncButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ExportImportButton(
          buttonText: AppLocalizations.of(context)!.exportData,
          onTap: () async {
            await IsarService().createBackUp();
          },
          icon: Symbols.drive_folder_upload_rounded,
          margin: const EdgeInsets.only(left: 25),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: VerticalDivider(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        ExportImportButton(
          buttonText: AppLocalizations.of(context)!.importData,
          onTap: () async {
            await IsarService().restoreDB();
          },
          icon: Symbols.install_desktop_rounded,
          margin: const EdgeInsets.only(right: 25),
        ),
      ],
    );
  }
}
