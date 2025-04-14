// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_scaffold_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppScaffoldUser _$AppScaffoldUserFromJson(Map<String, dynamic> json) {
  return _AppScaffoldUser.fromJson(json);
}

/// @nodoc
mixin _$AppScaffoldUser {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get authenticated => throw _privateConstructorUsedError;

  /// Serializes this AppScaffoldUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppScaffoldUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppScaffoldUserCopyWith<AppScaffoldUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppScaffoldUserCopyWith<$Res> {
  factory $AppScaffoldUserCopyWith(
          AppScaffoldUser value, $Res Function(AppScaffoldUser) then) =
      _$AppScaffoldUserCopyWithImpl<$Res, AppScaffoldUser>;
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String email,
      bool authenticated});
}

/// @nodoc
class _$AppScaffoldUserCopyWithImpl<$Res, $Val extends AppScaffoldUser>
    implements $AppScaffoldUserCopyWith<$Res> {
  _$AppScaffoldUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppScaffoldUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? authenticated = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      authenticated: null == authenticated
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppScaffoldUserImplCopyWith<$Res>
    implements $AppScaffoldUserCopyWith<$Res> {
  factory _$$AppScaffoldUserImplCopyWith(_$AppScaffoldUserImpl value,
          $Res Function(_$AppScaffoldUserImpl) then) =
      __$$AppScaffoldUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String email,
      bool authenticated});
}

/// @nodoc
class __$$AppScaffoldUserImplCopyWithImpl<$Res>
    extends _$AppScaffoldUserCopyWithImpl<$Res, _$AppScaffoldUserImpl>
    implements _$$AppScaffoldUserImplCopyWith<$Res> {
  __$$AppScaffoldUserImplCopyWithImpl(
      _$AppScaffoldUserImpl _value, $Res Function(_$AppScaffoldUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppScaffoldUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? authenticated = null,
  }) {
    return _then(_$AppScaffoldUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      authenticated: null == authenticated
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppScaffoldUserImpl extends _AppScaffoldUser {
  const _$AppScaffoldUserImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.authenticated})
      : super._();

  factory _$AppScaffoldUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppScaffoldUserImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final bool authenticated;

  @override
  String toString() {
    return 'AppScaffoldUser(id: $id, firstName: $firstName, lastName: $lastName, email: $email, authenticated: $authenticated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppScaffoldUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.authenticated, authenticated) ||
                other.authenticated == authenticated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, firstName, lastName, email, authenticated);

  /// Create a copy of AppScaffoldUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppScaffoldUserImplCopyWith<_$AppScaffoldUserImpl> get copyWith =>
      __$$AppScaffoldUserImplCopyWithImpl<_$AppScaffoldUserImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppScaffoldUserImplToJson(
      this,
    );
  }
}

abstract class _AppScaffoldUser extends AppScaffoldUser {
  const factory _AppScaffoldUser(
      {required final String id,
      required final String firstName,
      required final String lastName,
      required final String email,
      required final bool authenticated}) = _$AppScaffoldUserImpl;
  const _AppScaffoldUser._() : super._();

  factory _AppScaffoldUser.fromJson(Map<String, dynamic> json) =
      _$AppScaffoldUserImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  bool get authenticated;

  /// Create a copy of AppScaffoldUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppScaffoldUserImplCopyWith<_$AppScaffoldUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
