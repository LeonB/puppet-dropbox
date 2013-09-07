class dropbox(
	$enabled = params_lookup( 'enabled' )
) inherits dropbox::params {

  	$ensure = $enabled ? {
  		true => present,
  		false => absent
  	}

	include dropbox::package, dropbox::config, dropbox::service
}
