import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/i18n/translations.g.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingName extends ConsumerStatefulWidget {
  const OnboardingName({super.key});

  @override
  ConsumerState<OnboardingName> createState() => _OnboardingNameState();
}

class _OnboardingNameState extends ConsumerState<OnboardingName> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialize the text controller with existing value if available
    final currentName = ref.read(onboardingFormNotifierProvider).name;
    if (currentName != null) {
      _nameController.text = currentName;
    }

    // Auto-focus the text field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      children: [
        Text(
          t.signup_onboarding.name.title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        _buildNameInput(context),
      ],
    );
  }

  Widget _buildNameInput(BuildContext context) {
    final t = Translations.of(context);

    return TextField(
      controller: _nameController,
      focusNode: _focusNode,
      textCapitalization: TextCapitalization.words,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colors.onSurface,
      ),
      cursorColor: context.colors.accent,
      decoration: InputDecoration(
        hintText: t.signup_onboarding.name.placeholder,
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.grey1,
        ),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        ref.read(onboardingFormNotifierProvider.notifier).updateName(value);
      },
    );
  }
}
