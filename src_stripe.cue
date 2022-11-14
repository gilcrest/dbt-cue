sources: #sourceList & [_stripe]

_stripe: #Source & {
	name:        "stripe"
	description: "Output from Stripe APIs"
	database:    "dbt-tutorial"
	schema:      "stripe"
	tables: [_stripePaymentTable]
}

_stripePaymentTable: #Table & {
	name:            "payment"
	description:     "Stripe Payments table based on API response"
	loaded_at_field: "_batched_at"
	freshness:       _standardFreshnessAlert
}
