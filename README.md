New York Times Articles Reader
-------------

This application is a reader for the New York Times Most Popular Articles from the last 7 days 

> **Usage:**

> - Clone the repository to a folder you want.
> - Open the project with Xcode
> - Change the bundle id in project settings
> - Change the development team in project settings
> - Register for an API key at https://developer.nytimes.com/
> - Insert your API key into the ArticlesTableViewController.swift file (line 21)
> - Run an the app. 

> **Options:**

> - You can modify the choosen sections and the peroid (how far back, in days, the API returns results for) at line 52 
> - The mentioned period is an enum with 1, 7 and 30 days options.
> - For changing the detail screen to real in-broswer news-reading experience: uncomment the lines at 151-154, and comment out the line 148 


