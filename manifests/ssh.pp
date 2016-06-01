define enrichedusers::ssh (
  $ssh,
) {
  file { "/home/${name}/.ssh":
    ensure  => 'directory',
    require => User[$name],
    owner   => $name,
    mode    => '0700',
  }

  $newSSH = prefix($ssh, $name)
  $defaults = {
    user => $name,
  }

  create_resources(enrichedusers::ssh::keys, $newSSH, $defaults)
}

