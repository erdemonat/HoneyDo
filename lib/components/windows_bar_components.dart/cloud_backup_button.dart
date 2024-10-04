import 'package:flutter/material.dart';

class CloudBackUpButton extends StatelessWidget {
  const CloudBackUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.cloud_download_outlined,
                size: 55,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const Text(
                'Verilerinizi eşitlemek için \ngiriş yapın',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
