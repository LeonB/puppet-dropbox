class dropbox::params {
	$enabled = true

        $package_name = $::operatingsystem ? {
                default => 'dropbox'
        }
}
