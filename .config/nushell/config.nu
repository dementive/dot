# See https://www.nushell.sh/book/configuration.html

## TP ##

let shims_dir = (
  if ( $env | get --optional ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  } | path join 'shims'
)
$env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )

$env.AWS_VAULT_KEYCHAIN_NAME = 'login'

## END TP ##

$env.config.buffer_editor = "code-oss"
$env.EDITOR = 'code-oss'
$env.VISUAL = 'code-oss'

$env.config.show_banner = false
$env.config.completions.algorithm = "fuzzy"

load-env {
    GTK_THEME: 'Material-Black-Blueberry',
    QT_STYLE_OVERRIDE: 'kvantum',
    QT_QPA_PLATFORM_THEME: 'qt6ct'
    PROMPT_INDICATOR: ' '
    LD_LIBRARY_PATH: "/home/dm/dev/godot/bin"
    PROMPT_COMMAND_RIGHT: ''
    EDITOR: 'code-oss'
}

$env.PATH ++= [ "~/.local/bin" ]
$env.PATH = ($env.PATH | uniq)

alias c = clear
alias e = exit
alias xbi = sudo xbps-install
alias xbu = sudo flatpak update and xbps-install -Su
alias xbs = xbps-query -Rs
alias xbd = sudo xbps-remove -Oo
alias bd = ./bd.py
alias run = ./run.sh
