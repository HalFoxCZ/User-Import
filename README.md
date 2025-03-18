# User-Import
Script for importing users from csv / json

Instructions for usage:

1. Download this zip folder from GitHub.
2. Unzip this folder.
3. Find path to your csv/json file with users.
4. Make sure the file format is valid for .
5. Open PowerShell as **<u>administrator</u>**
6. Use cd command to the folder where "**<u>Import-Users.ps1</u>**" is located.
7. run this command : ``` .\Import-Users.ps1 -FilePath "C:\Path\To\Users.csv"```  (For JSON just change the end to .json instead of .csv)
8. Script will tell you if all users were imported. 
9. If any users are missing or failed to import, check syntax of your CSV or JSON file.

## Format example for CSV:
<pre>
id,first_name,last_name,email,date
123,John,Smith,john.smith@example.com,2024-03-18
456,Jane,Doe,jane.doe@example.com,2024-03-18
789,Bob,Johnson,bob.johnson@example.com,2024-03-18
</pre>
---

## Format example for JSON:

<pre>
[
  {
    "id": 123,
    "first_name": "John",
    "last_name": "Smith",
    "email": "john.smith@example.com",
    "date": "2024-03-18"
  },
  {
    "id": 456,
    "first_name": "Jane",
    "last_name": "Doe",
    "email": "jane.doe@example.com",
    "date": "2024-03-18"
  },
  {
    "id": 789,
    "first_name": "Bob",
    "last_name": "Johnson",
    "email": "bob.johnson@example.com",
    "date": "2024-03-18"
  }
]
</pre>