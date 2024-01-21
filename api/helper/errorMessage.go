package helper

func ErrorMessage(message string) map[string]any {
	return map[string]any{
		"status":  false,
		"message": message,
	}
}
