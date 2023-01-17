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
3. Put them inside your scheme environment variables, since this is an MVP, app will crash if you don't put them!
4. This application will always show my repositories, you can simply change it with your own, its hard coded inside the list module, list viewcontroller,
Since mine did not had any stars I put mine :'(

### Project pseudo: 

Project has 5 Main parts:

Bootstrap (Contains AppDelegate + boot sequence configurations).
Model (IPC models, and Encodable/Decodable models).
Module (Login, List, Detail)
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
3. Every network communication has its own operation (NSOperation).
4. App supports multi language.
5. App supports light theme/dark theme.
6. You can stream app logs and download them after directly from the device.
7. I took it seriously, so code is really easy to read and to write tests for.
8. Project has a simple Github action for every pull request (It checks if the repo builds and tests are passing successfuly).
9. iPad and iPhone is supported.
10. BEST UI DESIGN in the world \\:D/

TODO:
1. Improve UI.
2. Create UML diagram.
3. Add hands-off functionality.
4. Expand app functionalities.

## License

MIT.

   [github-url]: <https://www.github.com/sajacl>
   [linkedin-url]: <https://www.linkedin.com/in/sajacl/>
   [create-application-url]: <https://github.com/settings/applications/new>
