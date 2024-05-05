# OWASP Juice Shop

https://github.com/juice-shop/juice-shop

## Setup

ALl commands must be run from the root of the repository.

### Master

```bash
make build-master
make run-master
```

1. `make build-master`
2. `make run-master`
3. Login as master to `ctf_copas` app
4. Go to CTFd -> open CTFd -> sign up as admin -> create access token -> store access token in `ctf_copas` app
5. Go to CTFd -> open CTFd -> admin panel -> config -> backup -> import csv and import
   OWASP_Juice_Shop.2024-05-04.CTFd.csv
6. `make commit`
7. `make export`

### Player

```bash
make run-player
```

