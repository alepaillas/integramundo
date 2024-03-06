import xmlrpc.client
import sys
import re

# Function to read Odoo information from a file
def read_odoo_info(file_path):
    odoo_info = {}
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            if args.verbose:
                print("Processing line:", line)
            pairs = re.findall(r'([^=]+)\s*=\s*(.*)', line)
            for key, value in pairs:
                odoo_info[key.strip()] = value.strip().strip("'")  # Remove leading/trailing single quotes
                if args.verbose:
                    print("Matched key-value pair:", key.strip(), ":", value.strip().strip("'"))
    if args.verbose:
        print("Key-value pairs read from file:")
        for key, value in odoo_info.items():
            print(key + ":", value)
    return odoo_info.get('url'), odoo_info.get('db'), odoo_info.get('username'), odoo_info.get('password')

# Parse command line arguments
import argparse
parser = argparse.ArgumentParser(description="Retrieve attendance information from Odoo server.")
parser.add_argument("file_path", help="Path to the file containing Odoo information")
parser.add_argument("username", help="Username to search for attendances")
parser.add_argument("-v", "--verbose", action="store_true", help="Print debugging information")
args = parser.parse_args()

# Read Odoo information from the file
try:
    url, db, db_username, password = read_odoo_info(args.file_path)
except FileNotFoundError:
    print("File not found:", args.file_path)
    sys.exit(1)

if args.verbose:
    print("URL:", url)
    print("DB:", db)
    print("DB Username:", db_username)
    print("Password:", password)

# Connect to Odoo server
print("Connecting to Odoo server...")
common = xmlrpc.client.ServerProxy('{}/xmlrpc/2/common'.format(url))
uid = common.authenticate(db, db_username, password, {})

if uid:
    if args.verbose:
        print("Authentication successful. User ID:", uid)
    # Create a new instance of the Odoo API client
    models = xmlrpc.client.ServerProxy('{}/xmlrpc/2/object'.format(url))

    # Find the employee's ID based on the associated user's name
    if args.verbose:
        print("Searching for employee ID for user '{}'...".format(args.username))
    employee_id = models.execute_kw(db, uid, password,
        'hr.employee', 'search', [[['name', '=', args.username]]], {'limit': 1})

    if employee_id:
        if args.verbose:
            print("Employee found. ID:", employee_id[0])
        # Retrieve attendance entries for the employee
        if args.verbose:
            print("Retrieving attendance entries for employee '{}'...".format(args.username))
        attendance_entries = models.execute_kw(db, uid, password,
            'hr.attendance', 'search_read', [[['employee_id', '=', employee_id[0]]]])

        if attendance_entries:
            print("Attendance Entries for {}:".format(args.username))
            for entry in attendance_entries:
                print("Check-in:", entry['check_in'])
                print("Check-out:", entry['check_out'])
                print()
        else:
            print("No attendance entries found for {}.".format(args.username))
    else:
        print("Employee ID not found for user {}.".format(args.username))
else:
    print("Authentication failed.")
