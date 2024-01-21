package main

import (
	"github.com/gin-gonic/gin"
	"github.com/y4cn/divar_full/database"
	"github.com/y4cn/divar_full/model"
	"github.com/y4cn/divar_full/route"
)

func main() {
	db := database.GetDB()
	db.AutoMigrate(&model.User{})

	gin.SetMode(gin.DebugMode)

	engin := gin.Default()
	engin.Use(gin.ErrorLogger(), gin.Recovery())

	api := engin.Group("/api")
	v1 := api.Group("/v1")

	{
		//! user
		v1.POST("/register", route.RegisterUser)
		v1.POST("/login", route.LoginUser)
	}

	engin.Run(":3000")
}
