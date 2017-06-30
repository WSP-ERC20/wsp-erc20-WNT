# truffle-init-webpack
Example webpack project with Truffle. Includes contracts, migrations, tests, user interface and webpack build pipeline.

Current Whitepaper draft: https://docs.google.com/document/d/1TEfj5KX0zOIf564g8oR-FEiFOgxkx5Y86hBhwYH1M-s/edit?usp=sharing

## Usage

To initialize a project with this exapmple, run `truffle init webpack` inside an empty directory.

## Building and the frontend

1. First run `truffle compile`, then run `truffle migrate` to deploy the contracts onto your network of choice (default "development").
1. Then run `npm run dev` to build the app and serve it on http://localhost:8080
