//
// Contributors @vasbaz
// Copyright from Evoleen 2022
//

import 'package:args/args.dart';
import 'package:release_script/src/enums/release_type.dart';
import 'package:release_script/src/enums/release_version.dart';
import 'package:release_script/src/release_flow.dart';

void main(List<String> args) {
  final parser = ArgParser();

  final releaseTypesNames =
      ReleaseType.values.map((enumValue) => enumValue.name).toList();
  parser.addOption('type',
      abbr: 't',
      allowed: releaseTypesNames,
      mandatory: true,
      help: "Release type configuration");

  final releaseVersionNames =
      ReleaseVersion.values.map((enumValue) => enumValue.name).toList();
  parser.addOption('version',
      abbr: 'v',
      allowed: releaseVersionNames,
      mandatory: true,
      help: "Versioning configuration");

  try {
    final results = parser.parse(args);
    final releaseType = ReleaseType.valueOf(results['type']);
    final releaseVersion = ReleaseVersion.valueOf(results['version']);
    final releaseFlow =
        ReleaseFlow(releaseVersion: releaseVersion, releaseType: releaseType);
    releaseFlow.proceed();
  } catch (e) {
    print(e);
  }
}
