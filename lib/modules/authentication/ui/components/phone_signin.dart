// ignore_for_file: use_build_context_synchronously

import 'package:fitnect/modules/authentication/utils/error_handlers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PhoneSignInComponent extends ConsumerWidget {
  const PhoneSignInComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        shape: BoxShape.circle,
      ),
      child: RawMaterialButton(
        elevation: 0,
        onPressed: () {
          HapticFeedback.mediumImpact();
          try {
            // Navigate to phone auth page
            context.push('/signinWithPhone');
          } catch (e) {
            // Use the utility function to handle errors consistently
            handleAuthError(ref, e, 'Cannot access phone authentication');
          }
        },
        shape: const CircleBorder(),
        fillColor: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: const Icon(Icons.phone, size: 24),
      ),
    );
  }
}
