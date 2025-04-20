import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingHeight extends ConsumerStatefulWidget {
  const OnboardingHeight({super.key});

  @override
  ConsumerState<OnboardingHeight> createState() => _OnboardingHeightState();
}

class _OnboardingHeightState extends ConsumerState<OnboardingHeight> {
  double _height = 170.0; // Default height in cm

  @override
  void initState() {
    super.initState();
    // Initialize with existing value if available
    final currentHeight = ref.read(onboardingFormNotifierProvider).heightCm;
    if (currentHeight != null) {
      _height = currentHeight;
    } else {
      // Set default height in the form
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(onboardingFormNotifierProvider.notifier).updateHeight(_height);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          "What's your height?",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Text(
          "${_height.toInt()} cm",
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
        ),
        const SizedBox(height: 24),
        _buildHeightSlider(),
      ],
    );
  }

  Widget _buildHeightSlider() {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: context.colors.primary,
        inactiveTrackColor: context.colors.surfaceVariant,
        thumbColor: context.colors.primary,
        trackHeight: 8,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
      ),
      child: Slider(
        min: 120, // Min height in cm
        max: 220, // Max height in cm
        value: _height,
        onChanged: (value) {
          setState(() {
            _height = value;
          });
          ref.read(onboardingFormNotifierProvider.notifier).updateHeight(value);
        },
      ),
    );
  }
}
