public class DistributorIntegrationFactory {
    private static final Map<String, Type> INTEGRATION_TYPES = new Map<String, Type>{
        'NATURGY' => NaturgyIntegration.class,
        'ENDESA' => EndesaIntegration.class,
        'IBERDROLA' => IberdrolaIntegration.class
    };

    public static IDistributorIntegration createIntegration(String distributorType) {
        if (INTEGRATION_TYPES.containsKey(distributorType)) {
            return (IDistributorIntegration)INTEGRATION_TYPES.get(distributorType).newInstance();
        }
        throw new DistributorIntegrationException('No integration implementation found for distributor type: ' + distributorType);
    }

    public static IDistributorIntegration getIntegration(Switching_Request__c request) {
        if (request == null || request.Distributor__c == null) {
            throw new DistributorIntegrationException('Invalid request: missing distributor information');
        }
        return createIntegration(request.Distributor__c);
    }

    public class DistributorIntegrationException extends Exception {}
}