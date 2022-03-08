# Bulk Update Custom Attribues
These scripts will export and import vSphere Custom Attributes for Virtual Machines

## Requirements

PowerCLI must be installed and loaded.  A connection to a vCenter Server must be established

## Export Existing

`.\export.ps1`

This will create a csv file with the existing custom attributes.

## Bulk Edit

Open the CSV file and edit the values.  Adding a column with a new attribute is supported.  Removing colums will prevent that attribute from being updated.  Removing rows will prevent that VM from being updated.  The Name column is required and is the name of the VM to be updated.  

## Import

`.\import.ps1 <filename.csv>`

This will check for existing atributes and create newly added attributes.  Each VM in the CSV file will have the columns listed in the CSV file set as custom attribues.