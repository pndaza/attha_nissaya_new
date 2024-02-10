// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Recent {
  String get nsyId => throw _privateConstructorUsedError;
  String get nsyName => throw _privateConstructorUsedError;
  int get nsyPageNumber => throw _privateConstructorUsedError;
  String get paliName => throw _privateConstructorUsedError;
  int get paliPageNumber => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecentCopyWith<Recent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentCopyWith<$Res> {
  factory $RecentCopyWith(Recent value, $Res Function(Recent) then) =
      _$RecentCopyWithImpl<$Res, Recent>;
  @useResult
  $Res call(
      {String nsyId,
      String nsyName,
      int nsyPageNumber,
      String paliName,
      int paliPageNumber,
      DateTime dateTime});
}

/// @nodoc
class _$RecentCopyWithImpl<$Res, $Val extends Recent>
    implements $RecentCopyWith<$Res> {
  _$RecentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nsyId = null,
    Object? nsyName = null,
    Object? nsyPageNumber = null,
    Object? paliName = null,
    Object? paliPageNumber = null,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      nsyId: null == nsyId
          ? _value.nsyId
          : nsyId // ignore: cast_nullable_to_non_nullable
              as String,
      nsyName: null == nsyName
          ? _value.nsyName
          : nsyName // ignore: cast_nullable_to_non_nullable
              as String,
      nsyPageNumber: null == nsyPageNumber
          ? _value.nsyPageNumber
          : nsyPageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      paliName: null == paliName
          ? _value.paliName
          : paliName // ignore: cast_nullable_to_non_nullable
              as String,
      paliPageNumber: null == paliPageNumber
          ? _value.paliPageNumber
          : paliPageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecentCopyWith<$Res> implements $RecentCopyWith<$Res> {
  factory _$$_RecentCopyWith(_$_Recent value, $Res Function(_$_Recent) then) =
      __$$_RecentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nsyId,
      String nsyName,
      int nsyPageNumber,
      String paliName,
      int paliPageNumber,
      DateTime dateTime});
}

/// @nodoc
class __$$_RecentCopyWithImpl<$Res>
    extends _$RecentCopyWithImpl<$Res, _$_Recent>
    implements _$$_RecentCopyWith<$Res> {
  __$$_RecentCopyWithImpl(_$_Recent _value, $Res Function(_$_Recent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nsyId = null,
    Object? nsyName = null,
    Object? nsyPageNumber = null,
    Object? paliName = null,
    Object? paliPageNumber = null,
    Object? dateTime = null,
  }) {
    return _then(_$_Recent(
      nsyId: null == nsyId
          ? _value.nsyId
          : nsyId // ignore: cast_nullable_to_non_nullable
              as String,
      nsyName: null == nsyName
          ? _value.nsyName
          : nsyName // ignore: cast_nullable_to_non_nullable
              as String,
      nsyPageNumber: null == nsyPageNumber
          ? _value.nsyPageNumber
          : nsyPageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      paliName: null == paliName
          ? _value.paliName
          : paliName // ignore: cast_nullable_to_non_nullable
              as String,
      paliPageNumber: null == paliPageNumber
          ? _value.paliPageNumber
          : paliPageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_Recent implements _Recent {
  const _$_Recent(
      {required this.nsyId,
      required this.nsyName,
      required this.nsyPageNumber,
      required this.paliName,
      required this.paliPageNumber,
      required this.dateTime});

  @override
  final String nsyId;
  @override
  final String nsyName;
  @override
  final int nsyPageNumber;
  @override
  final String paliName;
  @override
  final int paliPageNumber;
  @override
  final DateTime dateTime;

  @override
  String toString() {
    return 'Recent(nsyId: $nsyId, nsyName: $nsyName, nsyPageNumber: $nsyPageNumber, paliName: $paliName, paliPageNumber: $paliPageNumber, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Recent &&
            (identical(other.nsyId, nsyId) || other.nsyId == nsyId) &&
            (identical(other.nsyName, nsyName) || other.nsyName == nsyName) &&
            (identical(other.nsyPageNumber, nsyPageNumber) ||
                other.nsyPageNumber == nsyPageNumber) &&
            (identical(other.paliName, paliName) ||
                other.paliName == paliName) &&
            (identical(other.paliPageNumber, paliPageNumber) ||
                other.paliPageNumber == paliPageNumber) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nsyId, nsyName, nsyPageNumber,
      paliName, paliPageNumber, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecentCopyWith<_$_Recent> get copyWith =>
      __$$_RecentCopyWithImpl<_$_Recent>(this, _$identity);
}

abstract class _Recent implements Recent {
  const factory _Recent(
      {required final String nsyId,
      required final String nsyName,
      required final int nsyPageNumber,
      required final String paliName,
      required final int paliPageNumber,
      required final DateTime dateTime}) = _$_Recent;

  @override
  String get nsyId;
  @override
  String get nsyName;
  @override
  int get nsyPageNumber;
  @override
  String get paliName;
  @override
  int get paliPageNumber;
  @override
  DateTime get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$_RecentCopyWith<_$_Recent> get copyWith =>
      throw _privateConstructorUsedError;
}
