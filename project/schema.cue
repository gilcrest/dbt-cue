package dbt

#Quoting: {
	database?:   bool
	schema?:     bool
	identifier?: bool
}

#Project: {
	// The name of a dbt project. Must be letters, digits and underscores only, and cannot start with a digit.
	// https://docs.getdbt.com/reference/project-configs/name
	name: string

	// Specify your dbt_project.yml as using the v2 structure. Value should be 2
	// https://docs.getdbt.com/reference/project-configs/config-version
	"config-version": int

	// The version tag in a dbt_project file represents the version of your dbt project and is a required parameter.
	// However, it isn't currently used in a meaningful way by dbt.
	// The version must follow a semantic version format, such as 1.0.0.
	version: string

	// The profile your dbt project should use to connect to your data warehouse.
	// If you are developing in dbt Cloud: This configuration is not applicable
	// If you are developing locally: This configuration is required, unless a
	// command-line option (i.e. --profile) is supplied.
	profile: string

	// Optionally specify a custom list of directories where models and sources are located.
	"model-paths"?: [...string]

	// Optionally specify a custom list of directories where seed files are located.
	"seed-paths"?: [...string]

	// Optionally specify a custom list of directories where singular tests are located.
	"test-paths"?: [...string]

	// Specify a custom list of directories where analyses are located.
	"analysis-paths"?: [...string]

	// Optionally specify a custom list of directories where macros are located.
	// Note that you cannot co-locate models and macros. 
	"macro-paths"?: [...string]

	// Optionally specify a custom list of directories where snapshots are located.
	// Note that you cannot co-locate models and snapshots.
	"snapshot-paths": [...string]

	// Optionally specify a custom list of directories where docs blocks are located.
	"docs-paths"?: [...string]

	// Optionally specify a custom list of directories to copy to the target directory as part
	// of the docs generate command. This is useful for rendering images in your repository in
	// your project documentation.
	"asset-paths"?: [...string]

	// Optionally specify a custom directory where compiled files (e.g. compiled models and tests)
	// will be written when you run the dbt run, dbt compile, or dbt test command.
	"target-path"?: string

	// Optionally specify a custom directory where dbt will write logs.
	"log-path"?: string

	// Optionally specify a custom directory where packages are installed when you run the dbt deps
	// command. Note that this directory is usually git-ignored.
	"packages-install-path"?: string

	// Optionally specify a custom list of directories to be removed by the dbt clean command. As such, you should only include directories containing artifacts (e.g. compiled files, logs, installed packages) in this list.
	"clean-targets"?: [...string]

	// A string to inject as a comment in each query that dbt runs against your database. This
	// comment can be used to attribute SQL statements to specific dbt resources like models and tests.
	"query-comment"?: string

	// TODO - need to always quote this, work to be done here - see dbt docs
	"require-dbt-version"?: string // version-range | [version-range]

	// Optionally configure whether dbt should quote databases, schemas, and identifiers when:
	//     creating relations (tables/views)
	//     resolving a ref function to a direct relation reference
	//
	// On Snowflake, quoting is set to false by default.
	// Creating relations with quoted identifiers also makes those identifiers case sensitive.
	// It's much more difficult to select from them. You can re-enable quoting for relations
	// identifiers that are case sensitive, reserved words, or contain special characters, but
	// we recommend you avoid this as much as possible.
	quoting?: #Quoting
}

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
