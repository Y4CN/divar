package model

import "gorm.io/gorm"

type DetailItem struct {
	gorm.Model
	Description string `gorm:"column:description;not null" json:"description"`
	Status      string `gorm:"column:status;" json:"status"`
	Item        Items  `gorm:"foreignKey:ItemId;constraint:OnUpdate:NO ACTION;OnDelete:NO ACTION" json:"item"`
	ItemId      int    `json:"-"`
	Images      []ImagesModel
}

type ImagesModel struct {
	gorm.Model
	ImageName    string     `gorm:"column:image_name;not null" json:"image_name"`
	DetailItem   DetailItem `gorm:"foreignKey:DetailItemId;constraint:OnUpdate:NO ACTION;OnDelete:NO ACTION" json:"-"`
	DetailItemId int        `json:"-"`
}
