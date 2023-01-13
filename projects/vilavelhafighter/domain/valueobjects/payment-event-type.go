package valueobjects

import (
	"fmt"

	"github.com/ElioenaiFerrari/enum"
)

const (
	BuyBandagePaymentEventType    = "buy_bandage"
	BuyGlovePaymentEventType      = "buy_glove"
	BuyMouthGuardPaymentEventType = "buy_mouth_guard"
	BuyShortPaymentEventType      = "buy_short"
	BuyShinGuardPaymentEventType  = "buy_shin_guard"
	BuyShirtPaymentEventType      = "buy_shirt"
	MonthlyPaymentEventType       = "monthly"
	TypeRegistryPaymentEventType  = "registry"
)

type PaymentEventType struct {
	Value string
}

func NewPaymentEventType(value string) *PaymentEventType {
	return &PaymentEventType{
		Value: value,
	}
}

func (vo *PaymentEventType) Validate() error {
	validPaymentTypes := []string{
		BuyBandagePaymentEventType,
		BuyGlovePaymentEventType,
		BuyMouthGuardPaymentEventType,
		BuyShortPaymentEventType,
		BuyShinGuardPaymentEventType,
		BuyShirtPaymentEventType,
		MonthlyPaymentEventType,
		TypeRegistryPaymentEventType,
	}
	e := enum.New(validPaymentTypes...)

	if !e.IsValid(vo.Value) {
		return fmt.Errorf("%+v", validPaymentTypes)
	}

	return nil
}
