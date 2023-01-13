package valueobjects

import (
	"errors"
	"regexp"
)

type Phone struct {
	Value string
}

func NewPhone(value string) *Phone {
	return &Phone{
		Value: value,
	}
}

func (vo *Phone) Validate() error {
	if matched, err := regexp.MatchString(`(?m)^(\d{8}|\d{4}-\d{4})$`, vo.Value); err != nil || !matched {
		return errors.New("invalid phone format")
	}

	return nil
}
