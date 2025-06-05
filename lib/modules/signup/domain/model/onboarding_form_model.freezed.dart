// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Injury {

 String get name; String get description;@JsonKey(toJson: _dateTimeToIsoString, fromJson: _dateTimeFromIsoString) DateTime get date;
/// Create a copy of Injury
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InjuryCopyWith<Injury> get copyWith => _$InjuryCopyWithImpl<Injury>(this as Injury, _$identity);

  /// Serializes this Injury to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Injury&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,date);

@override
String toString() {
  return 'Injury(name: $name, description: $description, date: $date)';
}


}

/// @nodoc
abstract mixin class $InjuryCopyWith<$Res>  {
  factory $InjuryCopyWith(Injury value, $Res Function(Injury) _then) = _$InjuryCopyWithImpl;
@useResult
$Res call({
 String name, String description,@JsonKey(toJson: _dateTimeToIsoString, fromJson: _dateTimeFromIsoString) DateTime date
});




}
/// @nodoc
class _$InjuryCopyWithImpl<$Res>
    implements $InjuryCopyWith<$Res> {
  _$InjuryCopyWithImpl(this._self, this._then);

  final Injury _self;
  final $Res Function(Injury) _then;

/// Create a copy of Injury
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? date = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Injury implements Injury {
  const _Injury({required this.name, required this.description, @JsonKey(toJson: _dateTimeToIsoString, fromJson: _dateTimeFromIsoString) required this.date});
  factory _Injury.fromJson(Map<String, dynamic> json) => _$InjuryFromJson(json);

@override final  String name;
@override final  String description;
@override@JsonKey(toJson: _dateTimeToIsoString, fromJson: _dateTimeFromIsoString) final  DateTime date;

/// Create a copy of Injury
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InjuryCopyWith<_Injury> get copyWith => __$InjuryCopyWithImpl<_Injury>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InjuryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Injury&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,date);

@override
String toString() {
  return 'Injury(name: $name, description: $description, date: $date)';
}


}

