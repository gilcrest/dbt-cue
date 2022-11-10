sources: #sourceList & [_stripe, _jaffleShop]

_stripe: #Source & {
	name:        "stripe"
	description: "Output from Stripe APIs"
	database:    "dbt-tutorial"
	schema:      "stripe"
	tables: [_stripePaymentTable]
}

_stripePaymentTable: #Table & {
	name:        "payment"
	description: "Stripe Payments table based on API response"
}

_jaffleShop: #Source & {
	name:        "jaffle_shop"
	description: "Jaffle Shop is the testing source for dbt"
	database:    "dbt-tutorial"
	schema:      "jaffle_shop"
	tables: [_jaffleCustomerTable, _jaffleOrderTable]
}

_jaffleCustomerTable: #Table & {
	name: "customers"
}

_jaffleOrderTable: #Table & {
	name: "orders"
}
