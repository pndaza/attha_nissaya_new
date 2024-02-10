// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nsybook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NsyBook {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get gotoPage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NsyBookCopyWith<NsyBook> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NsyBookCopyWith<$Res> {
  factory $NsyBookCopyWith(NsyBook value, $Res Function(NsyBook) then) =
      _$NsyBookCopyWithImpl<$Res, NsyBook>;
  @useResult
  $Res call({String id, String name, int gotoPage});
}

/// @nodoc
class _$NsyBookCopyWithImpl<$Res, $Val extends NsyBook>
    implements $NsyBookCopyWith<$Res> {
  _$NsyBookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gotoPage = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gotoPage: null == gotoPage
          ? _value.gotoPage
          : gotoPage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NsyBookCopyWith<$Res> implements $NsyBookCopyWith<$Res> {
  factory _$$_NsyBookCopyWith(
          _$_NsyBook value, $Res Function(_$_NsyBook) then) =
      __$$_NsyBookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int gotoPage});
}

/// @nodoc
class __$$_NsyBookCopyWithImpl<$Res>
    extends _$NsyBookCopyWithImpl<$Res, _$_NsyBook>
    implements _$$_NsyBookCopyWith<$Res> {
  __$$_NsyBookCopyWithImpl(_$_NsyBook _value, $Res Function(_$_NsyBook) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gotoPage = null,
  }) {
    return _then(_$_NsyBook(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gotoPage: null == gotoPage
          ? _value.gotoPage
          : gotoPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_NsyBook implements _NsyBook {
  _$_NsyBook({required this.id, required this.name, required this.gotoPage});

  @override
  final String id;
  @override
  final String name;
  @override
  final int gotoPage;

  @override
  String toString() {
    return 'NsyBook(id: $id, name: $name, gotoPage: $gotoPage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NsyBook &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gotoPage, gotoPage) ||
                other.gotoPage == gotoPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, gotoPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NsyBookCopyWith<_$_NsyBook> get copyWith =>
      __$$_NsyBookCopyWithImpl<_$_NsyBook>(this, _$identity);
}

abstract class _NsyBook implements NsyBook {
  factory _NsyBook(
      {required final String id,
      required final String name,
      required final int gotoPage}) = _$_NsyBook;

  @override
  String get id;
  @override
  String get name;
  @override
  int get gotoPage;
  @override
  @JsonKey(ignore: true)
  _$$_NsyBookCopyWith<_$_NsyBook> get copyWith =>
      throw _privateConstructorUsedError;
}
