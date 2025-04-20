import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/i18n/translations.g.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingWeight extends ConsumerStatefulWidget {
  const OnboardingWeight({super.key});

  @override
  ConsumerState<OnboardingWeight> createState() => _OnboardingWeightState();
}

class _OnboardingWeightState extends ConsumerState<OnboardingWeight> {
  double _weight = 70.0; // Default weight in kg

  @override
  void initState() {
    super.initState();
    // Initialize with existing value if available
    final currentWeight = ref.read(onboardingFormNotifierProvider).weightKg;
    if (currentWeight != null) {
      _weight = currentWeight;
    } else {
      // Set default weight in the form
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(onboardingFormNotifierProvider.notifier).updateWeight(_weight);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          t.signup_onboarding.weight.title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          t.signup_onboarding.weight.subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onBackground.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Text(
          "${_weight.toInt()} ${t.signup_onboarding.weight.kg}",
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
        ),
        const SizedBox(height: 24),
        _buildWeightSlider(),
      ],
    );
  }

  Widget _buildWeightSlider() {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: context.colors.primary,
        inactiveTrackColor: context.colors.surfaceVariant,
        thumbColor: context.colors.primary,
        trackHeight: 8,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
      ),
      child: Slider(
        min: 40, // Min weight in kg
        max: 150, // Max weight in kg
        value: _weight,
        onChanged: (value) {
          setState(() {
            _weight = value;
          });
          ref.read(onboardingFormNotifierProvider.notifier).updateWeight(value);
        },
      ),
    );
  }
}
