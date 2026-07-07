.PHONY: get gen run analyze test clean

get:
	fvm flutter pub get

gen:
	fvm dart run build_runner build --delete-conflicting-outputs

run:
	fvm flutter run -d "iPhone 17 Pro"

analyze:
	fvm flutter analyze

test:
	fvm flutter test

clean:
	fvm flutter clean && fvm flutter pub get

setup: get gen
