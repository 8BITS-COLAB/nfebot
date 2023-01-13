package entities

type Specialty struct {
	Base

	Belt        string `json:"belt" gorm:"column:belt"`
	DegreeIndex int    `json:"degree_index" gorm:"column:degree_index"`
	DegreeName  string `json:"degree_name" gorm:"column:degree_name"`
	MasterID    string `json:"master_id" gorm:"column:master_id"`
	Master      Master `json:"master" gorm:"foreignKey:MasterID"`
	Name        string `json:"name" gorm:"column:name"`
}
