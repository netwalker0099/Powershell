cd C:\kworking
Invoke-WebRequest https://www.dropbox.com/s/zccp00c0twmucg9/Agent_Install.MSI?dl=1 -O Agent_Install.msi
.\Agent_Install.msi /quiet /promptrestart
