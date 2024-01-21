package main

import (
	"github.com/gin-gonic/gin"
	"github.com/y4cn/divar_full/database"
)

func main() {
	db := database.GetDB()
	// db.AutoMigrate()

	//! change that
	_ = db

	gin.SetMode(gin.DebugMode)

	engin := gin.Default()
	engin.Use(gin.ErrorLogger(), gin.Recovery())

	api := engin.Group("/api")
	v1 := api.Group("/v1")

	//! change that
	_ = v1

	engin.Run("3000")
}
