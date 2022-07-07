import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'release_version.g.dart';

class ReleaseVersion extends EnumClass {
  static const ReleaseVersion patch = _$patch;
  static const ReleaseVersion minor = _$minor;
  static const ReleaseVersion major = _$major;
  static const ReleaseVersion breaking = _$breaking;
  static const ReleaseVersion build = _$build;

  const ReleaseVersion._(String name) : super(name);

  static BuiltSet<ReleaseVersion> get values => _$values;
  static ReleaseVersion valueOf(String name) => _$valueOf(name);
}
