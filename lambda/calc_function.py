def lambda_handler(event, context):
    operator = event['action']
    param1 = int(event.get('param1',1))
    param2 = int(event.get('param2',2))
    print('Received action:', operator)
    print('Received param1:', param1)
    print('Received param2:', param2)

    if operator == 'add':
        result = param1 + param2
    elif operator == 'sub':
        result = param1 - param2
    elif operator == 'mul':
        result = param1 * param2
    elif operator == 'div':
        result = param1 / param2
    else:
        result = 'Invalid action specified'

    print('Result:', result)

    response = {'result': result}
    return response