import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/i18n/translations.g.dart';
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
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          t.signup_onboarding.birthday.title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          t.signup_onboarding.birthday.subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onBackground.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _buildDateSelector(context),
        const SizedBox(height: 24),
        _buildSelectedDate(context),
      ],
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCupertinoDatePicker(context),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.colors.primary, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, color: context.colors.primary),
            const SizedBox(width: 8),
            Text(
              DateFormat.yMMMMd().format(selectedDate),
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCupertinoDatePicker(BuildContext context) {
    // Create a temporary date that won't affect the form until confirmed
    DateTime tempDate = selectedDate;

    // Show the Cupertino picker in a modal bottom sheet
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: context.colors.grey2),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Update the selectedDate and form on confirmation
                      setState(() {
                        selectedDate = tempDate;
                      });
                      ref
                          .read(onboardingFormNotifierProvider.notifier)
                          .updateBirthDate(tempDate);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: context.colors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 0, color: context.colors.grey1),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1900),
                  onDateTimeChanged: (DateTime date) {
                    // Only update the temporary date
                    tempDate = date;
                  },
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectedDate(BuildContext context) {
    final age = DateTime.now().difference(selectedDate).inDays ~/ 365;

    return Text(
      'Age: $age years',
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colors.onBackground.withOpacity(0.7),
      ),
    );
  }
}
