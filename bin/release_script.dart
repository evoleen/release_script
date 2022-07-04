import 'package:args/args.dart';
import 'package:release_script/scr/release_flow.dart';
import 'package:release_script/scr/release_type.dart';

void main(List<String> args) {
  final parser = ArgParser();

  final releaseTypeNames =
      ReleaseType.values.map((enumValue) => enumValue.name).toList();
  parser.addOption('type',
      abbr: 't',
      allowed: releaseTypeNames,
      mandatory: true,
      help: "Versioning configuration");

  try {
    final results = parser.parse(args);
    final releaseType = ReleaseType.valueOf(results['type']);
    final releaseFlow = ReleaseFlow(releaseType);

    releaseFlow.updateVersion();
  } catch (e) {
    print(e);
  }
}
