import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'release_type.g.dart';

class ReleaseType extends EnumClass {

  static const ReleaseType beta = _$beta;
  static const ReleaseType release = _$release;

  const ReleaseType._(String name) : super(name);

  static BuiltSet<ReleaseType> get values => _$values;
  static ReleaseType valueOf(String name) => _$valueOf(name);
}
