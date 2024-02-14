package dbt

#modelList: [...#Model]

#Model: {
	// The name of the model you are declaring properties for. Must match the filename of a model.
	// https://docs.getdbt.com/reference/resource-properties/model_name
	name: string

	// A user-defined description. Markdown string which can be used to document: a model, and model columns
	// https://docs.getdbt.com/reference/resource-properties/description
	description: string

	// The docs field can be used to provide documentation-specific configuration to models.
	// It supports the doc attribute show, which controls whether or not models are shown in the
	// auto-generated documentation website. It also supports node_color for models, seeds, snapshots,
	// and analyses. Other node types are not supported.
	// https://docs.getdbt.com/reference/resource-configs/docs
	docs?: #Docs

	// The config property allows you to configure resources at the same time you're defining properties in YAML files.
	// https://docs.getdbt.com/reference/model-configs
	config?: #Config

	constraints?: #ModelLevelConstraints

	columns: [...#Column]

	// latest_version - TODO
	// deprecation_date - TODO
	// access - TODO
}

#Docs: {
	show?:       bool
	node_color?: string
}

#Contract: {
	enforced: bool
}

#Config: {
	// An optional configuration for enabling or disabling a resource. Default: true
	// https://docs.getdbt.com/reference/resource-configs/enabled
	enabled?: bool
	// Apply a tag (or list of tags) to a resource.
	// https://docs.getdbt.com/reference/resource-configs/tags
	tags?: [...string]
	// specify a custom database for a model
	// https://docs.getdbt.com/reference/resource-configs/database
	database?: string
	// The schema name as stored in the database. This parameter is useful if you want to use a source name that
	// differs from the schema name. By default, dbt will use the source's name: parameter as the schema name
	schema?: string
	// Optionally specify a custom alias for a model
	// https://docs.getdbt.com/reference/resource-configs/alias
	alias?: string
	// The configured model(s) will not full-refresh when dbt run --full-refresh is invoked.
	full_refresh?: bool
	// When the contract configuration is enforced, dbt will ensure that your model's returned dataset exactly
	// matches the attributes you have defined in yaml:
	//  name and data_type for every column
	//  Additional constraints, as supported for this materialization and data platform
	contract?: #Contract

	// TODO
	// persist_docs: <dict>
	// meta: {<dictionary>}
	// grants: {<dictionary>}
}

#ModelLevelConstraints: {
	type:            string
	warn_unenforced: bool
	columns: [...string]
}

#ColumnLevelConstraints: {
	type:            string
	warn_unenforced: bool
	columns: [...string]
}

#Column: {
	name:        string
	description: string
	data_type?:  string
	quote?:      bool
	constraints?: [...#ColumnLevelConstraints]
}
