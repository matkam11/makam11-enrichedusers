define enrichedusers::parser (
  $group = undef,
  $sudo = undef,
) {
  if $user != undef {
    $hash = { "${name}" => $group }
    create_resources('group',$hash)
  }

  if $sudo != undef {
    enrichedusers::sudo { "%${name}":
      sudo => $sudo,
    }
  }
}

