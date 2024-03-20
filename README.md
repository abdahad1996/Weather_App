# Weather_App is an app showcasing clean architecture with Tdd approach using the open weather api with github actions as CI

- `(Lat long is hardcoded for Dortmund)`. 

- `only mandatory third party packages used`.

![example workflow](https://github.com/abdahad1996/Weather_App/actions/workflows/main.yml/badge.svg)


## Installation Guide
- clone the repo and just pressing the play button should make things work if not please contact me.
-  make sure you have the following version
Flutter 3.19.3 • channel stable 
Tools • Dart 3.3.1 • DevTools 2.31.1

## Screen Recordings
### Android
https://github.com/abdahad1996/Weather_App/assets/28492677/cfd6654b-d84b-4372-ad78-529f3a865fbb

### iOS
https://github.com/abdahad1996/Weather_App/assets/28492677/9b29adcb-788b-40ac-8cd5-1cced235d853


## Testing Strategy and Code Coverage
<img width="278" alt="image" src="https://github.com/abdahad1996/Weather_App/assets/28492677/add5d4b2-2baf-43f4-a537-aeb8da951151">

my testing strategy was based on unit tests in isolation and i used an inside out approach where i followed test driven development and tested out first domain layer, data layer and presentation layer in isolation before in the end i worked on the UI and used widget test to check if integeration worked correctly. if i had more time i would write user story tests to check if everything worked correctly.

## Architecture
<img width="981" alt="Screenshot 2024-03-20 at 7 19 17 AM" src="https://github.com/abdahad1996/Weather_App/assets/28492677/976d7452-0388-471e-abd1-6a5ce97174f3">

Diagram illustrates how we can separate Core Domain from API, Presentation and UI. Basically, Domain serves as a main layer for any feature (a.k.a business logic that is platform-agnostic).

API is in turn business logic that is platform-specific (i.e. it depends on the platform, but Core Domain does not depend on anything). Note here that APIClient lives inside Data Layer along with RemoteWeeklyForcastModel since we do not want to depend on other modules (invert the dependency) and force infrastructure components to be plugged-in.

Infrastructure components live at the boundary of the system. It could be HTTP/DIO/Any implemention you prefer. Frameworks are just plug-ins and we can easily replace them without affecting the rest of the system.

Presentation is used for not letting UI to depend on Domain. Presentation layer is mainly used for separating UI from domain models and managing the state. Thus, Presentation layer simply includes everything UI needs to render which in this case is done using Bloc .

UI is last piece in the chain and can be swapped easily (since no other layers depend on it). This diagram shows flutter as our main UI code which is used to render Android and iOS but we can reuse everything else as well for other platforms like web and desktop and only have to update the UI.

Composition Root is the most important glue part that bridges communication between domain, services and UI. This is where the entry point of our app is and in this case in the `main()` function . this layer is where all the instantiation happends and also where navigation and dependency injection takes place.

## Requirements
### Acceptance criterias
✅ It’s done when loading indicator is displayed when fetching the data.

✅It’s done when weather list item contains the day of the week abbreviation, weather condition
image.

✅ It’s done when weather details contain the day of the week, weather condition name and image,
current temperature, humidity, pressure, and wind.

✅It’s done when selecting a whether list item updates the details.

✅It’s done when weather information can be refreshed with pull to refresh gesture.

✅It’s done when an error screen with a retry button is shown when fetching the data fails.

### Extra points
✅ Supporting horizontal and vertical layouts.

✅ Changing the temperature’s unit (C/F).

## Improvements( if i had more time)
- clean up imports
- design package for the UI
- separate out the UI into more components 
- integeration tests using flutter_integeration
- performance testing
- caching both for images and data
