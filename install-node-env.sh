#!/bin/bash -eu

install() {
    local nodeVersion nodePkgName nodeInstallPath
    if [[ $# -eq 1 ]] && [[ -n $1 ]]; then
        nodeVersion="$1"
    else
        nodeVersion="v6.11.1";
    fi
    nodeInstallPath="/usr/lib/"
    nodePkgName="node-$nodeVersion-linux-x64"
    doDownload "$nodeVersion $nodePkgName"
    tar -zxvf "/tmp/$nodePkgName.tar.xz" -C "$nodeInstallPath"
    ln -s "$nodeInstallPath/$nodePkgName/bin/node" "/usr/local/bin/node"
    ln -s "$nodeInstallPath/$nodePkgName/bin/npm" "/usr/local/bin/npm"
}

doDownload() {
    local url nodeVersion nodePkgName pkgPath
    nodeVersion="$1"
    nodePkgName="$2"
    url="https://nodejs.org/dist/$nodeVersion/$nodePkgName.tar.xz"
    pkgPath="/tmp"

    cd "$pkgPath"
    echo "Downloading Node.js $nodeVersion from $url"
    curl --retry "3" --retry-delay "0" --retry-max-time "5" -# -O "$url"
}

main() {
    local nodeVersion
    if [[ $# -eq 1 ]]; then
        nodeVersion="$1";
    fi
    install "$nodeVersion"
}

main "$@"
