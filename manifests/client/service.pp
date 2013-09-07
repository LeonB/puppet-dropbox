class dropbox::client::service inhertits dropbox::service {

  service { 'dropboxd':
    ensure  => 'running',
    enable => 'true',
    require => File['/etc/init.d/dropboxd'],
  }

}
