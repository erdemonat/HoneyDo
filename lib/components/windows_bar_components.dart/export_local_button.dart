import 'package:flutter/material.dart';
import 'package:honeydo/service/isar_service.dart';

class ExportLocalButton extends StatelessWidget {
  const ExportLocalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          await IsarService().createBackUp();
        },
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
                Icons.upload_file_outlined,
                size: 55,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const Text(
                'Verileri dışa aktar',
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
