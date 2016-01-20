define users::parser (
  $user = undef,
  $ssh  = undef,
  $sudo = undef,
) {
  if $user != undef {
    $hash = { "${name}" => $user }
    create_resources('user',$hash)
  }

  if $::operatingsystem == 'Darwin' {
    if $name != 'root' {
      file { "/Users/${name}":
        ensure  => directory,
        owner   => $name,
        require => User[$name],
      }
    }
  }

  if $ssh != undef {
    users::ssh { $name:
      ssh => $ssh,
    }
  }

  if $sudo != undef {
    users::sudo { $name:
      sudo => $sudo,
    }
  }
}

