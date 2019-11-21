run:
	dart ./index.dart

run_js:
	make build
	node ./dist/index.js

build:
	rm -rf ./dist
	mkdir ./dist
	dart2js ./index.dart -O0 -o ./dist/index.js
	cp ./static/* ./dist

release:
	rm -rf ./dist
	mkdir ./dist
	dart2js ./index.dart -O4 -o ./dist/index.js
	cp ./static/* ./dist
