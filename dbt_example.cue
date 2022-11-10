version: 2

sources: [{
	name:            "jaffle_shop"
	database:        "raw"
	schema:          "public"
	loader:          "emr" // informational only (free text)
	loaded_at_field: "_loaded_at" // configure for all sources
	// meta fields are rendered in auto-generated documentation
	meta: {
		contains_pii: true
		owner:        "@alice"
	}

	// Add tags to this source
	tags: [
		"ecom",
		"pii",
	]

	quoting: {
		database:   false
		schema:     false
		identifier: false
	}

	tables: [{
		name:            "orders"
		identifier:      "Orders_"
		loaded_at_field: "updated_at" // override source defaults
		columns: [{
			name: "id"
			tests: [
				"unique",
			]
		}, {
			name: "price_in_usd"
			tests: [
				"not_null",
			]
		}]
	}, {
		name: "customers"
		quoting: identifier: true // override source defaults
		columns: {
			tests: ["unique"]
		}
	}]
}]
