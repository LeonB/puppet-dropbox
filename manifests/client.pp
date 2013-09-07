class dropbox::client(
	$enabled = params_lookup( 'enabled' )
) inherits dropbox::client::params {

  	$ensure = $enabled ? {
  		true => present,
  		false => absent
  	}

	include dropbox::client::package, dropbox::client::config, dropbox::client::service
}
