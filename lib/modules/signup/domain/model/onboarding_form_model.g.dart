// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Injury _$InjuryFromJson(Map json) => _Injury(
  name: json['name'] as String,
  description: json['description'] as String,
  date: _dateTimeFromIsoString(json['date'] as String),
);

Map<String, dynamic> _$InjuryToJson(_Injury instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'date': _dateTimeToIsoString(instance.date),
};

_HealthCondition _$HealthConditionFromJson(Map json) => _HealthCondition(
  name: json['name'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$HealthConditionToJson(_HealthCondition instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

_OnboardingFormModel _$OnboardingFormModelFromJson(Map json) =>
    _OnboardingFormModel(
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      birthDate: _dateTimeFromIsoStringNullable(json['birthDate'] as String?),
      heightCm: (json['heightCm'] as num?)?.toDouble(),
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      fitnessGoals:
          (json['fitnessGoals'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$FitnessGoalEnumMap, e))
              .toList() ??
          const [],
      activityLevel: $enumDecodeNullable(
        _$ActivityLevelEnumMap,
        json['activityLevel'],
      ),
      diet: json['diet'] as String?,
      injuries:
          (json['injuries'] as List<dynamic>?)
              ?.map((e) => Injury.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      healthConditions:
          (json['healthConditions'] as List<dynamic>?)
              ?.map(
                (e) => HealthCondition.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OnboardingFormModelToJson(
  _OnboardingFormModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'gender': _$GenderEnumMap[instance.gender],
  'birthDate': _dateTimeToIsoStringNullable(instance.birthDate),
  'heightCm': instance.heightCm,
  'weightKg': instance.weightKg,
  'fitnessGoals':
      instance.fitnessGoals.map((e) => _$FitnessGoalEnumMap[e]!).toList(),
  'activityLevel': _$ActivityLevelEnumMap[instance.activityLevel],
  'diet': instance.diet,
  'injuries': instance.injuries.map((e) => e.toJson()).toList(),
  'healthConditions': instance.healthConditions.map((e) => e.toJson()).toList(),
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
  Gender.preferNotToSay: 'preferNotToSay',
};

const _$FitnessGoalEnumMap = {
  FitnessGoal.loseWeight: 'loseWeight',
  FitnessGoal.gainMuscle: 'gainMuscle',
  FitnessGoal.improveFitness: 'improveFitness',
  FitnessGoal.increaseEndurance: 'increaseEndurance',
  FitnessGoal.improveFlexibility: 'improveFlexibility',
  FitnessGoal.other: 'other',
};

const _$ActivityLevelEnumMap = {
  ActivityLevel.sedentary: 'sedentary',
  ActivityLevel.light: 'light',
  ActivityLevel.moderate: 'moderate',
  ActivityLevel.active: 'active',
  ActivityLevel.veryActive: 'veryActive',
};
