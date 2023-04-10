package dbt

#sourceList: [...#Source]

#Source: {
	name:             string // required
	description?:     string // <markdown_string>
	database?:        string // <database_name>
	schema?:          string // <schema_name>
	loader?:          string // <string>
	loaded_at_field?: string // <column_name>
	meta?: [...]
	tags?: [...string]
	config?:    "to_be_built"
	overrides?: string
	freshness?: #Freshness
	quoting?:   #Quoting
	tables?: [...#Table]
}

#Quoting: {
	database?:   bool
	schema?:     bool
	identifier?: bool
}

#Freshness: {
	warn_after?:  #AlertConfig
	error_after?: #AlertConfig
	filter?:      string // <where-condition>
}

_standardFreshnessAlert: #Freshness & {
	warn_after: #AlertConfig & {
		count:  12
		period: "hour"
	}
	error_after: #AlertConfig & {
		count:  24
		period: "hour"
	}
}

#AlertConfig: {
	count:  int
	period: #Period
}

#Period: "minute" | "hour" | "day"

#Table: {
	name:         !=""   // must be specified and non-empty
	description?: string // <markdown_string>
	meta?: [...]      // {<dictionary>}
	identifier?:      string // <table_name>
	loaded_at_field?: string // <column_name>
	tests?: [...#GenericTest]
	tags?: [...string]
	freshness?: #Freshness
	quoting?:   #Quoting
	external?: [...] // {<dictionary>}
	columns?: [...#Column]

}

#Column: {
	name:         string // <column_name> # required
	description?: string // <markdown_string>
	meta?: [...] // {<dictionary>}
	quote?:      bool
	tests?: [...#GenericTest]
	tags?: [...string]
}

#GenericTest: "unique" | "not_null" | #AcceptedValues | #Relationship

#AcceptedValues: {
	accepted_values: {
		values: [...]
	}
}

#Relationship: {
	relationships: {
		to:    string
		field: string
	}
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
