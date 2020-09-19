# ElixirJsonSchema

* Install docker 
* Execute docker-compose up
* To get the salaries invoke the endpoint using cURL:

```
curl --location --request POST 'http://localhost:4000/api/users' \
--header 'Content-Type: application/json' \
--data-raw '{"user":
  {
      "email": "test12@mail.com",
      "is_active": true,
      "password": "123"
  }
}'
```
