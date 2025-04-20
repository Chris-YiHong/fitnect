import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingDiet extends ConsumerStatefulWidget {
  const OnboardingDiet({super.key});

  @override
  ConsumerState<OnboardingDiet> createState() => _OnboardingDietState();
}

class _OnboardingDietState extends ConsumerState<OnboardingDiet> {
  final TextEditingController _dietController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _dietSuggestions = [
    'No specific diet',
    'Vegetarian',
    'Vegan',
    'Pescatarian',
    'Keto',
    'Paleo',
    'Low carb',
    'Intermittent fasting',
    'Gluten-free',
    'Dairy-free',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize with existing value if available
    final currentDiet = ref.read(onboardingFormNotifierProvider).diet;
    if (currentDiet != null) {
      _dietController.text = currentDiet;
    }

    // Auto-focus the text field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _dietController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          "Any specific diet?",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Tell us about your eating habits",
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.onBackground.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _buildDietInput(context),
        const SizedBox(height: 16),
        Text(
          "Suggestions",
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        _buildDietSuggestions(),
      ],
    );
  }

  Widget _buildDietInput(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.primary, width: 2),
      ),
      child: TextField(
        controller: _dietController,
        focusNode: _focusNode,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colors.onSurface,
        ),
        decoration: InputDecoration(
          hintText: 'Enter your diet (e.g., Vegetarian)',
          hintStyle: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.onSurface.withOpacity(0.5),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        onChanged: (value) {
          ref.read(onboardingFormNotifierProvider.notifier).updateDiet(value);
        },
      ),
    );
  }

  Widget _buildDietSuggestions() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          _dietSuggestions.map((diet) {
            return InkWell(
              onTap: () {
                _dietController.text = diet;
                ref
                    .read(onboardingFormNotifierProvider.notifier)
                    .updateDiet(diet);
              },
              borderRadius: BorderRadius.circular(20),
              child: Chip(
                label: Text(diet),
                backgroundColor: context.colors.surfaceVariant,
                side: BorderSide(
                  color: context.colors.primary.withOpacity(0.3),
                ),
              ),
            );
          }).toList(),
    );
  }
}
