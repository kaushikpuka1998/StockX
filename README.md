# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]

* System dependencies

* Configuration

* Database creation
  ```
    rake db:create
    rake db:migrate
  ```

* Database initialization
 ``` I put the details in .env file, make the db file in side the PSQL database name
  then initiate the previous command it will create and genrate the all the migration over the table
  ```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# StockX

## Curl:
### SignUP 
```
curl --location 'http://localhost:3000/user/signup' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "email": "kgstrivers@gmail.com",
        "password": "Pass@123"
    }
}'
```
Login
```
curl --location 'http://localhost:3000/user/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "kgstrivers@gmail.com",
    "password": "Pass@123"
}'
```
Deposit
```
curl --location 'http://localhost:3000/wallets/deposit' \
--header 'Content-Type: application/json' \
--header 'user-id: 1' \
--data '{"currency": "eth", "amount": 1.5}'
```

Withdrawal
```
curl --location 'http://localhost:3000/wallets/withdrawal' \
--header 'user-id: 1' \
--header 'Content-Type: application/json' \
--data '{
    "currency": "btc",
    "amount":2.0
}'
```

Balances
```
curl --location 'http://localhost:3000/wallet/balances' \
--header 'user-id: 1'
```
Order Create
```
curl --location 'http://localhost:3000/order/create' \
--header 'Content-Type: application/json' \
--header 'user-id: 1' \
--data '{
  "order": {
    "side": "sell",
    "base_currency": "btc",
    "quote_currency": "usd",
    "price": 29580.51,
    "volume": 1
  }
}'
```

Order Cancel
```
curl --location --request PUT 'http://localhost:3000/order/cancel' \
--header 'Content-Type: application/json' \
--header 'user-id: 1' \
--data '{
  "id": 1
}'
```

Dashboard
```
curl --location --request GET 'http://localhost:3000/dashboard' \
--header 'Content-Type: application/json' \
--data '{
  "from_time": "2023-01-01T00:00:00Z",
  "to_time": "2024-12-31T23:59:59Z"
}'
```
