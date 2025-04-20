import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OnboardingBirthday extends ConsumerStatefulWidget {
  const OnboardingBirthday({super.key});

  @override
  ConsumerState<OnboardingBirthday> createState() => _OnboardingBirthdayState();
}

class _OnboardingBirthdayState extends ConsumerState<OnboardingBirthday> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize with existing value or default to 18 years ago
    final formModel = ref.read(onboardingFormNotifierProvider);
    selectedDate =
        formModel.birthDate ??
        DateTime.now().subtract(const Duration(days: 365 * 18));

    // Update the form model if it's empty
    if (formModel.birthDate == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(onboardingFormNotifierProvider.notifier)
            .updateBirthDate(selectedDate);
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
          "When's your Birthday?",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _buildDatePicker(context),
        const SizedBox(height: 24),
        _buildSelectedDate(context),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.primary, width: 2),
      ),
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: selectedDate,
          maximumDate: DateTime.now(),
          minimumDate: DateTime(1900),
          onDateTimeChanged: _onDateChanged,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildSelectedDate(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd().format(selectedDate);

    return Text(
      'Selected: $formattedDate',
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colors.onBackground.withOpacity(0.7),
      ),
    );
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    ref.read(onboardingFormNotifierProvider.notifier).updateBirthDate(date);
  }
}
