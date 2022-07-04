import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'release_type.g.dart';

class ReleaseType extends EnumClass {

  static const ReleaseType patch = _$patch;
  static const ReleaseType minor = _$minor;
  static const ReleaseType major = _$major;

  const ReleaseType._(String name) : super(name);

  static BuiltSet<ReleaseType> get values => _$values;
  static ReleaseType valueOf(String name) => _$valueOf(name);
}
