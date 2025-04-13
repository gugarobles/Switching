public interface IDistributorIntegration {
    // Método para enviar una solicitud de switching
    void sendRequest();
    
    // Método para procesar una respuesta
    void processResponse();
    
    // Método para validar una solicitud antes de enviarla
    Boolean validateRequest(Switching_Request__c request);
    
    // Método para obtener la configuración de la distribuidora
    Switching_Configuration__c getConfiguration();

    // Método para generar el XML de la solicitud
    String generateRequest();

    // Método para obtener el país
    String getCountry();

    // Método para obtener el tipo de proceso
    String getProcessType();

    // Método para procesar una solicitud
    void processRequest();
}