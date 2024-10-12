import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/components/windows_bar_components.dart/export_local_button.dart';
import 'package:honeydo/components/windows_bar_components.dart/import_local_button.dart';
import 'package:honeydo/components/windows_bar_components.dart/sync_status.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:honeydo/screens/auth.dart';
import 'package:provider/provider.dart';

class SyncButton extends StatefulWidget {
  const SyncButton({super.key});

  @override
  SyncButtonState createState() => SyncButtonState();
}

class SyncButtonState extends State<SyncButton>
    with SingleTickerProviderStateMixin {
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

  void _showOverlay(BuildContext context) {
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
    final SyncCardProvider syncCardProvider =
        Provider.of(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
      ),
      width: 400,
      height: syncCardProvider.isLocalBackUp
          ? 236
          : (syncCardProvider.isLoginMode ? 236 : 310),
      child: !syncCardProvider.isLocalBackUp
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
              })
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      syncCardProvider.toggleLocalBackUp();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                ImportLocalButton(),
                ExportLocalButton(),
              ],
            ),
    );
  }
}
