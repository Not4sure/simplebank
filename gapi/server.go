package gapi

import (
	"fmt"

	db "github.com/not4sure/simplebank/db/sqlc"
	"github.com/not4sure/simplebank/pb"
	"github.com/not4sure/simplebank/token"
	"github.com/not4sure/simplebank/util"
)

// Server servers gRPC requests for banking service
type Server struct {
	pb.UnimplementedSimpleBankServer
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
}

// NewServer creates a new gRPC server.
func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker %w", err)
	}

	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}
