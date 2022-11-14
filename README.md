# dbt-cue

Generate dbt yml files using the [CUE language](https://cuelang.org/)

## About

I personally don't love YAML and find it error prone. I use the CUE language to generate and validate all YAML files for just about everything I do at this point (Kubernetes, config, etc.) This repo demonstrates using CUE to generate [dbt](https://docs.getdbt.com/reference/source-properties) YAML files. There are a lot more checks to be added and you can easily clone and add your own validations as well, but this is a start.

## Minimum Requirements

- [CUE cli](https://github.com/cue-lang/cue#download-and-install)

## Getting Started

The [schema.cue](https://github.com/gilcrest/dbt-cue/blob/main/schema.cue) file defines the [types and values](https://cuetorials.com/overview/types-and-values/) that are used to build the dbt yaml files. For now, I've only worked through building the [Source](https://docs.getdbt.com/reference/source-properties) yaml file. I will add more later. The `schema.cue` file is for shared type and value definitions only and should not be edited.

User input goes into a `src_` file (though the name doesn't matter), where the various objects are built.

```cue
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
```

> Creating CUE values reads well as it is a superset of JSON. Here we are creating a _jaffleShop value, which is a dbt Source (see `schema.cue`) for the #Source definition. We can add whatever key value pairs we like as meta, any list of strings for tags, etc. For more complex structures like a `table` or `quoting`, we use CUE [definitions](https://cuetorials.com/overview/types-and-values/#definitions), there are examples here of creating them inline as well as separate entities.

## File Generation

The CUE cli is used to **vet** (validate the data against the schema), **fmt** (format - which nicely standardizes are input files) and finally **export** the data to the named file. CUE works with the concept of packages, so you can merge multiple files together. As noted before, I put my general types and values in the `schema.cue` file and implement those types and values in a separate file (in this case `src_jaffleshop.cue`). I provided 2 different sample bash scripts that you can use to generate output or input the commands yourself.

```bash
cue vet schema.cue src_jaffleshop.cue
cue fmt schema.cue src_jaffleshop.cue
cue export schema.cue src_jaffleshop.cue --force --out yaml --outfile _jaffle_shop__sources.yml
```

> For each command (vet, fmt, export) I am passing the list of files to be used when generating the output. --out is what type of output (yaml, json, etc.) The --outfile is what we want to name our output file.

## Output

The below output is from CUE, you'll find it basically a match (minus spaces) for the [Source example](https://docs.getdbt.com/reference/source-properties#example).

```yml
version: 2
sources:
  - name: jaffle_shop
    description: Jaffle Shop is the testing source for dbt
    database: dbt-tutorial
    schema: jaffle_shop
    meta:
      - contains_pii: true
        owner: '@alice'
    tags:
      - ecom
      - pii
    quoting:
      database: false
      schema: false
      identifier: false
    tables:
      - name: orders
        identifier: Orders_
        loaded_at_field: updated_at
        columns:
          - name: id
            tests:
              - unique
              - not_null
          - name: price_in_usd
            tests:
              - not_null
      - name: customers
        quoting:
          identifier: true
```
