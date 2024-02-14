package dbt

#ProfileConfig: {
	send_anonymous_usage_stats?: bool
	use_colors?:                 bool
	partial_parse?:              bool
	printer_width?:              int
	write_json?:                 bool
	warn_error?:                 bool
	warn_error_options?:         "TODO" // <include: all | include: [<error-name>] | include: all, exclude: [<error-name>]>
	log_format?:                 "text" | "json" | "default"
	debug?:                      bool
	version_check?:              bool
	fail_fast?:                  bool
	use_experimental_parser?:    bool
	static_parser?:              bool
}

#SnowflakeProfile: {
	// default target
	target: string
	outputs: [...]
}

#SSOTarget: {
	"sso": {
		#SnowflakeSSOAuthenticationTargetDetail
	}
}

#SnowflakeKeyPairAuthenticationTargetDetail: {
	type:                      "snowflake"
	account:                   string // account id
	user:                      string // username
	role:                      string // user role
	private_key_path:          string // path/to/private.key
	private_key_passphrase:    string // passphrase for the private key, if key is encrypted
	database:                  string // database name
	warehouse:                 string // warehouse name
	schema:                    string // dbt schema
	threads:                   int    // 1 or more
	client_session_keep_alive: bool
	query_tag:                 string

	// optional
	connect_retries?:          int  // default 0
	connect_timeout?:          int  // default 10
	retry_on_database_errors?: bool // default false
	retry_all?:                bool //default false
	reuse_connections?:        bool // default false
}

#SnowflakeSSOAuthenticationTargetDetail: {
	type:                      "snowflake"
	account:                   string            // account id
	user:                      string            // username
	role:                      string            // user role
	authenticator:             "externalbrowser" // path/to/private.key
	database:                  string            // database name
	warehouse:                 string            // warehouse name
	schema:                    string            // schema dbt objects are built in
	threads:                   int               // 1 or more
	client_session_keep_alive: bool
	query_tag:                 string

	// optional
	connect_retries?:          int  // default 0
	connect_timeout?:          int  // default 10
	retry_on_database_errors?: bool // default false
	retry_all?:                bool //default false
	reuse_connections?:        bool // default false
}
