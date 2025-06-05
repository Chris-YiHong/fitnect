import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fitnect/modules/signup/ui/signup_onboarding_page.dart';

part 'onboarding_form_model.freezed.dart';
part 'onboarding_form_model.g.dart';

// Helper functions for DateTime serialization
String _dateTimeToIsoString(DateTime date) => date.toUtc().toIso8601String();
DateTime _dateTimeFromIsoString(String dateString) =>
    DateTime.parse(dateString);
String? _dateTimeToIsoStringNullable(DateTime? date) =>
    date?.toUtc().toIso8601String();
DateTime? _dateTimeFromIsoStringNullable(String? dateString) =>
    dateString != null ? DateTime.parse(dateString) : null;

enum Gender { male, female, other, preferNotToSay }

enum ActivityLevel { sedentary, light, moderate, active, veryActive }

enum FitnessGoal {
  loseWeight,
  gainMuscle,
  improveFitness,
  increaseEndurance,
  improveFlexibility,
  other,
}

@freezed
abstract class Injury with _$Injury {
  const factory Injury({
    required String name,
    required String description,
    @JsonKey(toJson: _dateTimeToIsoString, fromJson: _dateTimeFromIsoString)
    required DateTime date,
  }) = _Injury;

  factory Injury.fromJson(Map<String, dynamic> json) => _$InjuryFromJson(json);
}

@freezed
abstract class HealthCondition with _$HealthCondition {
  const factory HealthCondition({
    required String name,
    required String description,
  }) = _HealthCondition;

  factory HealthCondition.fromJson(Map<String, dynamic> json) =>
      _$HealthConditionFromJson(json);
}

@freezed
abstract class OnboardingFormModel with _$OnboardingFormModel {
  const factory OnboardingFormModel({
    String? name,
    Gender? gender,
    @JsonKey(
      toJson: _dateTimeToIsoStringNullable,
      fromJson: _dateTimeFromIsoStringNullable,
    )
    DateTime? birthDate,
    double? heightCm,
    double? weightKg,
    @Default([]) List<FitnessGoal> fitnessGoals,
    ActivityLevel? activityLevel,
    String? diet,
    @Default([]) List<Injury> injuries,
    @Default([]) List<HealthCondition> healthConditions,
  }) = _OnboardingFormModel;

  const OnboardingFormModel._();

  factory OnboardingFormModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingFormModelFromJson(json);

  // Validation helpers
  bool get isNameValid => name != null && name!.isNotEmpty;
  bool get isGenderValid => gender != null;
  bool get isBirthDateValid => birthDate != null;
  bool get isHeightValid => heightCm != null && heightCm! > 0;
  bool get isWeightValid => weightKg != null && weightKg! > 0;
  bool get isFitnessGoalsValid => fitnessGoals.isNotEmpty;
  bool get isActivityLevelValid => activityLevel != null;
  bool get isDietValid => diet != null && diet!.isNotEmpty;

  bool isStepValid(String stepName) {
    try {
      final step = OnboardingStep.fromRouteName(stepName);
      return _isStepEnumValid(step);
    } catch (_) {
      return false;
    }
  }

  bool _isStepEnumValid(OnboardingStep step) {
    return switch (step) {
      OnboardingStep.name => isNameValid,
      OnboardingStep.gender => isGenderValid,
      OnboardingStep.birthday => isBirthDateValid,
      OnboardingStep.height => isHeightValid,
      OnboardingStep.weight => isWeightValid,
      OnboardingStep.fitnessGoal => isFitnessGoalsValid,
      OnboardingStep.activity => isActivityLevelValid,
      OnboardingStep.diet => isDietValid,
      OnboardingStep.injuriesHistory => true,
      OnboardingStep.healthCondition => true,
      OnboardingStep.completed => true,
    };
  }
}
