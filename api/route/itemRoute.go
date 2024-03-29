package route

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/y4cn/divar_full/database"
	"github.com/y4cn/divar_full/helper"
	"github.com/y4cn/divar_full/model"
)

func CreateItem(ctx *gin.Context) {
	title := ctx.Request.FormValue("title")
	price := ctx.PostForm("price")
	image, errImage := ctx.FormFile("image")
	catId := ctx.Param("categoryId")
	userId := ctx.Param("userId")

	if len(title) < 3 {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage("Invalid name length should be at least 3 characters"))
		return
	}

	//! image

	if errImage != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(errImage.Error()))
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
	dstImage, err := os.Create(fmt.Sprintf("files/items/%s", image.Filename))
	if err != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
		return
	}
	defer dstImage.Close()

	// Copy
	if _, err = io.Copy(dstImage, srcImage); err != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
		os.Remove(fmt.Sprintf("files/items/%s", image.Filename))
		return
	}
	db := database.GetDB()
	catIdInt, _ := strconv.Atoi(catId)

	//! category
	var categoryItem *(model.Category)
	err = db.First(&categoryItem, catIdInt).Error
	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		os.Remove(fmt.Sprintf("files/items/%s", image.Filename))
		return
	}

	//! user

	userInt, _ := strconv.Atoi(userId)

	var userModel *(model.User)
	err = db.First(&userModel, userInt).Error
	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		os.Remove(fmt.Sprintf("files/items/%s", image.Filename))
		return
	}

	itemModel := model.Items{
		Title:      title,
		Image:      image.Filename,
		Price:      price,
		CategoryId: catIdInt,
		Category:   *categoryItem,
		User:       *userModel,
		UserId:     userInt,
	}

	res := db.Create(&itemModel)

	if res.Error != nil {
		errMessage := map[string]any{
			"status":  false,
			"message": res.Error.Error(),
		}
		os.Remove(fmt.Sprintf("files/items/%s", image.Filename))
		ctx.JSON(http.StatusBadGateway, errMessage)
		return
	}

	message := map[string]any{
		"status": true,
		"item":   itemModel,
	}
	ctx.JSON(http.StatusCreated, message)
}

func GetAllItems(ctx *gin.Context) {
	db := database.GetDB()
	items := []model.Items{}
	res := db.Preload("Category").Preload("User").Find(&items)

	if res.Error != nil {

		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(res.Error.Error()))
		return
	}

	message := map[string]any{
		"status": true,
		"item":   items,
	}
	ctx.JSON(http.StatusCreated, message)
}

func DeleteItem(ctx *gin.Context) {
	db := database.GetDB()
	id := ctx.Param("id")

	res := db.Delete(&model.Items{}, id)
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

func GetItemByCategoryId(ctx *gin.Context) {
	cat_id := ctx.Param("categoryId")
	catInt, _ := strconv.Atoi(cat_id)

	db := database.GetDB()
	items := []model.Items{}

	res := db.Where("category_id = ?", catInt).Preload("Category").Preload("User").Find(&items)

	if res.Error != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(res.Error.Error()))
		return
	}

	message := map[string]any{
		"status": true,
		"item":   items,
	}
	ctx.JSON(http.StatusCreated, message)
}

func GetItemBySearch(ctx *gin.Context) {
	searchTxt := ctx.Request.FormValue("txt")

	db := database.GetDB()
	items := []model.Items{}
	likeSearch := fmt.Sprintf("%%%s%%", searchTxt)

	res := db.Where("title LIKE ?", likeSearch).Preload("Category").Preload("User").Find(&items)

	if res.Error != nil {
		ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(res.Error.Error()))
		return
	}

	message := map[string]any{
		"status": true,
		"item":   items,
	}
	ctx.JSON(http.StatusCreated, message)
}
