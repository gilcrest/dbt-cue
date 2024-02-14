version: 2

models: #modelList & [_exampleModel]

_exampleModel: #Model & {
	name:        "jaffle_shop"
	description: "Jaffle Shop is the testing source for dbt"
	config: #Config & {
		enabled: true
		contract: #Contract & {
			enforced: true
		}
	}
	constraints: #ModelLevelConstraints & {
		type:            "primary_key"
		warn_unenforced: false
		columns: ["column_1", "column_2"]
	}
	columns: _columnList
}

_columnList: [...#Column] & [
	{
		name:        "column_1"
		description: "Unique Identifier for the table."
		data_type:   "Varchar(10)"
	},
	{
		name:        "column_2"
		description: "Another unique identifier."
		data_type:   "Varchar(20)"
	}]
