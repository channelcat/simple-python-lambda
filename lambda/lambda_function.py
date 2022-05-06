import libraries
import json
import requests

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps({
            "success": True,
            "ip": requests.get('http://checkip.amazonaws.com/').text.strip()
        })
    }
