package nfebot

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/chromedp/chromedp"
)

type NFEBot struct {
	URL string
}

func New() *NFEBot {
	return &NFEBot{
		URL: "http://sefa.serra.es.gov.br:8080/tbw/loginNFEContribuinte.jsp?execobj=NFERelacionados",
	}
}

func (bot *NFEBot) IssueNFE(issueNFEDTO IssueNFEDTO) ([]byte, error) {
	ctx, cancel := chromedp.NewContext(
		context.Background(),
		chromedp.WithLogf(log.Printf),
	)
	defer cancel()

	ctx, cancel = context.WithTimeout(ctx, time.Second*5)
	defer cancel()

	var buf []byte

	if err := chromedp.Run(
		ctx,
		chromedp.Navigate(bot.URL),
		chromedp.WaitVisible(LoginInputElement),
		chromedp.SetValue(LoginInputElement, issueNFEDTO.Employee.Login),
		chromedp.SetValue(PasswordInputElement, issueNFEDTO.Employee.Password),
		chromedp.Click(LoginButtonElement),
		chromedp.WaitVisible(NewNoteButtonElement),
		chromedp.Click(NewNoteButtonElement),
		chromedp.WaitVisible(ServiceTypeSelectElement),
		chromedp.SetValue(ServiceTypeSelectElement, issueNFEDTO.Employee.ServiceTypeCode),
		chromedp.SetValue(CompanyDocumentNumberInputElement, issueNFEDTO.Company.DocumentNumber),
		chromedp.SetValue(CompanyNameInputElement, issueNFEDTO.Company.Name),
		chromedp.SetValue(CompanyRegistryInputElement, issueNFEDTO.Company.DocumentNumber),
		chromedp.SetValue(CompanyZipCodeInputElement, issueNFEDTO.Company.ZipCode),
		chromedp.SetValue(CompanyDistrictInputElement, issueNFEDTO.Company.District),
		chromedp.SetValue(CompanyCityInputElement, issueNFEDTO.Company.City),
		chromedp.SetValue(CompanyStateInputElement, issueNFEDTO.Company.State),
		chromedp.SetValue(CompanyBillingAddressInputElement, issueNFEDTO.Company.BillingAddress),
		chromedp.SetValue(CompanyEmailInputElement, issueNFEDTO.Company.Email),
		chromedp.SetValue(NFECodeInputElement, issueNFEDTO.NFE.Code),
		chromedp.SetValue(NFEDescriptionInputElement, issueNFEDTO.NFE.Description),
		chromedp.SetValue(NFEQuantityInputElement, fmt.Sprintf("%d", issueNFEDTO.NFE.Quantity)),
		chromedp.SetValue(NFEUnitValueInputElement, fmt.Sprintf("%d", issueNFEDTO.NFE.UnitValue)),
		chromedp.SetValue(NFETotalValueInputElement, fmt.Sprintf("%d", issueNFEDTO.NFE.UnitValue)),
		chromedp.Click(NFEAddButtonElement),
		chromedp.Sleep(time.Second),
		chromedp.FullScreenshot(&buf, 100),
	); err != nil {
		return nil, err
	}

	return buf, nil
}

func (bot *NFEBot) WithRetries(retries int, issueNFEDTO IssueNFEDTO) ([]byte, error) {
	image, err := bot.IssueNFE(issueNFEDTO)

	if err != nil {
		return nil, err
	}

	if retries > 0 {
		if err != nil {
			return bot.WithRetries(retries-1, issueNFEDTO)
		}
	}

	return image, nil
}
