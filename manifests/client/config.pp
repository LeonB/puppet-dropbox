class dropbox::client::config inhertis dropbox::config {

        file { '/etc/init.d/dropboxd':
                source => "puppet:///modules/dropbox/etc/init.d/dropbox.${::operatingsystem}",
                owner  => root,
                group  => root,
                mode   => 755,
		require => Class['dropbox::cient::package']
        }

}
