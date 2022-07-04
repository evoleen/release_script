class Version {
  late int major;
  late int minor;
  late int patch;

  Version._(this.major, this.minor, this.patch);

  factory Version.fromString(String versionString) {
    final versionList = versionString.split(".").map(int.parse).toList();

    if (versionList.length != 3) {
      throw Exception("Invalid version in the pubspec");
    }

    final major = versionList[0];
    final minor = versionList[1];
    final patch = versionList[2];

    return Version._(major, minor, patch);
  }

  void upMajor() {
    major += 1;
  }

  void upMinor() {
    minor += 1;
  }

  void upPatch() {
    patch += 1;
  }

  @override
  String toString() => "$major.$minor.$patch";
}
