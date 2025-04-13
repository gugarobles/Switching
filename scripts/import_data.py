import requests
import json
import os
from datetime import datetime

# Configuración de Salesforce
SF_INSTANCE_URL = os.environ.get('SF_INSTANCE_URL')
SF_ACCESS_TOKEN = os.environ.get('SF_ACCESS_TOKEN')

# Headers para las llamadas a la API
headers = {
    'Authorization': f'Bearer {SF_ACCESS_TOKEN}',
    'Content-Type': 'application/json'
}

def create_composite_request(records, object_name):
    """Crea una solicitud compuesta para insertar registros"""
    sub_requests = []
    for record in records:
        sub_request = {
            "method": "POST",
            "url": f"/services/data/v58.0/sobjects/{object_name}",
            "referenceId": record['attributes']['referenceId'],
            "body": {k: v for k, v in record.items() if k != 'attributes'}
        }
        sub_requests.append(sub_request)
    
    return {
        "compositeRequest": sub_requests,
        "allOrNone": True
    }

def process_records(records, object_name):
    """Procesa los registros y los inserta en Salesforce"""
    composite_request = create_composite_request(records, object_name)
    response = requests.post(
        f"{SF_INSTANCE_URL}/services/data/v58.0/composite",
        headers=headers,
        json=composite_request
    )
    
    if response.status_code == 200:
        print(f"Successfully processed {len(records)} records for {object_name}")
        return response.json()
    else:
        print(f"Error processing records for {object_name}: {response.text}")
        return None

def main():
    # Leer los archivos JSON
    with open('force-app/main/default/data/Service__c.json') as f:
        service_records = json.load(f)['records']
    
    with open('force-app/main/default/data/Switching_Request__c.json') as f:
        request_records = json.load(f)['records']
    
    with open('force-app/main/default/data/Switching_Notification__c.json') as f:
        notification_records = json.load(f)['records']
    
    with open('force-app/main/default/data/Switching_Configuration__c.json') as f:
        config_records = json.load(f)['records']
    
    with open('force-app/main/default/data/XML_Template__c.json') as f:
        xml_template_records = json.load(f)['records']
    
    with open('force-app/main/default/data/Message_Template__c.json') as f:
        message_template_records = json.load(f)['records']
    
    # Procesar los registros en el orden correcto
    print("Starting data import...")
    
    # 1. Insertar registros de Service__c
    service_response = process_records(service_records, 'Service__c')
    if not service_response:
        print("Failed to import Service__c records")
        return
    
    # 2. Insertar registros de Switching_Request__c
    request_response = process_records(request_records, 'Switching_Request__c')
    if not request_response:
        print("Failed to import Switching_Request__c records")
        return
    
    # 3. Insertar registros de Switching_Notification__c
    notification_response = process_records(notification_records, 'Switching_Notification__c')
    if not notification_response:
        print("Failed to import Switching_Notification__c records")
        return
    
    # 4. Insertar registros de Switching_Configuration__c
    config_response = process_records(config_records, 'Switching_Configuration__c')
    if not config_response:
        print("Failed to import Switching_Configuration__c records")
        return
    
    # 5. Insertar registros de XML_Template__c
    xml_template_response = process_records(xml_template_records, 'XML_Template__c')
    if not xml_template_response:
        print("Failed to import XML_Template__c records")
        return
    
    # 6. Insertar registros de Message_Template__c
    message_template_response = process_records(message_template_records, 'Message_Template__c')
    if not message_template_response:
        print("Failed to import Message_Template__c records")
        return
    
    print("Data import completed successfully!")

if __name__ == "__main__":
    main() 