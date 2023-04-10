config: #ProfileConfig & {
	send_anonymous_usage_stats: false
	use_colors:                 true
	partial_parse:              false
	printer_width:              80
	write_json:                 false
	warn_error:                 false
	log_format:                 "default"
	debug:                      false
	version_check:              false
	fail_fast:                  false
	use_experimental_parser:    false
	static_parser:              false
}

"my-snowflake-db": #SnowflakeProfile & {
	// default target
	target: "dev"
	outputs: [_devTarget, _ssoTarget]
}

_devTarget: {
	"dev": {
		#SnowflakeKeyPairAuthenticationTargetDetail & {
			type:    "snowflake"
			account: "jaffle"      // account id
			user:    "johnnyAdmin" // username
			role:    "admin"       // user role

			private_key_path:       "path/to/private.key"   // path/to/private.key
			private_key_passphrase: "superSecretPassPhrase" // passphrase for the private key, if key is encrypted

			database:                  "somedb"       // database name
			warehouse:                 "xs_warehouse" // warehouse name
			schema:                    "dev_schema"   // schema dbt objects are built in
			threads:                   1              // 1 or more
			client_session_keep_alive: false
			query_tag:                 "querytag?"

			// optional
			connect_retries?:          0     // default 0
			connect_timeout?:          10    // default 10
			retry_on_database_errors?: false // default false
			retry_all?:                false //default false
			reuse_connections?:        false // default false
		}
	}
}

_ssoTarget: {
	"sso": {
		#SnowflakeSSOAuthenticationTargetDetail & {
			type:    "snowflake"
			account: "jaffle"        // account id
			user:    "johnnyLocal"   // username
			role:    "lessThanAdmin" // user role

			database:                  "somedb"       // database name
			warehouse:                 "xs_warehouse" // warehouse name
			schema:                    "dev_schema"   // schema dbt objects are built in
			threads:                   1              // 1 or more
			client_session_keep_alive: false
			query_tag:                 "querytag?"

			// optional
			connect_retries?:          0     // default 0
			connect_timeout?:          10    // default 10
			retry_on_database_errors?: false // default false
			retry_all?:                false //default false
			reuse_connections?:        false // default false
		}
	}
}
