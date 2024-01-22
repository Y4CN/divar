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
	db.AutoMigrate(&model.Category{})
	db.AutoMigrate(&model.Items{})

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
	{
		//! category
		cat := v1.Group("/category")
		cat.POST("/create", route.CreateCategory)
		cat.GET("/", route.GetAllCategory)
		cat.DELETE("/:id", route.DeleteCategory)
	}
	{
		//! items
		item := v1.Group("/items")
		item.POST("/create/:categoryId", route.CreateItem)
		item.GET("/", route.GetAllItems)
		item.DELETE("/:id", route.DeleteItem)
		item.GET("/:categoryId", route.GetItemByCategoryId)
	}

	engin.Run(":3000")
}
