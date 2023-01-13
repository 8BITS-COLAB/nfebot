package usecases

import (
	"github.com/ElioenaiFerrari/vilavelhafighter/app/dtos"
	"github.com/ElioenaiFerrari/vilavelhafighter/app/protocols"
	"github.com/ElioenaiFerrari/vilavelhafighter/domain/entities"
)

type CreateMasterUseCase struct {
	db protocols.DB
}

func NewCreateMasterUseCase(db protocols.DB) *CreateMasterUseCase {
	return &CreateMasterUseCase{db}
}

func (uc *CreateMasterUseCase) Exec(payload *dtos.CreateMasterDTO) (*entities.Master, error) {
	entity := &entities.Master{
		Name: payload.Name,
	}

	if err := uc.db.Create(&entity).Error(); err != nil {
		return nil, err
	}

	return entity, nil
}
