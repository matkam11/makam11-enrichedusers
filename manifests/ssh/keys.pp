define enrichedusers::ssh::keys (
  $user,
  $key,
  $keyType = 'rsa',
  $ensure  = 'present',
) {
$keyName = delete($name, $user)
ssh_authorized_key { "${user}-${keyType}-${keyName}":
    ensure  => $ensure,
    key     => $key,
    type    => $keyType,
    user    => $user,
    require => File["/home/${user}/.ssh"],
  }
}

