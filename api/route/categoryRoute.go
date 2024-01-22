package route

import (
	"fmt"
	"io"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/y4cn/divar_full/database"
	"github.com/y4cn/divar_full/helper"
	"github.com/y4cn/divar_full/model"
)

func CreateCategory(ctx *gin.Context) {
	name := ctx.Request.FormValue("name")
	icon, err := ctx.FormFile("icon")
	image, errImage := ctx.FormFile("image")

	if len(name) < 3 {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage("Invalid name length should be at least 3 characters"))
		return
	}

	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}

	// Source
	src, err := icon.Open()
	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}
	defer src.Close()

	// Destination
	dst, err := os.Create(fmt.Sprintf("files/category/%s", icon.Filename))
	if err != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
		return
	}
	defer dst.Close()

	// Copy
	if _, err = io.Copy(dst, src); err != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
		return
	}

	//! image

	if errImage != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}

	// Source
	srcImage, err := image.Open()
	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}
	defer srcImage.Close()

	// Destination
	dstImage, err := os.Create(fmt.Sprintf("files/category/%s", image.Filename))
	if err != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
		return
	}
	defer dstImage.Close()

	// Copy
	if _, err = io.Copy(dstImage, srcImage); err != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
		return
	}

	catModel := model.Category{
		Name:  name,
		Icon:  icon.Filename,
		Image: image.Filename,
	}

	db := database.GetDB()
	res := db.Create(&catModel)

	if res.Error != nil {
		errMessage := map[string]any{
			"status":  false,
			"message": res.Error.Error(),
		}
		ctx.JSON(http.StatusBadGateway, errMessage)
		return
	}

	message := map[string]any{
		"status": true,
		"item":   catModel,
	}
	ctx.JSON(http.StatusCreated, message)
}

func GetAllCategory(ctx *gin.Context) {
	db := database.GetDB()
	foundCategories := []model.Category{}
	res := db.Find(&foundCategories)

	if res.Error != nil {

		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(res.Error.Error()))
		return
	}

	message := map[string]any{
		"status": true,
		"item":   foundCategories,
	}
	ctx.JSON(http.StatusCreated, message)
}

func DeleteCategory(ctx *gin.Context) {
	db := database.GetDB()
	id := ctx.Param("id")

	res := db.Delete(&model.Category{}, id)
	if res.Error != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(res.Error.Error()))
		return
	}

	message := map[string]any{
		"status":  true,
		"message": "successfully deleted",
	}
	ctx.JSON(http.StatusCreated, message)
}
