package entities

type PaymentEvent struct {
	Base

	DiscountPercentage int     `json:"discount_percentage" gorm:"column:discount_percentage"`
	GrossPrice         int     `json:"gross_price" gorm:"column:gross_price"`
	LiquidPrice        int     `json:"liquid_price" gorm:"column:liquid_price"`
	StudentID          string  `json:"student_id" gorm:"column:student_id"`
	Student            Student `json:"student" gorm:"foreignKey:StudentID"`
	Type               string  `json:"type" gorm:"column:type"`
}
