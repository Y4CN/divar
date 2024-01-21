package helper

import (
	"errors"

	"github.com/y4cn/divar_full/database"
	"github.com/y4cn/divar_full/model"
	"golang.org/x/crypto/bcrypt"
)

func RegisterUserService(userName, name, email, pass string) error {
	existEmail, err := ExistsByEmail(email)
	if err != nil {
		return err
	}

	if existEmail {
		return errors.New("email already exists")
	}

	existUserName, err := ExistsByUsername(userName)
	if err != nil {
		return err
	}
	if existUserName {
		return errors.New("userName already exists")
	}

	bytePass := []byte(pass)
	// hp, err := bcrypt.GenerateFromPassword(bytePass, bcrypt.DefaultCost)
	hp, err := bcrypt.GenerateFromPassword(bytePass, bcrypt.MaxCost)
	if err != nil {
		return err
	}

	hashPass := string(hp)

	database := database.GetDB()

	tx := database.Begin()

	u := &model.User{
		UserName: userName,
		Name:     name,
		Email:    email,
		Password: hashPass,
	}

	err = tx.Create(&u).Error
	if err != nil {
		tx.Rollback()
		return err
	}
	tx.Commit()

	return nil
}

func LoginUserService(email, pass string) (*string, *model.User, error) {
	database := database.GetDB()
	var user model.User
	err := database.Model(&model.User{}).Where("email = ?", email).Find(&user).Error

	if err != nil {
		return nil, nil, err
	}

	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(pass))
	if err != nil {
		return nil, nil, errors.New("email or password is incorrect")
	}

	token, err := CreateToken(&user)
	if err != nil {
		return nil, nil, err
	}

	return token, &user, nil
}

func ExistsByEmail(email string) (bool, error) {
	database := database.GetDB()
	var exists bool
	if err := database.Model(&model.User{}).
		Select("count(*) > 0").
		Where("email = ?", email).
		Find(&exists).
		Error; err != nil {
		return false, err
	}
	return exists, nil
}

func ExistsByUsername(username string) (bool, error) {
	database := database.GetDB()
	var exists bool
	if err := database.Model(&model.User{}).
		Select("count(*) > 0").
		Where("user_name = ?", username).
		Find(&exists).
		Error; err != nil {
		return false, err
	}
	return exists, nil
}
