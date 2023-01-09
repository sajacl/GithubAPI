# GithubAPI
The is a mvp project, that will be used for a code challenge.

- [Github][github-url]
- [Linkedin][linkedin-url]

Hi dear reader,
Thanks for the exciting challenge!

### This challenge will contain specific parts:

1. Authentication via Github
2. List off repositories
3. Details of individual repository

### How to run.
There some steps to be able to run the application properly:
1. Follow this [Github api][create-application-url], to be able to create your own application.
2. You will receive 3 main things that you will need to configure the app by them:
  1. Client id
  2. Client secret 
  3. Call back url
3. Put them inside your scheme environment variables.
4. This application will always show my repositories, you can simply change it with your own, its hard coded inside the list module, list viewcontroller.

### Project pseudo: 

Project has 5 Main parts
Bootstrap
Model
Module
Utils
Resources

## Tech Stack

| Module | Structure |
| ------ | ------ |
| AppDelegate | AppDelegateCompsotie + AppDelegateFactory |
| Login | UIKit + MVVM |
| List | UIKit + Viper |
| Detail | UIKit + MVC |

## Features

1. There is no sharing secrets, since every developer has to create and config their own application and update XCode environment.
2. App credentials are stored in Keychain, combining it with 1 leads to no data leak.
3. Network communications have their own operations (NSOperation).
4. App supports multi language
5. App supports light theme/dark theme.
6. You can stream app logs and download them after directly from the device.
7. I took it seriously, so code is really easy to read and to write tests.
8. BEST UI DESIGN in the world \:D/

## License

MIT.

   [github-url]: <https://www.github.com/sajacl>
   [linkedin-url]: <https://www.linkedin.com/in/sajacl/>
   [create-application-url]: <https://github.com/settings/applications/new>
