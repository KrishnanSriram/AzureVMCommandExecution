# Execute Azure VM Commands from Azure function

This is a simple Azure function that'll allow you to execute VM commands from Azure function, in addition to the following functionality

- Start VM
- Stop VM
- Excute a script
- Check status of VM

## Setup

There are multiple sections to this setup process.

- Azure function
- VM
- Access & authorization

### VM

- Create a windows VM

### Azure Function

- Create a new Azure function
- Select Runtime to be Powershell & Windows
- After the function is created, head over to "Identity" section
- Select "System assigned" section and turn on "Status" and tap on Save. Confirm your settings
- Tap on Azure role assignments button
- Tap on Add Role assignment
- Scope: Resource Group
- Subscription: Your subscription
- Resource Group: RG that holds your VM
- Role: "Virtual MAchine Contributor"
- Tap on Save
- Your Azure function has been setup to access VM. Next step is to code.
- Create a HTTP trigger function, either on the portal or from VSCode in your local machine
- Remember to add .psd1 and .ps1 file in the root directory, level above where your run.ps1 is

## Script and parameters

## Next steps

- Break this into separate functions for code maintenance
- Instead of having a script file as a part of the function, read the file from a BLOB and execute it
