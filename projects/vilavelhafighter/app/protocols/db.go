package protocols

type DB interface {
	Create(value interface{}) DB
	Error() error
}
