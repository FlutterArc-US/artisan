const gitHubWorkflowFile = '''
name: Flutter_Tests

on:
  push:
    branches: [main]

jobs:
  tests:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: "stable"
          flutter-version: "3.19.2"

      - name: Install dependencies
        run: flutter pub get

      - name: Run build_runner
        run: flutter pub run build_runner build --delete-conflicting-outputs

      - name: Increment version number
        id: increment_version
        run: |
          current_version=\$(grep 'version:' pubspec.yaml | cut -d ' ' -f 2)
          version_code=\$(echo \$current_version | cut -d '+' -f 2)
          version_name=\$(echo \$current_version | cut -d '+' -f 1)

          IFS='.' read -ra VERSION_PARTS <<< "\$version_name"
          patch=\${VERSION_PARTS[2]}
          patch=\$((patch+1))

          new_version="\${VERSION_PARTS[0]}.\${VERSION_PARTS[1]}.\$patch"
          new_version_code=\$((version_code+1))

          sed -i "s/version: .*/version: \$new_version+\$new_version_code/" pubspec.yaml

          echo "New version: \$new_version+\$new_version_code"

      - name: Commit version bump
        run: |
          git config --local user.email "actions@github.com"
          git config --local user.name "GitHub Actions"
          git add pubspec.yaml
          git commit -m "ci: Bump version to \${{ steps.increment_version.outputs.new_version }}"
          git push

      - name: Build APK
        run: flutter build apk --release

      - name: Upload APK to Firebase App Distribution
        uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: \${{ secrets.FIREBASE_APP_ID }}
          serviceCredentialsFileContent: \${{ secrets.CREDENTIAL_FILE_CONTENT }}
          groups: testers
          file: build/app/outputs/flutter-apk/app-release.apk
          
''';