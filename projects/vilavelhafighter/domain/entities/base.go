package entities

import (
	"encoding/base32"
	"fmt"
	"time"

	"gorm.io/gorm"
)

type Base struct {
	ID        string    `json:"id" gorm:"column:id;primaryKey"`
	CreatedAt time.Time `json:"created_at" gorm:"column:created_at"`
	UpdatedAt time.Time `json:"updated_at" gorm:"column:updated_at"`
}

func (b *Base) BeforeCreate(tx *gorm.DB) error {
	b.ID = base32.StdEncoding.EncodeToString([]byte(fmt.Sprintf("%d", time.Now().Unix())))

	return nil
}
