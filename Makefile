
up:
	docker-compose up -d

down:
	docker-compose down

createdb:
	docker exec -it simplebank-postgres-1 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it simplebank-postgres-1 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -destination db/mock/store.go -package mockdb github.com/not4sure/simplebank/db/sqlc Store

.PHONY: createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test up down server mock