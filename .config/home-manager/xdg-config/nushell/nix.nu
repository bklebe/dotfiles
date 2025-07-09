use std/util "path add"

let nix_link_new = if "XDG_STATE_HOME" in $env {
    $env.XDG_STATE_HOME | path join ".nix-profile"
} else {
    $env.HOME | path join ".local/state/nix/profile"
}

 let nix_link = if ($nix_link_new | path exists) {
    $nix_link_new
} else {
    $env.HOME | path join ".nix-profile"
}

$env.ENV_CONVERSIONS = {
    ...$env.ENV_CONVERSIONS?
    NIX_PROFILES : {
        from_string: { |s| $s | split row ' ' }
        to_string: { |v| $v | str join ' ' }
    }
    XDG_DATA_DIRS : {
        from_string: { |s| $s | split row ':' }
        to_string: { |v| $v | str join ':' }
    }
}
let nix_default_profile = "/nix/var/nix/profiles/default"
$env.NIX_PROFILES = [$nix_default_profile, $nix_link]
let nix_link_share = $nix_link | path join "share"
if "XDG_DATA_DIRS" not-in $env {
    $env.XDG_DATA_DIRS = ["/usr/local/share" "/usr/share" $nix_link_share $nix_default_profile]
} else {
    $env.XDG_DATA_DIRS = $env.XDG_DATA_DIRS ++ [$nix_link_share $nix_default_profile]
}

if "NIX_SSL_CERT_FILE" in $env {
    # do nothing
} else if ("/etc/ssl/certs/ca-certificates.crt" | path exists) {
    $env.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"
} else if ("/etc/ssl/ca-bundle.pem" | path exists) {
    $env.NIX_SSL_CERT_FILE = "/etc/ssl/ca-bundle.pem"
} else if ("/etc/ssl/certs/ca-bundle.crt" | path exists) {
    $env.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt"
} else if ("/etc/pki/tls/certs/ca-bundle.crt" | path exists) {
    $env.NIX_SSL_CERT_FILE = "/etc/pki/tls/certs/ca-bundle.crt"
} else {
    $env.NIX_PROFILES
    | where { |p| $p | path join "etc/ssl/certs/ca-bundle.crt" | path exists }
    | each { |p| $env.NIX_SSL_CERT_FILE = $p | path join "etc/ssl/certs/ca-bundle.crt" }
}

path add $"($nix_link)/bin" "/nix/var/nix/profiles/default/bin"
