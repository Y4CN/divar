package helper

import (
	"errors"
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

func VerifyToken(token string) (*jwt.Token, error) {

	err := godotenv.Load()
	if err != nil {
		return nil, err
	}
	tokenSecret := os.Getenv("TokenSecret")

	t, err := jwt.Parse(token, func(t *jwt.Token) (interface{}, error) {
		_, ok := t.Method.(*jwt.SigningMethodHMAC)
		if !ok {
			return nil, errors.New("Invalid")
		}
		return []byte(tokenSecret), nil
	})

	if err != nil {
		return nil, err
	}

	return t, nil
}

func GetClaimes(token string) (map[string]interface{}, error) {

	claimeMap := map[string]interface{}{}
	verifyToken, err := VerifyToken(token)

	if err != nil {
		return nil, err
	}

	claime, ok := verifyToken.Claims.(jwt.MapClaims)

	if ok && verifyToken.Valid {
		for k, v := range claime {
			claimeMap[k] = v
		}

		return claimeMap, nil
	}

	return nil, errors.New("can not Claim")

}
