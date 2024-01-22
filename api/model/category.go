package model

import "gorm.io/gorm"

type Category struct {
	gorm.Model
	Name  string `gorm:"column:name;not null" json:"name"`
	Icon  string `gorm:"column:icon;not null" json:"icon"`
	Image string `gorm:"column:image;not null" json:"image"`
}
