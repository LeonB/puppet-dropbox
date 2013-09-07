define dropbox::user(
	$user     = $name,
	$password = undef,
	$dx_uid   = $name,
	$dx_gid   = $name,
	$dx_home  = "/home/$name",
) {
	include dropbox

    Exec {
        path     => '/bin:/sbin:/usr/bin:/usr/sbin',
    }

    $download_arch = $::architecture ? {
		'i386'   => 'x86',
		'x86_64' => 'x86_64',
		'amd64'  => 'x86_64',
    }

    exec { 'download-dropbox-cli':
		command => "wget -O /tmp/dropbox.py \"https://www.dropbox.com/download?dl=packages/dropbox.py\"",
		unless  => 'test -f /tmp/dropbox.py',
		# require => User[$dx_uid],
    }
    file { '/usr/local/bin/dropbox':
		source  => '/tmp/dropbox.py',
		mode    => 755,
		require => Exec['download-dropbox-cli']
    }

    if ($user != undef and $password != undef) {
        raise Puppet::ParseError, "Dropbox for $dx_uid is not authorized"
        # if $::lsbdistcodename == 'squeeze' {
        #     apt::source { "swellpath-squeeze":
        #         location        => "http://swdeb.s3.amazonaws.com",
        #         release         => "squeeze",
        #         repos             => "main",
        #         key                 => "4EF797A0",
        #         key_server    => "subkeys.pgp.net",
        #         include_src => false,
        #         before            => Package['nodejs'],
        #     }
        # }
        # package { 'nodejs':
        #     ensure => installed
        # }

        # file { 'authorize.js':
        #     path            => "${dx_home}/authorize.js",
        #     source        => 'puppet:///modules/dropbox/authorize.js',
        #     owner         => $dx_uid,
        # }

        # # kill dropbox if we need to run the authorization process
        # exec { 'kill dropbox':
        #     command => 'service dropboxd stop',
        #     unless    => "test -f ${dx_home}/.dropbox/sigstore.dbx",
        #     before    => Exec['authorize-dropbox-user']
        # }

        # exec { 'authorize-dropbox-user':
        #     command => "node ${dx_home}/authorize.js ${user} ${password}",
        #     user        => $dx_uid,
        #     group     => $dx_gid,
        #     cwd         => $dx_home,
        #     logoutput => true,
        #     environment => ["HOME=${dx_home}", "USER=${dx_uid}"],
        #     creates => "${dx_home}/.dropbox/sigstore.dbx",
        #     before    => Service['dropboxd'],
        #     require => [File['authorize.js'], Package['nodejs']]
        # }
    }

    exec { 'download-dropbox':
		command => "wget -O /tmp/dropbox.tar.gz \"http://www.dropbox.com/download/?plat=lnx.${download_arch}\"",
		unless  => "test -d ~${dx_uid}/.dropbox-dist",
		# require => User[$dx_uid],
    }
    exec { 'install-dropbox':
		command => "tar -zxvf /tmp/dropbox.tar.gz -C ~${dx_uid}",
		unless  => "test -d ~${dx_uid}/.dropbox-dist",
		require => Exec['download-dropbox'],
    }
    file { '/tmp/dropbox.tar.gz':
		ensure  => 'absent',
		require => Exec['install-dropbox'],
    }

}
