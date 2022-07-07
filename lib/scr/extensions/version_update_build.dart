import 'package:pub_semver/pub_semver.dart';

extension VersionNextBuild on Version {
  Version get nextBuild =>
      Version(major, minor, patch, build: (build[0] + 1).toString());
}
