# Release script

An internal tool for releasing dart apps

## Usage

```bash
flutter pub run release_script -t beta -v patch
```

## Flags description

| Flag       | Description                | Usage              | Options                                        | 
| ---------- | -------------------------- | ------------------ | ---------------------------------------------- |
| type       | Release type configuration | `-t` or `-type`    | `beta`, `release`                              |
| version    | Versioning configuration   | `-v` or `-version` | `patch`, `minor`, `major`, `breaking`, `build` |

#### Types

* **beta** - pushes tag in format `BETA-1.0.12+207`
* **release** - pushes tag in format `RELEASE-1.0.12+207`

#### Versions

* **patch** - If this version is a pre-release, then it just strips the pre-release suffix. Otherwise, it increments the patch version.
* **minor** - If this version is a pre-release of a minor version release (i.e. the patch version is zero), then it just strips the pre-release suffix. Otherwise, it increments the minor version and resets the patch.
* **major** - if this version is a pre-release of a major version release (i.e. the minor and patch versions are zero), then it just strips the pre-release suffix. Otherwise, it increments the major version and resets the minor and patch.
* **breaking** - Increments *major* if it's greater than zero, otherwise *minor*, resets subsequent digits to zero, and strips any *preRelease* or *build* suffix.
* **build** - Increments *build* number. The version remains unchanged.
