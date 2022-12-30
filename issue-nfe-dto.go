package nfebot

type IssueNFEDTO struct {
	Company  Company  `json:"company"`
	Employee Employee `json:"employee"`
	NFE      NFE      `json:"nfe"`
}
