package model

import "gorm.io/gorm"

type User struct {
	gorm.Model
	UserName string `gorm:"column:user_name;not null" json:"user_name"`
	Name     string `gorm:"column:name;not null" json:"name"`
	Email    string `gorm:"column:email;not null" json:"email"`
	Password string `gorm:"column:password;not null" json:"-"`
	Enabled  bool   `gorm:"column:password;default:true" json:"-"`
}
