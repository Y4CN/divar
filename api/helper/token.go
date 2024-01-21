package helper

import (
	"os"

	"github.com/golang-jwt/jwt"
	"github.com/joho/godotenv"
	"github.com/y4cn/divar_full/model"
)

func CreateToken(userModel *model.User) (*string, error) {

	tokenClaime := jwt.MapClaims{}

	tokenClaime["name"] = userModel.Name
	tokenClaime["user_name"] = userModel.UserName
	tokenClaime["email"] = userModel.Email
	accssesToken := jwt.NewWithClaims(jwt.SigningMethodHS256, tokenClaime)

	err := godotenv.Load()
	if err != nil {
		return nil, err
	}
	tokenSecret := os.Getenv("TokenSecret")

	jwtToken, err := accssesToken.SignedString([]byte(tokenSecret))

	if err != nil {
		return nil, err
	}

	return &jwtToken, nil
}
