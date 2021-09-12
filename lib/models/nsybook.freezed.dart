// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'nsybook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NsyBookTearOff {
  const _$NsyBookTearOff();

  _NsyBook call(
      {required String id, required String name, required int gotoPage}) {
    return _NsyBook(
      id: id,
      name: name,
      gotoPage: gotoPage,
    );
  }
}

/// @nodoc
const $NsyBook = _$NsyBookTearOff();

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
      _$NsyBookCopyWithImpl<$Res>;
  $Res call({String id, String name, int gotoPage});
}

/// @nodoc
class _$NsyBookCopyWithImpl<$Res> implements $NsyBookCopyWith<$Res> {
  _$NsyBookCopyWithImpl(this._value, this._then);

  final NsyBook _value;
  // ignore: unused_field
  final $Res Function(NsyBook) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? gotoPage = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gotoPage: gotoPage == freezed
          ? _value.gotoPage
          : gotoPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NsyBookCopyWith<$Res> implements $NsyBookCopyWith<$Res> {
  factory _$NsyBookCopyWith(_NsyBook value, $Res Function(_NsyBook) then) =
      __$NsyBookCopyWithImpl<$Res>;
  @override
  $Res call({String id, String name, int gotoPage});
}

/// @nodoc
class __$NsyBookCopyWithImpl<$Res> extends _$NsyBookCopyWithImpl<$Res>
    implements _$NsyBookCopyWith<$Res> {
  __$NsyBookCopyWithImpl(_NsyBook _value, $Res Function(_NsyBook) _then)
      : super(_value, (v) => _then(v as _NsyBook));

  @override
  _NsyBook get _value => super._value as _NsyBook;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? gotoPage = freezed,
  }) {
    return _then(_NsyBook(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gotoPage: gotoPage == freezed
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
        (other is _NsyBook &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.gotoPage, gotoPage) ||
                const DeepCollectionEquality()
                    .equals(other.gotoPage, gotoPage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(gotoPage);

  @JsonKey(ignore: true)
  @override
  _$NsyBookCopyWith<_NsyBook> get copyWith =>
      __$NsyBookCopyWithImpl<_NsyBook>(this, _$identity);
}

abstract class _NsyBook implements NsyBook {
  factory _NsyBook(
      {required String id,
      required String name,
      required int gotoPage}) = _$_NsyBook;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  int get gotoPage => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NsyBookCopyWith<_NsyBook> get copyWith =>
      throw _privateConstructorUsedError;
}
