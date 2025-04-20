import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OnboardingInjuriesHistory extends ConsumerStatefulWidget {
  const OnboardingInjuriesHistory({super.key});

  @override
  ConsumerState<OnboardingInjuriesHistory> createState() =>
      _OnboardingInjuriesHistoryState();
}

class _OnboardingInjuriesHistoryState
    extends ConsumerState<OnboardingInjuriesHistory> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final injuries = ref.watch(onboardingFormNotifierProvider).injuries;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            "Any previous injuries?",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "This helps us customize your fitness plan",
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (injuries.isNotEmpty) _buildInjuriesList(injuries),
          const SizedBox(height: 16),
          _buildAddInjuryForm(),
        ],
      ),
    );
  }

  Widget _buildInjuriesList(List<Injury> injuries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            "Your injuries:",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onBackground,
            ),
          ),
        ),
        ...injuries.map((injury) => _buildInjuryItem(injury)).toList(),
      ],
    );
  }

  Widget _buildInjuryItem(Injury injury) {
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
                  injury.name,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  injury.description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Date: ${DateFormat.yMMMd().format(injury.date)}",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: context.colors.error),
            onPressed: () {
              ref
                  .read(onboardingFormNotifierProvider.notifier)
                  .removeInjury(injury);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddInjuryForm() {
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
            "Add an injury",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Injury name',
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
              labelText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: context.colors.surfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _showDatePicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: context.colors.surfaceVariant,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date: ${DateFormat.yMMMd().format(_selectedDate)}",
                    style: context.textTheme.bodyMedium,
                  ),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addInjury,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Add Injury",
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addInjury() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an injury name')),
      );
      return;
    }

    final newInjury = Injury(
      name: _nameController.text,
      description:
          _descriptionController.text.isEmpty
              ? 'No description provided'
              : _descriptionController.text,
      date: _selectedDate,
    );

    ref.read(onboardingFormNotifierProvider.notifier).addInjury(newInjury);

    // Clear the form
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedDate = DateTime.now();
    });
  }
}
