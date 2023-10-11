package main

// fmt is short for format. It contains functions for format.io
import (
	"fmt"
	//"log"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

func main(){
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,		
	})
	//format.PrintLine- Prints to standard output
	fmt.Println("Hello, World!!")
}

// In Golang an title case is exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{},
		DataSourcesMap: map[string]*schema.Resource{},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true,
				Required: true,
				Description: "Bearer token for authorisation",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc: validateUUID
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

//func validateUUID(v interface{}, k string)(ws []string, errors []error) {
//	log.Println('validateUUID:start')
//	value := v.(string)
//	if _,err = uuid.Parse(value); err != nil {
//		errors = append(error, fmt.Errorf("invali UUID format"))
//	}
//	log.Println('validateUUID:end')
//}