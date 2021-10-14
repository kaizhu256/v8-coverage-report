
# this zero-dependency package will create coverage-reports directly from raw v8-coverage-files

# Status
| Branch | [master<br>(v1000.1.1)](https://github.com/kaizhu256/v8-coverage-report/tree/master) | [beta<br>(Web Demo)](https://github.com/kaizhu256/v8-coverage-report/tree/beta) | [alpha<br>(Development)](https://github.com/kaizhu256/v8-coverage-report/tree/alpha) |
|--:|:--:|:--:|:--:|
| CI | [![ci](https://github.com/kaizhu256/v8-coverage-report/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/kaizhu256/v8-coverage-report/actions?query=branch%3Amaster) | [![ci](https://github.com/kaizhu256/v8-coverage-report/actions/workflows/ci.yml/badge.svg?branch=beta)](https://github.com/kaizhu256/v8-coverage-report/actions?query=branch%3Abeta) | [![ci](https://github.com/kaizhu256/v8-coverage-report/actions/workflows/ci.yml/badge.svg?branch=alpha)](https://github.com/kaizhu256/v8-coverage-report/actions?query=branch%3Aalpha) |
| Coverage | [![coverage](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage/coverage_badge.svg)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage/index.html) | [![coverage](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage/coverage_badge.svg)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage/index.html) | [![coverage](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage/coverage_badge.svg)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage/index.html) |
| Artifacts | [<img src="asset_image_folder_open_solid.svg" height="30">](https://github.com/kaizhu256/v8-coverage-report/tree/gh-pages/branch-master/.artifact) | [<img src="asset_image_folder_open_solid.svg" height="30">](https://github.com/kaizhu256/v8-coverage-report/tree/gh-pages/branch-master/.artifact) | [<img src="asset_image_folder_open_solid.svg" height="30">](https://github.com/kaizhu256/v8-coverage-report/tree/gh-pages/branch-master/.artifact) |


# Table of Contents

1. [API Doc](#api-doc)

2. [Quickstart Install](#quickstart-install)
    - [To install, run npm install:](#to-install-run-npm-install)

3. [Quickstart V8 Coverage Report](#quickstart-v8-coverage-report)
    - [To create V8 coverage report from Node.js / Npm program in shell:](#to-create-v8-coverage-report-from-nodejs--npm-program-in-shell)
    - [To create V8 coverage report from Node.js / Npm program in javascript:](#to-create-v8-coverage-report-from-nodejs--npm-program-in-javascript)

4. [Package Listing](#package-listing)

5. [Changelog](#changelog)

6. [License](#license)


# API Doc
- https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/apidoc.html

[![screenshot](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_browser__2f.artifact_2fapidoc.html.png)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/apidoc.html)


# Quickstart Install
### To install, run npm install:
```shell
#!/bin/sh

npm install v8-coverage-report
```


# Quickstart V8 Coverage Report
### To create V8 coverage report from Node.js / Npm program in shell:
```shell <!-- shRunWithScreenshotTxt .artifact/screenshot_sh_coverage_report_spawn.svg -->
#!/bin/sh

git clone https://github.com/mapbox/node-sqlite3 node-sqlite3-sh \
    --branch=v5.0.2 \
    --depth=1 \
    --single-branch

cd node-sqlite3-sh
npm install

# Create V8 coverage report from program `npm run test` in shell.

v8-coverage-report \
    v8_coverage_report=../.artifact/coverage_sqlite3_sh/ \
    npm run test
```
- screenshot file [.artifact/coverage_sqlite3_sh/index.html](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_sh/index.html)

[![screenshot.png](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_browser__2f.artifact_2fcoverage_sqlite3_sh_2findex.html.png)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_sh/index.html)

- screenshot file [.artifact/coverage_sqlite3_sh/lib/sqlite3.js.html](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_sh/lib/sqlite3.js.html)

[![screenshot.png](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_browser__2f.artifact_2fcoverage_sqlite3_sh_2flib_2fsqlite3.js.html.png)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_sh/lib/sqlite3.js.html)

- shell output

![screenshot.svg](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_sh_coverage_report_spawn.svg)

### To create V8 coverage report from Node.js / Npm program in javascript:
```shell <!-- shRunWithScreenshotTxt .artifact/screenshot_js_coverage_report_spawn.svg -->
#!/bin/sh

git clone https://github.com/mapbox/node-sqlite3 node-sqlite3-js \
    --branch=v5.0.2 \
    --depth=1 \
    --single-branch

cd node-sqlite3-js
npm install

node --input-type=module -e '

/*jslint node*/
import v8_coverage_report from "v8_coverage_report";
(async function () {

// Create V8 coverage report from program `npm run test` in javascript.

    await v8_coverage_report.v8CoverageReportCreate({
        coverageDir: "../.artifact/coverage_sqlite3_js/",
        processArgv: ["npm", "run", "test"]
    });
}());

'
```
- screenshot file [.artifact/coverage_sqlite3_js/index.html](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_js/index.html)

[![screenshot.png](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_browser__2f.artifact_2fcoverage_sqlite3_js_2findex.html.png)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_js/index.html)

- screenshot file [.artifact/coverage_sqlite3_js/lib/sqlite3.js.html](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_js/lib/sqlite3.js.html)

[![screenshot.png](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_browser__2f.artifact_2fcoverage_sqlite3_js_2flib_2fsqlite3.js.html.png)](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/coverage_sqlite3_js/lib/sqlite3.js.html)

- shell output

![screenshot.svg](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_js_coverage_report_spawn.svg)


# Package Listing
![screenshot_package_listing.svg](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_package_listing.svg)


# Changelog
- [Full CHANGELOG.md](CHANGELOG.md)

![screenshot_changelog.svg](https://kaizhu256.github.io/v8-coverage-report/branch-master/.artifact/screenshot_changelog.svg)


# License
- v8-coverage-report is under [Unlicense License](LICENSE).
- Function `v8CoverageListMerge` is derived from [MIT Licensed v8-coverage](https://github.com/demurgos/v8-coverage/blob/73446087dc38f61b09832c9867122a23f8577099/ts/LICENSE.md).
