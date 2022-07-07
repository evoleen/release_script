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
