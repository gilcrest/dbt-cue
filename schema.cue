package dbt

version: 2

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
	tests?: [...#BasicTest]
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
	tests?: [...#BasicTest]
	tags?: [...string]
}

#BasicTest: "unique" | "not_null"
