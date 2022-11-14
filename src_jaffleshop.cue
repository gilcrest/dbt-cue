sources: #sourceList & [_jaffleShop]

_jaffleShop: #Source & {
	name:        "jaffle_shop"
	description: "Jaffle Shop is the testing source for dbt"
	database:    "dbt-tutorial"
	schema:      "jaffle_shop"
	meta: [{"contains_pii": true, "owner": "@alice"}]
	tags: ["ecom", "pii"]
	quoting: #Quoting & {
		database:   false
		schema:     false
		identifier: false
	}
	tables: [ _jaffleOrderTable, _jaffleCustomerTable]
}

_jaffleOrderTable: #Table & {
	name:            "orders"
	identifier:      "Orders_"
	loaded_at_field: "updated_at"
	columns: [
		#Column & {
			name: "id"
			tests: ["unique", "not_null"]
		},
		#Column & {
			name: "price_in_usd"
			tests: ["not_null"]
		},
	]
}

_jaffleCustomerTable: #Table & {
	name:    "customers"
	quoting: #Quoting & {
		identifier: true
	}
}
