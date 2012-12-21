class dropbox::service {
  service { 'dropboxd':
    ensure  => 'running',
    enable => 'true',
  }
}
