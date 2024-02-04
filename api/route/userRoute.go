package route

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/y4cn/divar_full/database"
	"github.com/y4cn/divar_full/helper"
	"github.com/y4cn/divar_full/model"
)

func RegisterUser(ctx *gin.Context) {
	userName := ctx.Request.FormValue("user_name")
	name := ctx.Request.FormValue("name")
	email := ctx.Request.FormValue("email")
	pass := ctx.Request.FormValue("password")

	err := helper.RegisterUserService(userName, name, email, pass)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}

	response := map[string]any{
		"status":  true,
		"message": "Register successful",
	}
	ctx.JSON(http.StatusCreated, response)
}

func LoginUser(ctx *gin.Context) {
	email := ctx.Request.FormValue("email")
	pass := ctx.Request.FormValue("password")
	token, user, err := helper.LoginUserService(email, pass)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}

	response := map[string]any{
		"status":  true,
		"message": "Login successful",
		"token":   token,
		"items":   user,
	}
	ctx.JSON(http.StatusOK, response)
}

func GetUserById(ctx *gin.Context) {
	userId := ctx.Param("userId")
	db := database.GetDB()

	user := model.User{}
	err := db.First(&user, userId).Error
	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}
	response := map[string]any{
		"status": true,
		"items":  user,
	}
	ctx.JSON(http.StatusOK, response)

}
