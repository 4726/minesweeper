package main

import (
	"context"
	"database/sql"

	"github.com/heroiclabs/nakama-common/runtime"
)

func InitModule(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, initializer runtime.Initializer) error {
	return SetupLeaderboard(ctx, nk)
}

func SetupLeaderboard(ctx context.Context, nk runtime.NakamaModule) error {
	return nk.LeaderboardCreate(ctx, "scores", false, "asc", "best", "", map[string]interface{}{})
}
