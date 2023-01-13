package usecases_test

import (
	"errors"
	"testing"

	"github.com/ElioenaiFerrari/vilavelhafighter/__tests__/mocks"
	"github.com/ElioenaiFerrari/vilavelhafighter/app/dtos"
	"github.com/ElioenaiFerrari/vilavelhafighter/app/usecases"
	"github.com/bxcodec/faker/v3"
	"github.com/golang/mock/gomock"
)

func setup(t *testing.T) (ctrl *gomock.Controller, db *mocks.MockDB, useCase *usecases.CreateMasterUseCase) {
	ctrl = gomock.NewController(t)
	db = mocks.NewMockDB(ctrl)
	useCase = usecases.NewCreateMasterUseCase(db)

	return
}

func TestCreateMaster(t *testing.T) {
	t.Run("when given valid params, should returns entity", func(t *testing.T) {
		ctrl, db, useCase := setup(t)
		defer ctrl.Finish()

		dto := &dtos.CreateMasterDTO{Name: faker.Name()}
		db.EXPECT().Create(gomock.Any()).Return(db)
		db.EXPECT().Error().Return(nil)

		entity, err := useCase.Exec(dto)
		gomock.Eq(err).Matches(nil)
		gomock.Eq(entity.Name).Matches(dto.Name)
	})

	t.Run("when given invalid params, should returns error", func(t *testing.T) {
		ctrl, db, useCase := setup(t)
		defer ctrl.Finish()

		dto := &dtos.CreateMasterDTO{Name: faker.Name()}
		db.EXPECT().Create(gomock.Any()).Return(db).Times(1)
		db.EXPECT().Error().Return(errors.New("hello")).Times(1)

		entity, err := useCase.Exec(dto)
		gomock.Eq(err.Error()).Matches("hello")
		gomock.Eq(entity).Matches(nil)
	})
}
