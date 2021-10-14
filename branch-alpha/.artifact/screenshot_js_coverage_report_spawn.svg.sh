(set -e
printf '> #!/bin/sh
> npm install v8-coverage-report
> 
> git clone https://github.com/mapbox/node-sqlite3 node-sqlite3-js \\
>     --branch=v5.0.2 \\
>     --depth=1 \\
>     --single-branch
> 
> cd node-sqlite3-js
> npm install
> 
> node --input-type=module -e '"'"'
> 
> /*jslint node*/
> import v8_coverage_report from "v8_coverage_report";
> (async function () {
> 
> // Create V8 coverage report from program `npm run test` in javascript.
> 
>     await v8_coverage_report.v8CoverageReportCreate({
>         coverageDir: "../.artifact/coverage_sqlite3_js/",
>         processArgv: ["npm", "run", "test"]
>     });
> }());
> 
> '"'"'


'
#!/bin/sh
mkdir -p node_modules && ln -s "$PWD" node_modules || true


git clone https://github.com/mapbox/node-sqlite3 node-sqlite3-js \
    --branch=v5.0.2 \
    --depth=1 \
    --single-branch 2>/dev/null || true


cd node-sqlite3-js

git checkout 60a022c511a37788e652c271af23174566a80c30
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

' 2>&1 | head -n 100
)
