import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_form_provider.g.dart';

const List<String> onboardingSteps = [
  'name',
  'gender',
  'birthday',
  'height',
  'weight',
  'fitness-goal',
  'activity',
  'diet',
  'injuries-history',
  'health-condition',
  'completed',
];

@Riverpod(keepAlive: true)
class OnboardingFormNotifier extends _$OnboardingFormNotifier {
  @override
  OnboardingFormModel build() {
    return const OnboardingFormModel();
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateGender(Gender gender) {
    state = state.copyWith(gender: gender);
  }

  void updateBirthDate(DateTime birthDate) {
    state = state.copyWith(birthDate: birthDate);
  }

  void updateHeight(double heightCm) {
    state = state.copyWith(heightCm: heightCm);
  }

  void updateWeight(double weightKg) {
    state = state.copyWith(weightKg: weightKg);
  }

  void updateFitnessGoals(List<FitnessGoal> fitnessGoals) {
    state = state.copyWith(fitnessGoals: fitnessGoals);
  }

  void toggleFitnessGoal(FitnessGoal goal) {
    final currentGoals = List<FitnessGoal>.from(state.fitnessGoals);
    if (currentGoals.contains(goal)) {
      currentGoals.remove(goal);
    } else {
      currentGoals.add(goal);
    }
    state = state.copyWith(fitnessGoals: currentGoals);
  }

  void updateActivityLevel(ActivityLevel activityLevel) {
    state = state.copyWith(activityLevel: activityLevel);
  }

  void updateDiet(String diet) {
    state = state.copyWith(diet: diet);
  }

  void addInjury(Injury injury) {
    final injuries = List<Injury>.from(state.injuries)..add(injury);
    state = state.copyWith(injuries: injuries);
  }

  void removeInjury(Injury injury) {
    final injuries = List<Injury>.from(state.injuries)..remove(injury);
    state = state.copyWith(injuries: injuries);
  }

  void addHealthCondition(HealthCondition condition) {
    final conditions = List<HealthCondition>.from(state.healthConditions)
      ..add(condition);
    state = state.copyWith(healthConditions: conditions);
  }

  void removeHealthCondition(HealthCondition condition) {
    final conditions = List<HealthCondition>.from(state.healthConditions)
      ..remove(condition);
    state = state.copyWith(healthConditions: conditions);
  }

  bool isStepValid(String step) {
    return state.isStepValid(step);
  }

  String? getNextStep(String currentStep) {
    final currentIndex = onboardingSteps.indexOf(currentStep);
    if (currentIndex < 0 || currentIndex >= onboardingSteps.length - 1) {
      return null;
    }
    return onboardingSteps[currentIndex + 1];
  }

  String? getPreviousStep(String currentStep) {
    final currentIndex = onboardingSteps.indexOf(currentStep);
    if (currentIndex <= 0) {
      return null;
    }
    return onboardingSteps[currentIndex - 1];
  }

  double getProgress(String currentStep) {
    final currentIndex = onboardingSteps.indexOf(currentStep);
    if (currentIndex < 0) return 0.0;
    // Do not count 'completed' step in progress calculation
    return (currentIndex + 1) / (onboardingSteps.length - 1);
  }
}
