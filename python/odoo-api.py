# This Python file uses the following encoding: utf-8

import xmlrpc.client

# Odoo server information
url = 'http://integramundo.odoo.com'
db = 'integramundo'
username = 'management@integramundo.cl'
password = 'e929a1fa58ea04dff2e2ed2c8424ef36e3ffa87e'

# Connect to the Odoo server
common = xmlrpc.client.ServerProxy('{}/xmlrpc/2/common'.format(url))
uid = common.authenticate(db, username, password, {})

if uid:
    # Logged in successfully, now create an object for calling methods
    models = xmlrpc.client.ServerProxy('{}/xmlrpc/2/object'.format(url))

    # Example: Call the search_read method to retrieve records from a model
    records = models.execute_kw(db, uid, password,
                                 'res.partner', 'search_read',
                                 [[['is_company', '=', True]]],
                                 {'fields': ['name', 'email'], 'limit': 5})
    
    # Print retrieved records
    for record in records:
        print("Name:", record['name'], "- Email:", record['email'])
else:
    print("Login failed. Please check your credentials.")
