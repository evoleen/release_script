import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'release_type.dart';
import 'package:path/path.dart' as p;

import 'version.dart';

class ReleaseFlow {
  static const pubspecFileName = "pubspec.yaml";

  final ReleaseType releaseType;

  ReleaseFlow(this.releaseType);

  void updateVersion() {
    final pubspecPath = p.join(Directory.current.path, pubspecFileName);
    final pubspecFile = File(pubspecPath);
    final pubspecContent = pubspecFile.readAsStringSync();

    final pubspecYamlReader = loadYaml(pubspecContent);
    final version = Version.fromString(pubspecYamlReader['version']);

    switch (releaseType) {
      case ReleaseType.patch:
        version.upPatch();
        break;
      case ReleaseType.minor:
        version.upMinor();
        break;
      case ReleaseType.major:
        version.upMajor();
        break;
    }

    final pubspecYamlEditor = YamlEditor(pubspecContent);
    pubspecYamlEditor.update(['version'], version.toString());

    pubspecFile.writeAsStringSync(pubspecYamlEditor.toString());
  }
}
