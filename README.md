# README

### Docker (with development environment)
1. To builds, (re)creates, starts, and attaches to containers for a service. Run following command:
```
docker-compose up -d --build
```
2. Database create, migrate, seed
```
docker-compose run web rails db:create db:migrate db:seed
```
3. To stops containers and removes containers, networks, volumes, and images created by up. Run following command:
```
docker-compose down
```

### Local setup
1. Create new database user
```
psql postgres
```
```
CREATE USER <DATABASE_USERNAME> WITH SUPERUSER PASSWORD '<DATABASE_PASSWORD>';
```
2. Update environment variable in .env file
3. Database migrate, seed
```
rails db:migrate
```
```
rails db:seed
```
4. Run server
```
rails s
```