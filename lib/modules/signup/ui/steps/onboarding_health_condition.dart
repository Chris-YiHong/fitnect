import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingHealthCondition extends ConsumerStatefulWidget {
  const OnboardingHealthCondition({super.key});

  @override
  ConsumerState<OnboardingHealthCondition> createState() =>
      _OnboardingHealthConditionState();
}

class _OnboardingHealthConditionState
    extends ConsumerState<OnboardingHealthCondition> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final healthConditions =
        ref.watch(onboardingFormNotifierProvider).healthConditions;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            "Any health conditions?",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "This helps us ensure your workout is safe",
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (healthConditions.isNotEmpty)
            _buildConditionsList(healthConditions),
          const SizedBox(height: 16),
          _buildAddConditionForm(),
          const SizedBox(height: 24),
          Text(
            "This information is used only to customize your fitness experience",
            style: context.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: context.colors.onBackground.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConditionsList(List<HealthCondition> conditions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            "Your health conditions:",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onBackground,
            ),
          ),
        ),
        ...conditions
            .map((condition) => _buildConditionItem(condition))
            .toList(),
      ],
    );
  }

  Widget _buildConditionItem(HealthCondition condition) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  condition.name,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                if (condition.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    condition.description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: context.colors.error),
            onPressed: () {
              ref
                  .read(onboardingFormNotifierProvider.notifier)
                  .removeHealthCondition(condition);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddConditionForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a health condition",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Condition name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: context.colors.surfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Description (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: context.colors.surfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addHealthCondition,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Add Condition",
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                // Skip this step by going to the next one
                final notifier = ref.read(
                  onboardingFormNotifierProvider.notifier,
                );
                final nextStep = notifier.getNextStep('health-condition');
                if (nextStep != null) {
                  context.goNamed(
                    'signupOnboarding',
                    pathParameters: {'step': nextStep},
                  );
                }
              },
              child: Text(
                "No health conditions to report",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addHealthCondition() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a condition name')),
      );
      return;
    }

    final newCondition = HealthCondition(
      name: _nameController.text,
      description: _descriptionController.text,
    );

    ref
        .read(onboardingFormNotifierProvider.notifier)
        .addHealthCondition(newCondition);

    // Clear the form
    _nameController.clear();
    _descriptionController.clear();
  }
}
