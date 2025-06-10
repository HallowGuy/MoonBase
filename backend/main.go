package main

// Simple REST API demonstrating a Go backend using Echo and PostgreSQL.

import (
	"context"
	"net/http"
	"os"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/labstack/echo/v4"
)

type App struct {
	db *pgxpool.Pool
}

// loginRequest represents the payload expected when a user logs in.

type loginRequest struct {
	Username string `json:"username"`
	Email    string `json:"email"`
}

// userLogin increments the login counter for a user and creates the user if not present.

func (a *App) userLogin(c echo.Context) error {
	var req loginRequest
	if err := c.Bind(&req); err != nil {
		return c.NoContent(http.StatusBadRequest)
	}
	_, err := a.db.Exec(c.Request().Context(),
		`INSERT INTO users (username, email, nbre_de_connexions)
         VALUES ($1, $2, 1)
         ON CONFLICT (email) DO UPDATE
         SET nbre_de_connexions = users.nbre_de_connexions + 1,
             username = EXCLUDED.username`,
		req.Username, req.Email)
	if err != nil {
		return c.NoContent(http.StatusInternalServerError)
	}
	return c.NoContent(http.StatusOK)
}

// main initializes the database connection and starts the HTTP server.

func main() {
	// Database connection URL, e.g. postgres://user:pass@host:5432/db?search_path=app
	dbURL := os.Getenv("DATABASE_URL")
	pool, err := pgxpool.New(context.Background(), dbURL)
	if err != nil {
		panic(err)
	}
	defer pool.Close()

	app := &App{db: pool}

	e := echo.New()
	e.GET("/api/home", func(c echo.Context) error {
		return c.String(http.StatusOK, "Welcome to the home page")
	})
	e.POST("/api/user/login", app.userLogin)

	// Allow overriding the listening port via PORT
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	e.Logger.Fatal(e.Start(":" + port))
}
