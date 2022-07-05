import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'release_type.dart';
import 'package:path/path.dart' as p;

class ReleaseFlow {
  static const pubspecFileName = "pubspec.yaml";

  final ReleaseType releaseType;

  ReleaseFlow(this.releaseType);

  void updateVersion() {
    final pubspecPath = p.join(Directory.current.path, pubspecFileName);
    final pubspecFile = File(pubspecPath);
    final pubspecContent = pubspecFile.readAsStringSync();

    final pubspecYamlReader = loadYaml(pubspecContent);
    var version = Version.parse(pubspecYamlReader['version']);

    switch (releaseType) {
      case ReleaseType.patch:
        version = version.nextPatch;
        break;
      case ReleaseType.minor:
        version = version.nextMinor;
        break;
      case ReleaseType.major:
        version = version.nextMajor;
        break;
      case ReleaseType.breaking:
        version = version.nextBreaking;
        break;
    }

    final pubspecYamlEditor = YamlEditor(pubspecContent);
    pubspecYamlEditor.update(['version'], version.toString());

    pubspecFile.writeAsStringSync(pubspecYamlEditor.toString());
  }
}
