class dropbox::package {

        package  { $dropbox::package_name:
                ensure => $dropbox::ensure,
                require => Apt::Source['dropbox'],
        }

        package { 'python-gpgme':
                ensure => $dropbox::ensure,
        }

        apt::source { 'dropbox':
                ensure      => $dropbox::ensure,
                location    => 'http://linux.dropbox.com/ubuntu',
                release     => 'raring',
                repos       => 'main',
                key         => '5044912E',
                key_server  => 'pgp.mit.edu',
                include_src => false,
        }

}
