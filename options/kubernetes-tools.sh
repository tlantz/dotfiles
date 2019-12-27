#!/usr/bin/env bash

if [[ "Darwin" != "$(uname)" ]]; then
    echo "error: unsupported OS, this only works on OSX" >&2
    exit 1
fi

function check_and_install_tool {
    tool_name="${1}"
    brew_package="${2}"
    tool_path=$(command -v "${tool_name}")
    retcode="${?}"
    if [[ "0" != "${retcode}" ]]; then
        echo "no [${tool_name}] found, installing [${brew_package}] now via brew"
        brew install "${brew_package}"
    else
        echo "found [${tool_name}] at [${tool_path}]"
    fi
}

check_and_install_tool kubectl kubernetes-cli
check_and_install_tool kubectx kubectx
# Service level log aggregation at the cli.
check_and_install_tool stern stern

bash_completion_directory="/usr/local/etc/bash_completion.d/"
if [[ ! -d "${bash_completion_directory}" ]]; then
    echo "failed to setup bash completion, [${bash_completion_directory}] does not exist"
else
    kubectl completion bash >"${bash_completion_directory}/kubectl"
fi

# Ripped off https://github.com/kubernetes-sigs/krew install instructions.
# Note the spooky version number inlined that will surely come back to haunt me. Creepy.
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
  "$KREW" update
)

function install_kubectl_plugin {
    plugin_name="${1}"
    kubectl krew install "${plugin_name}"
}

# Used commonly at work, but one that makes sense to me.
install_kubectl_plugin prompt

# Modify .bash_profile
krew_line="export PATH=\"\${KREW_ROOT:-\$HOME/.krew}/bin:\$PATH\""
grep -F "${krew_line}" ~/.bash_profile >> /dev/null
retval="${?}"
if [[ "0" != "${retval}" ]]; then
    echo "adding krew line to .bash_profile"
    {
        echo ""
        echo "# Added by tlantz/dotfiles/options/kubernetes-tools.sh"
        echo "${krew_line}" >> ~/.bash_profile
        echo ""
    } >> ~/.bash_profile
fi
