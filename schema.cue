package dbt

version: 2

#sourceList: [...#Source]

#Source: {
	name:             !="" // must be specified and non-empty
	description?:     string
	database?:        string
	schema?:          string
	loader?:          string
	loaded_at_field?: string
	meta?:            _
	tags?: [...string]
	quoting?: #Quoting
	tables?: [...#Table]
}

#Quoting: {
	database:   bool
	schema:     bool
	identifier: bool
}

#Table: {
	name:         !=""   // must be specified and non-empty
	description?: string // <markdown_string>
}

// meta:            _      // {<dictionary>}
// identifier:      string // <table_name>
// loaded_at_field: string // <column_name>
//        tests:
//          - <test>
//          - ... # declare additional tests
//        tags: [<string>]
//        freshness:
//          warn_after:
//            count: <positive_integer>
//            period: minute | hour | day
//          error_after:
//            count: <positive_integer>
//            period: minute | hour | day
//          filter: <where-condition>
//
//       quoting:
//         database: true | false
//          schema: true | false
//          identifier: true | false
//        external: {<dictionary>}
//        columns:
//          - name: <column_name> # required
//            description: <markdown_string>
//            meta: {<dictionary>}
//            quote: true | false
//            tests:
//              - <test>
//              - ... # declare additional tests
//            tags: [<string>]
//   }
