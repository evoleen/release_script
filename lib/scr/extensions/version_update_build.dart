import 'package:pub_semver/pub_semver.dart';

extension VersionNextBuild on Version {
  Version get nextBuild {
    var updatedBuild = 0;

    if (build.isNotEmpty) {
      updatedBuild = build[0] + 1;
    }

    return Version(major, minor, patch, build: updatedBuild.toString());
  }
}
