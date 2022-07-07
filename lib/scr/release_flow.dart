import 'dart:io';

import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart';

import 'extensions/version_update_build.dart';
import 'enums/release_type.dart';
import 'enums/release_version.dart';

class ReleaseFlow {
  final ReleaseVersion releaseVersion;
  final ReleaseType releaseType;

  ReleaseFlow({required this.releaseType, required this.releaseVersion});

  void proceed() {
    final tagStdOut = getGitTagStdOut();
    final lastVersion = getLastVersionFromTagStgOut(tagStdOut);
    final updatedVersion = getUpdatedVersion(lastVersion);
    createGitTag(updatedVersion);
    pushGitTags();

    print("Release flow completed");
  }

  @protected
  String getGitTagStdOut() {
    final tagResult = Process.runSync('git', ['tag', '--list']);
    if (tagResult.exitCode != 0) {
      print(tagResult.stderr);
      throw Exception("Can't retreive tag list from git");
    }

    print("Got git tag list");
    return tagResult.stdout as String;
  }

  @protected
  Version getLastVersionFromTagStgOut(String tagStgOut) => tagStgOut
      .split('\n')
      .map((str) => str.toLowerCase())
      .where((str) =>
          str.startsWith(ReleaseType.beta.name) ||
          str.startsWith(ReleaseType.release.name))
      .map(versionMapper)
      .reduce((lhs, rhs) => lhs > rhs ? lhs : rhs);

  @protected
  Version Function(String) get versionMapper => (String str) {
        if (str.isEmpty) {
          return Version.none;
        }

        final tagWithoutStage = str.substring(str.indexOf(RegExp(r'[-_]')) + 1);
        return Version.parse(tagWithoutStage);
      };

  @protected
  Version getUpdatedVersion(Version oldVersion) {
    switch (releaseVersion) {
      case ReleaseVersion.patch:
        return oldVersion.nextPatch.nextBuild;
      case ReleaseVersion.minor:
        return oldVersion.nextMinor.nextBuild;
      case ReleaseVersion.major:
        return oldVersion.nextMajor.nextBuild;
      case ReleaseVersion.breaking:
        return oldVersion.nextBreaking.nextBuild;
      case ReleaseVersion.build:
        return oldVersion.nextBuild;
    }

    throw Exception(
        'ReleaseFlow is constructed with an unknown ReleaseVersion');
  }

  @protected
  void createGitTag(Version newVersion) {
    final newTag = '${releaseType.name}-$newVersion';
    print('New tag will be $newTag');

    final createResult = Process.runSync('git', ['tag', newTag]);
    if (createResult.exitCode != 0) {
      print(createResult.stderr);
      throw Exception("Can't create $newTag tag");
    }

    print('Tag $newTag created');
  }

  @protected
  void pushGitTags() {
    final pushResult = Process.runSync('git', ['push', '--tags']);
    if (pushResult.exitCode != 0) {
      print(pushResult.stderr);
      throw Exception("Can't push tags");
    }

    print('Tags pushed');
  }
}
