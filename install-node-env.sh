#!/bin/bash -eu

download() {
    local nodeVersion
    nodeVersion="$1"

    if [[ -z nodeVersion ]]; then
        nodeVersion="v6.11.1"
    fi
    doDownload "$nodeVersion"
}

doDownload() {
    local url version nodePkgName pkgPath
    version= "$1"
    nodePkgName="node-$version-linux-x64"
    url="https://nodejs.org/dist/$version/$nodePkgName.tar.xz"
    pkgPath="/tmp"

    cd "$pkgPath"
    echo "Downloading Node.js $version from $url"
    curl --retry "3" --retry-delay "0" --retry-max-time "5" -s -f -L "$url"
    return "$nodePkgName"
}

main() {
    local nodePkgName nodeInstallPath
    nodeInstallPath = "/usr/lib/"
    nodePkgName = download $1
    tar -zxvf "/tmp/$nodePkgName.tar.xz" -C "$nodeInstallPath"
    ln -s "$nodeInstallPath/$nodePkgName/bin/node" "/usr/local/bin/node"
    ln -s "$nodeInstallPath/$nodePkgName/bin/npm" "/usr/local/bin/npm"
}

main "$@"