/// @nodoc
abstract mixin class _$InjuryCopyWith<$Res> implements $InjuryCopyWith<$Res> {
  factory _$InjuryCopyWith(_Injury value, $Res Function(_Injury) _then) = __$InjuryCopyWithImpl;
@override @useResult
$Res call({
 String name, String description,@JsonKey(toJson: _dateTimeToIsoString, fromJson: _dateTimeFromIsoString) DateTime date
});




}
/// @nodoc
class __$InjuryCopyWithImpl<$Res>
    implements _$InjuryCopyWith<$Res> {
  __$InjuryCopyWithImpl(this._self, this._then);

  final _Injury _self;
  final $Res Function(_Injury) _then;

/// Create a copy of Injury
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? date = null,}) {
  return _then(_Injury(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$HealthCondition {

 String get name; String get description;
/// Create a copy of HealthCondition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthConditionCopyWith<HealthCondition> get copyWith => _$HealthConditionCopyWithImpl<HealthCondition>(this as HealthCondition, _$identity);

  /// Serializes this HealthCondition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthCondition&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'HealthCondition(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $HealthConditionCopyWith<$Res>  {
  factory $HealthConditionCopyWith(HealthCondition value, $Res Function(HealthCondition) _then) = _$HealthConditionCopyWithImpl;
@useResult
$Res call({
 String name, String description
});




}
/// @nodoc
class _$HealthConditionCopyWithImpl<$Res>
    implements $HealthConditionCopyWith<$Res> {
  _$HealthConditionCopyWithImpl(this._self, this._then);

  final HealthCondition _self;
  final $Res Function(HealthCondition) _then;

/// Create a copy of HealthCondition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HealthCondition implements HealthCondition {
  const _HealthCondition({required this.name, required this.description});
  factory _HealthCondition.fromJson(Map<String, dynamic> json) => _$HealthConditionFromJson(json);

@override final  String name;
@override final  String description;

/// Create a copy of HealthCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthConditionCopyWith<_HealthCondition> get copyWith => __$HealthConditionCopyWithImpl<_HealthCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthCondition&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'HealthCondition(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$HealthConditionCopyWith<$Res> implements $HealthConditionCopyWith<$Res> {
  factory _$HealthConditionCopyWith(_HealthCondition value, $Res Function(_HealthCondition) _then) = __$HealthConditionCopyWithImpl;
@override @useResult
$Res call({
 String name, String description
});




}
/// @nodoc
class __$HealthConditionCopyWithImpl<$Res>
    implements _$HealthConditionCopyWith<$Res> {
  __$HealthConditionCopyWithImpl(this._self, this._then);

  final _HealthCondition _self;
  final $Res Function(_HealthCondition) _then;

/// Create a copy of HealthCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,}) {
  return _then(_HealthCondition(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OnboardingFormModel {

 String? get name; Gender? get gender;@JsonKey(toJson: _dateTimeToIsoStringNullable, fromJson: _dateTimeFromIsoStringNullable) DateTime? get birthDate; double? get heightCm; double? get weightKg; List<FitnessGoal> get fitnessGoals; ActivityLevel? get activityLevel; String? get diet; List<Injury> get injuries; List<HealthCondition> get healthConditions;
/// Create a copy of OnboardingFormModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingFormModelCopyWith<OnboardingFormModel> get copyWith => _$OnboardingFormModelCopyWithImpl<OnboardingFormModel>(this as OnboardingFormModel, _$identity);

  /// Serializes this OnboardingFormModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingFormModel&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&const DeepCollectionEquality().equals(other.fitnessGoals, fitnessGoals)&&(identical(other.activityLevel, activityLevel) || other.activityLevel == activityLevel)&&(identical(other.diet, diet) || other.diet == diet)&&const DeepCollectionEquality().equals(other.injuries, injuries)&&const DeepCollectionEquality().equals(other.healthConditions, healthConditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,gender,birthDate,heightCm,weightKg,const DeepCollectionEquality().hash(fitnessGoals),activityLevel,diet,const DeepCollectionEquality().hash(injuries),const DeepCollectionEquality().hash(healthConditions));

@override
String toString() {
  return 'OnboardingFormModel(name: $name, gender: $gender, birthDate: $birthDate, heightCm: $heightCm, weightKg: $weightKg, fitnessGoals: $fitnessGoals, activityLevel: $activityLevel, diet: $diet, injuries: $injuries, healthConditions: $healthConditions)';
}


}

/// @nodoc
abstract mixin class $OnboardingFormModelCopyWith<$Res>  {
  factory $OnboardingFormModelCopyWith(OnboardingFormModel value, $Res Function(OnboardingFormModel) _then) = _$OnboardingFormModelCopyWithImpl;
@useResult
$Res call({
 String? name, Gender? gender,@JsonKey(toJson: _dateTimeToIsoStringNullable, fromJson: _dateTimeFromIsoStringNullable) DateTime? birthDate, double? heightCm, double? weightKg, List<FitnessGoal> fitnessGoals, ActivityLevel? activityLevel, String? diet, List<Injury> injuries, List<HealthCondition> healthConditions
});




}
/// @nodoc
class _$OnboardingFormModelCopyWithImpl<$Res>
    implements $OnboardingFormModelCopyWith<$Res> {
  _$OnboardingFormModelCopyWithImpl(this._self, this._then);

  final OnboardingFormModel _self;
  final $Res Function(OnboardingFormModel) _then;

/// Create a copy of OnboardingFormModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? gender = freezed,Object? birthDate = freezed,Object? heightCm = freezed,Object? weightKg = freezed,Object? fitnessGoals = null,Object? activityLevel = freezed,Object? diet = freezed,Object? injuries = null,Object? healthConditions = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,fitnessGoals: null == fitnessGoals ? _self.fitnessGoals : fitnessGoals // ignore: cast_nullable_to_non_nullable
as List<FitnessGoal>,activityLevel: freezed == activityLevel ? _self.activityLevel : activityLevel // ignore: cast_nullable_to_non_nullable
as ActivityLevel?,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as String?,injuries: null == injuries ? _self.injuries : injuries // ignore: cast_nullable_to_non_nullable
as List<Injury>,healthConditions: null == healthConditions ? _self.healthConditions : healthConditions // ignore: cast_nullable_to_non_nullable
as List<HealthCondition>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _OnboardingFormModel extends OnboardingFormModel {
  const _OnboardingFormModel({this.name, this.gender, @JsonKey(toJson: _dateTimeToIsoStringNullable, fromJson: _dateTimeFromIsoStringNullable) this.birthDate, this.heightCm, this.weightKg, final  List<FitnessGoal> fitnessGoals = const [], this.activityLevel, this.diet, final  List<Injury> injuries = const [], final  List<HealthCondition> healthConditions = const []}): _fitnessGoals = fitnessGoals,_injuries = injuries,_healthConditions = healthConditions,super._();
  factory _OnboardingFormModel.fromJson(Map<String, dynamic> json) => _$OnboardingFormModelFromJson(json);

@override final  String? name;
@override final  Gender? gender;
@override@JsonKey(toJson: _dateTimeToIsoStringNullable, fromJson: _dateTimeFromIsoStringNullable) final  DateTime? birthDate;
@override final  double? heightCm;
@override final  double? weightKg;
 final  List<FitnessGoal> _fitnessGoals;
@override@JsonKey() List<FitnessGoal> get fitnessGoals {
  if (_fitnessGoals is EqualUnmodifiableListView) return _fitnessGoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fitnessGoals);
}

@override final  ActivityLevel? activityLevel;
@override final  String? diet;
 final  List<Injury> _injuries;
@override@JsonKey() List<Injury> get injuries {
  if (_injuries is EqualUnmodifiableListView) return _injuries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_injuries);
}

 final  List<HealthCondition> _healthConditions;
@override@JsonKey() List<HealthCondition> get healthConditions {
  if (_healthConditions is EqualUnmodifiableListView) return _healthConditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_healthConditions);
}


/// Create a copy of OnboardingFormModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingFormModelCopyWith<_OnboardingFormModel> get copyWith => __$OnboardingFormModelCopyWithImpl<_OnboardingFormModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingFormModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingFormModel&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&const DeepCollectionEquality().equals(other._fitnessGoals, _fitnessGoals)&&(identical(other.activityLevel, activityLevel) || other.activityLevel == activityLevel)&&(identical(other.diet, diet) || other.diet == diet)&&const DeepCollectionEquality().equals(other._injuries, _injuries)&&const DeepCollectionEquality().equals(other._healthConditions, _healthConditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,gender,birthDate,heightCm,weightKg,const DeepCollectionEquality().hash(_fitnessGoals),activityLevel,diet,const DeepCollectionEquality().hash(_injuries),const DeepCollectionEquality().hash(_healthConditions));

@override
String toString() {
  return 'OnboardingFormModel(name: $name, gender: $gender, birthDate: $birthDate, heightCm: $heightCm, weightKg: $weightKg, fitnessGoals: $fitnessGoals, activityLevel: $activityLevel, diet: $diet, injuries: $injuries, healthConditions: $healthConditions)';
}


}

/// @nodoc
abstract mixin class _$OnboardingFormModelCopyWith<$Res> implements $OnboardingFormModelCopyWith<$Res> {
  factory _$OnboardingFormModelCopyWith(_OnboardingFormModel value, $Res Function(_OnboardingFormModel) _then) = __$OnboardingFormModelCopyWithImpl;
@override @useResult
$Res call({
 String? name, Gender? gender,@JsonKey(toJson: _dateTimeToIsoStringNullable, fromJson: _dateTimeFromIsoStringNullable) DateTime? birthDate, double? heightCm, double? weightKg, List<FitnessGoal> fitnessGoals, ActivityLevel? activityLevel, String? diet, List<Injury> injuries, List<HealthCondition> healthConditions
});




}
/// @nodoc
class __$OnboardingFormModelCopyWithImpl<$Res>
    implements _$OnboardingFormModelCopyWith<$Res> {
  __$OnboardingFormModelCopyWithImpl(this._self, this._then);

  final _OnboardingFormModel _self;
  final $Res Function(_OnboardingFormModel) _then;

/// Create a copy of OnboardingFormModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? gender = freezed,Object? birthDate = freezed,Object? heightCm = freezed,Object? weightKg = freezed,Object? fitnessGoals = null,Object? activityLevel = freezed,Object? diet = freezed,Object? injuries = null,Object? healthConditions = null,}) {
  return _then(_OnboardingFormModel(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,fitnessGoals: null == fitnessGoals ? _self._fitnessGoals : fitnessGoals // ignore: cast_nullable_to_non_nullable
as List<FitnessGoal>,activityLevel: freezed == activityLevel ? _self.activityLevel : activityLevel // ignore: cast_nullable_to_non_nullable
as ActivityLevel?,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as String?,injuries: null == injuries ? _self._injuries : injuries // ignore: cast_nullable_to_non_nullable
as List<Injury>,healthConditions: null == healthConditions ? _self._healthConditions : healthConditions // ignore: cast_nullable_to_non_nullable
as List<HealthCondition>,
  ));
}


}

// dart format on
