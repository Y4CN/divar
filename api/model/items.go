package model

import "gorm.io/gorm"

type Items struct {
	gorm.Model
	Title      string   `gorm:"column:title;not null" json:"title"`
	Price      string   `gorm:"column:price;not null" json:"price"`
	Image      string   `gorm:"column:image;not null" json:"image"`
	Category   Category `gorm:"foreignKey:CategoryId;constraint:OnUpdate:NO ACTION;OnDelete:NO ACTION" json:"category"`
	CategoryId int      `json:"-"`
}
