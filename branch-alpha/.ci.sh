shCiArtifactUploadCustom() {(set -e
# this function will custom-upload build-artifacts to branch-gh-pages
    # .cache - restore
    if [ -d .cache ]
    then
        cp -a .cache/* .
        # js-hack - */
    fi
    sed -i.bak -e 's|"name": "v8-coverage-report"|"name": "undefined"|' \
        package.json
    # screenshot quickstart
    node --input-type=module -e '
import moduleFs from "fs";
import moduleChildProcess from "child_process";
(async function () {
    // parallel-task - screenshot example-shell-commands in README.md
    await Promise.all(Array.from(String(
        await moduleFs.promises.readFile("README.md", "utf8")
    ).matchAll(
        /\n```shell <!-- shRunWithScreenshotTxt (.*?) -->\n([\S\s]*?\n)```\n/g
    )).map(async function ([
        ignore, file, script0
    ]) {
        let script = script0;
        // modify script - v8 coverage report
        script = script.replace((
            /\n\ncd node-sqlite3-\w*?\n/g
        ), (
            " 2>/dev/null || true\n"
            + "$&\n"
            + "git checkout 60a022c511a37788e652c271af23174566a80c30\n"
        ));
        // limit stdout to 100 lines
        script = script.trimRight() + " 2>&1 | head -n 100\n";
        // printf script
        script = (
            "(set -e\n"
            + "printf \u0027"
            + script0.trim().replace((
                /[%\\]/gm
            ), "$&$&").replace((
                /\u0027/g
            ), "\u0027\"\u0027\"\u0027").replace((
                /^/gm
            ), "> ")
            + "\n\n\n\u0027\n"
            + script
            + ")\n"
        );
        await moduleFs.promises.writeFile(file + ".sh", script);
        await new Promise(function (resolve) {
            moduleChildProcess.spawn(
                "sh",
                [
                    "jslint_ci.sh", "shRunWithScreenshotTxt", file,
                    "sh", file + ".sh"
                ],
                {
                    stdio: [
                        "ignore", 1, 2
                    ]
                }
            ).on("exit", resolve);
        });
    }));
}());
' "$@" # '
    sed -i.bak -e 's|"name": "undefined"|"name": "v8-coverage-report"|' \
        package.json
    # screenshot asset_image_logo
    # shImageLogoCreate &
    # screenshot html
    node --input-type=module -e '
import moduleChildProcess from "child_process";
(async function () {
    await Promise.all([
        ".artifact/apidoc.html",
        ".artifact/coverage_sqlite3_js/index.html",
        ".artifact/coverage_sqlite3_js/lib/sqlite3.js.html",
        ".artifact/coverage_sqlite3_sh/index.html",
        ".artifact/coverage_sqlite3_sh/lib/sqlite3.js.html"
    ].map(async function (url) {
        await new Promise(function (resolve) {
            moduleChildProcess.spawn(
                "sh",
                [
                    "jslint_ci.sh", "shBrowserScreenshot", url
                ],
                {
                    stdio: [
                        "ignore", 1, 2
                    ]
                }
            ).on("exit", resolve);
        });
    }));
}());
' "$@" # '
    # remove bloated json-coverage-files
    rm .artifact/coverage/*.json
    rm .artifact/coverage_sqlite3_*/*.json
    # js-hack - */
    # .cache - save
    if [ ! -d .cache ]
    then
        mkdir .cache
        cp -a node-sqlite3-* .cache
    fi
)}

shCiBaseCustom() {(set -e
# this function will run base-ci
    # update version in README.md, jslint.mjs, package.json from CHANGELOG.md
    if [ "$(git branch --show-current)" = alpha ]
    then
        node --input-type=module -e '
import moduleFs from "fs";
(async function () {
    let fileDict;
    let fileModified;
    let packageDescription;
    let versionBeta;
    let versionMaster;
    fileDict = {};
    await Promise.all([
        "CHANGELOG.md",
        "README.md",
        "package.json"
    ].map(async function (file) {
        fileDict[file] = await moduleFs.promises.readFile(file, "utf8");
    }));
    packageDescription = fileDict["package.json"].match(
        /"description": "(.*?)"/
    )[1];
    Array.from(fileDict["CHANGELOG.md"].matchAll(
        /\n\n# (v\d\d\d\d\.\d\d?\.\d\d?(.*?)?)\n/g
    )).slice(0, 2).forEach(function ([
        ignore, version, isBeta
    ]) {
        versionBeta = versionBeta || version;
        versionMaster = versionMaster || (!isBeta && version);
    });
    await Promise.all([
        {
            file: "README.md",
            src: fileDict["README.md"].replace((
                /\bv\d\d\d\d\.\d\d?\.\d\d?\b/m
            ), versionMaster).replace((
                /\n# .*/
            ), "\n# " + packageDescription)
        }, {
            file: "package.json",
            src: fileDict["package.json"].replace((
                /("version": )".*?"/
            ), "$1" + JSON.stringify(versionBeta.slice(1)))
        }
    ].map(async function ({
        file,
        src
    }) {
        let src0 = fileDict[file];
        if (src !== src0) {
            console.error(`update file ${file}`);
            fileModified = file;
            await moduleFs.promises.writeFile(file, src);
        }
    }));
    if (fileModified) {
        // throw new Error("modified file " + fileModified);
        return;
    }
}());
' "$@" # '
    fi
    node jslint.mjs .
    # run test with coverage-report
    npm run test
)}
