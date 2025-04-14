public class Switching_Configuration {
    public String Country { get; set; }
    public String ProcessType { get; set; }
    public String Template { get; set; }
    public String IntegrationClass { get; set; }
    public Boolean Active { get; set; }
    
    public Switching_Configuration(String country, String processType, String template, String integrationClass) {
        this.Country = country;
        this.ProcessType = processType;
        this.Template = template;
        this.IntegrationClass = integrationClass;
        this.Active = true;
    }
}