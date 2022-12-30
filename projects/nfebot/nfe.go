package nfebot

type NFE struct {
	Code        string `json:"code"`
	Description string `json:"description"`
	Quantity    int    `json:"quantity"`
	UnitValue   int    `json:"unit_value"`
}
