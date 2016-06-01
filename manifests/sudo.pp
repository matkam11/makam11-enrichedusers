define enrichedusers::sudo (
  $sudo
) {
  $hosts = join($sudo['hosts'], ', ')
  $allowed = join($sudo['allowed'], ', ')

  sudo::conf { $name:
    priority => $sudo['priority'],
    content  => "${name} ${hosts} = ${allowed}",
  }
}
