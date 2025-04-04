# labDataOrganization 👩‍🔬
* Scripts to organiza and streamline data obtained from the lab*

### streammlineICP-OES.py
- This script appends results to a csv in Google Drive
- There needs to be an iCP-OES.csv shortcut on your Google Drive Desktop
-  There can be no **'UNCAL'** values within the file that is being parsed

### MIP_XRD_data_extranction.py
- This script extracts and sorts results into folders
- Need to install [PyPDF2](https://pypi.org/project/PyPDF2):      `pip install PyPDF2`
- When a `.rar` file is sent by MSE Supplies, please manually extract it
  - Only ZIP files can be extracted via the script
