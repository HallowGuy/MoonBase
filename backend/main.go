package main

import (
    "net/http"

    "github.com/labstack/echo/v4"
)

func main() {
    e := echo.New()
    e.GET("/api/home", func(c echo.Context) error {
        return c.String(http.StatusOK, "Welcome to the home page")
    })
    e.Logger.Fatal(e.Start(":8080"))
}
