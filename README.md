# OWASP mod security NGINX
## Docker commands
### Build
```Shell
docker build . -t seixasfelipe/nginx-jwt-authorization
```

### Run
```Shell
docker run --rm -it -p 8085:8082 --name nginx-jwt-authorization --network host seixasfelipe/nginx-jwt-authorization
```

More info about network between containers: https://stackoverflow.com/questions/41171115/why-cant-i-curl-one-docker-container-from-another-via-the-host

### Shell
```Shell
docker exec -it nginx-jwt-authorization sh
```

## Configuration (NJS + jwt authorization)
https://github.com/nginx/njs-examples/blob/master/conf/http/authorization/jwt.conf

## Authorization tests
```Shell
curl -H "authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c" http://localhost:8082/auth
```

# Keycloak
## Documentation
https://www.keycloak.org/getting-started/getting-started-docker

## Docker commands
```Shell
docker pull quay.io/keycloak/keycloak
```

## Run
```Shell
docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak start-dev
```