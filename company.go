package nfebot

type Company struct {
	BillingAddress string `json:"billing_address"`
	City           string `json:"city"`
	District       string `json:"district"`
	DocumentNumber string `json:"document_number"`
	Email          string `json:"email"`
	Name           string `json:"name"`
	PersonType     string `json:"person_type"`
	State          string `json:"state"`
	ZipCode        string `json:"zip_code"`
}
