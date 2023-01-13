package valueobjects

import (
	"fmt"

	"github.com/ElioenaiFerrari/enum"
)

const (
	BlackBelt  = "black"
	BlueBelt   = "blue"
	BrownBelt  = "brown"
	GreenBelt  = "green"
	OrangeBelt = "orange"
	PurpleBelt = "purple"
	RedBelt    = "red"
	WhiteBelt  = "white"
	YellowBelt = "yellow"
)

type Belt struct {
	Value string
}

func NewBelt(value string) *Belt {
	return &Belt{
		Value: value,
	}
}

func (vo *Belt) Validate() error {
	validBelts := []string{
		BlackBelt,
		BlueBelt,
		BrownBelt,
		GreenBelt,
		OrangeBelt,
		PurpleBelt,
		RedBelt,
		WhiteBelt,
		YellowBelt,
	}
	e := enum.New(validBelts...)

	if !e.IsValid(vo.Value) {
		return fmt.Errorf("%+v", validBelts)
	}

	return nil
}
