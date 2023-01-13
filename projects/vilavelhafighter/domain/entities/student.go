package entities

type Student struct {
	Base

	Belt          string         `json:"belt" gorm:"column:belt"`
	Email         string         `json:"email" gorm:"column:email"`
	Name          string         `json:"name" gorm:"column:name"`
	ImageURL      string         `json:"image_url" gorm:"column:image_url"`
	PaymentEvents []PaymentEvent `json:"payment_events" gorm:"foreignKey:StudentID"`
	Phone         string         `json:"phone" gorm:"column:phone"`
}
