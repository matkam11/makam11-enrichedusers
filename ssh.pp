define users::ssh (
  $ssh,
) {
  file { "/home/${name}/.ssh":
    ensure  => 'directory',
    require => User[$name],
    owner   => $name,
    mode    => '0700',
  }

  $newSSH = prefixHash($ssh, $name)
  $defaults = {
    user => $name,
  }

  create_resources(users::ssh::keys, $newSSH, $defaults)
}

