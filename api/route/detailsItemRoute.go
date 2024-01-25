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

func CreateItemDetail(ctx *gin.Context) {
	db := database.GetDB()
	description := ctx.Request.FormValue("description")
	status := ctx.PostForm("status")
	itemId := ctx.Param("itemId")

	if len(description) < 8 {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage("Invalid name length should be at least 3 characters"))
		return
	}

	itemIdInt, _ := strconv.Atoi(itemId)

	//! item
	var itemModel *(model.Items)
	err := db.First(&itemModel, itemIdInt).Error
	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		// for _, v := range imageFileName {
		// 	os.Remove(fmt.Sprintf("files/items_details/%s", v))
		// }
		return
	}

	detailItemModel := model.DetailItem{
		Description: description,
		Status:      status,
		ItemId:      itemIdInt,
		Item:        *itemModel,
	}

	res := db.Create(&detailItemModel).Preload("Item.Category")

	if res.Error != nil {
		errMessage := map[string]any{
			"status":  false,
			"message": res.Error.Error(),
		}
		// for _, v := range imageFileName {
		// 	os.Remove(fmt.Sprintf("files/items_details/%s", v))
		// }
		ctx.JSON(http.StatusBadGateway, errMessage)
		return
	}

	form, err := ctx.MultipartForm()
	if err != nil {
		ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
		return
	}
	files := form.File["images"]

	for _, file := range files {

		// Source
		srcImage, err := file.Open()
		if err != nil {
			ctx.JSON(http.StatusBadRequest, helper.ErrorMessage(err.Error()))
			return
		}
		defer srcImage.Close()

		// Destination
		dstImage, err := os.Create(fmt.Sprintf("files/items_details/%s", file.Filename))
		if err != nil {
			ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
			return
		}
		defer dstImage.Close()

		// Copy
		if _, err = io.Copy(dstImage, srcImage); err != nil {
			ctx.JSON(http.StatusBadGateway, helper.ErrorMessage(err.Error()))
			os.Remove(fmt.Sprintf("files/items_details/%s", file.Filename))
			return
		}

		imageItem := &model.ImagesModel{
			ImageName:    file.Filename,
			DetailItem:   detailItemModel,
			DetailItemId: int(detailItemModel.Model.ID),
		}

		err = db.Create(&imageItem).Error
		if err != nil {
			fmt.Println("Item ", file.Filename, "error: ", err.Error())
			continue
		}
	}

	message := map[string]any{
		"status":   true,
		"messages": "DetailItem Created",
	}
	ctx.JSON(http.StatusCreated, message)
}

func GetAllItemsDetail(ctx *gin.Context) {
	db := database.GetDB()
	items := []model.DetailItem{}
	res := db.Preload("Item.Category").Preload("Images").Preload("Images.DetailItem").Preload("Item").Find(&items)

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

func DeleteItemDetail(ctx *gin.Context) {
	db := database.GetDB()
	id := ctx.Param("id")

	res := db.Delete(&model.DetailItem{}, id)
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

func GetItemByItemId(ctx *gin.Context) {
	itemId := ctx.Param("itemId")
	itemIdint, _ := strconv.Atoi(itemId)

	db := database.GetDB()
	items := []model.DetailItem{}

	res := db.Where("item_id = ?", itemIdint).Preload("Item.Category").Preload("Images").Preload("Images.DetailItem").Preload("Item").Find(&items)

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
