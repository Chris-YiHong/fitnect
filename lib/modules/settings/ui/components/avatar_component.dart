import 'package:fitnect/core/states/user_state_notifier.dart';
import 'package:fitnect/core/data/models/user.dart';
import 'package:fitnect/core/widgets/toast.dart';
import 'package:fitnect/modules/settings/ui/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class EditableUserAvatar extends ConsumerWidget {
  final OnAvatarTap? onTap;
  final double? radius;

  const EditableUserAvatar({super.key, this.onTap, this.radius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateNotifierProvider);

    return Stack(
      children: [
        UserAvatar(
          radius: radius,
          avatarUrl: switch (userState.user) {
            AuthenticatedUserData(:final avatarPath) => avatarPath,
            _ => null,
          },
          onTap: () {
            Logger().w('''
You need to install the Storage module to use this feature.
👉 Please check the documentation here :  ./docs/storage.md
''');
            showErrorToast(
              context: context,
              title: 'Storage module is missing',
              text: 'Please check the documentation here :  ./docs/storage.md',
            );
            onTap?.call();
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: .6),
                width: 4,
              ),
            ),
            child: const Center(
              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
