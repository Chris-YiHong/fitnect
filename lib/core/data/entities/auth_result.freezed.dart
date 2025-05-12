// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthResult {

 Credentials get credentials; bool get isNewUser; UserEntity? get userEntity;
/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResultCopyWith<AuthResult> get copyWith => _$AuthResultCopyWithImpl<AuthResult>(this as AuthResult, _$identity);

  /// Serializes this AuthResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResult&&(identical(other.credentials, credentials) || other.credentials == credentials)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.userEntity, userEntity) || other.userEntity == userEntity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,credentials,isNewUser,userEntity);

@override
String toString() {
  return 'AuthResult(credentials: $credentials, isNewUser: $isNewUser, userEntity: $userEntity)';
}


}

/// @nodoc
abstract mixin class $AuthResultCopyWith<$Res>  {
  factory $AuthResultCopyWith(AuthResult value, $Res Function(AuthResult) _then) = _$AuthResultCopyWithImpl;
@useResult
$Res call({
 Credentials credentials, bool isNewUser, UserEntity? userEntity
});


$UserEntityCopyWith<$Res>? get userEntity;

}
/// @nodoc
class _$AuthResultCopyWithImpl<$Res>
    implements $AuthResultCopyWith<$Res> {
  _$AuthResultCopyWithImpl(this._self, this._then);

  final AuthResult _self;
  final $Res Function(AuthResult) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? credentials = null,Object? isNewUser = null,Object? userEntity = freezed,}) {
  return _then(_self.copyWith(
credentials: null == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as Credentials,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,userEntity: freezed == userEntity ? _self.userEntity : userEntity // ignore: cast_nullable_to_non_nullable
as UserEntity?,
  ));
}
/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get userEntity {
    if (_self.userEntity == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.userEntity!, (value) {
    return _then(_self.copyWith(userEntity: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _AuthResult extends AuthResult {
  const _AuthResult({required this.credentials, required this.isNewUser, this.userEntity}): super._();
  factory _AuthResult.fromJson(Map<String, dynamic> json) => _$AuthResultFromJson(json);

@override final  Credentials credentials;
@override final  bool isNewUser;
@override final  UserEntity? userEntity;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResultCopyWith<_AuthResult> get copyWith => __$AuthResultCopyWithImpl<_AuthResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResult&&(identical(other.credentials, credentials) || other.credentials == credentials)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.userEntity, userEntity) || other.userEntity == userEntity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,credentials,isNewUser,userEntity);

@override
String toString() {
  return 'AuthResult(credentials: $credentials, isNewUser: $isNewUser, userEntity: $userEntity)';
}


}

/// @nodoc
abstract mixin class _$AuthResultCopyWith<$Res> implements $AuthResultCopyWith<$Res> {
  factory _$AuthResultCopyWith(_AuthResult value, $Res Function(_AuthResult) _then) = __$AuthResultCopyWithImpl;
@override @useResult
$Res call({
 Credentials credentials, bool isNewUser, UserEntity? userEntity
});


@override $UserEntityCopyWith<$Res>? get userEntity;

}
/// @nodoc
class __$AuthResultCopyWithImpl<$Res>
    implements _$AuthResultCopyWith<$Res> {
  __$AuthResultCopyWithImpl(this._self, this._then);

  final _AuthResult _self;
  final $Res Function(_AuthResult) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? credentials = null,Object? isNewUser = null,Object? userEntity = freezed,}) {
  return _then(_AuthResult(
credentials: null == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as Credentials,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,userEntity: freezed == userEntity ? _self.userEntity : userEntity // ignore: cast_nullable_to_non_nullable
as UserEntity?,
  ));
}

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get userEntity {
    if (_self.userEntity == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.userEntity!, (value) {
    return _then(_self.copyWith(userEntity: value));
  });
}
}

// dart format on
