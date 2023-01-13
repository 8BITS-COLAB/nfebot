package entities

type Master struct {
	Base

	Name        string      `json:"name" gorm:"column:name"`
	Specialties []Specialty `json:"specialties" gorm:"foreignKey:MasterID"`
}
