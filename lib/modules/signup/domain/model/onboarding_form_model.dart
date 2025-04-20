import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_form_model.freezed.dart';
part 'onboarding_form_model.g.dart';

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

  bool isStepValid(String step) {
    switch (step) {
      case 'name':
        return isNameValid;
      case 'gender':
        return isGenderValid;
      case 'birthday':
        return isBirthDateValid;
      case 'height':
        return isHeightValid;
      case 'weight':
        return isWeightValid;
      case 'fitness-goal':
        return isFitnessGoalsValid;
      case 'activity':
        return isActivityLevelValid;
      case 'diet':
        return isDietValid;
      case 'injuries-history':
      case 'health-condition':
      case 'completed':
        return true;
      default:
        return false;
    }
  }
}
