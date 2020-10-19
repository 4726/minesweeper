package main

import nk "github.com/heroiclabs/nakama-common/runtime"

func SetupLeaderboard(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, payload string) (string, error) {
	err := nk.LeaderboardCreate(ctx, "scores", false, "asc", "best", "", map[string]interface{})

	return "", err
}