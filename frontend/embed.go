package frontend

import (
	"embed"

	"github.com/labstack/echo/v5"
)

//go:embed all:dist
var distDir embed.FS

var DistDirFS = echo.MustSubFS(distDir, "dist")
