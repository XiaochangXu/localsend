# UNCOMMENT THESE LINES TO BUILD FROM LATEST COMMIT
# git reset --hard origin/main
# git pull

cd app
fvm flutter clean
fvm flutter pub get
fvm flutter build macos --obfuscate --split-debug-info=build/symbols
cd ..