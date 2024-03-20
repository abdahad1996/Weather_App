# Weather_App
![example workflow](https://github.com/abdahad1996/Weather_App/actions/workflows/main.yml/badge.svg)
## Coverage
<img width="278" alt="image" src="https://github.com/abdahad1996/Weather_App/assets/28492677/add5d4b2-2baf-43f4-a537-aeb8da951151">

## Architecture
<img width="981" alt="Screenshot 2024-03-20 at 7 19 17 AM" src="https://github.com/abdahad1996/Weather_App/assets/28492677/976d7452-0388-471e-abd1-6a5ce97174f3">

Diagram illustrates how we can separate Core Domain from API, Presentation and UI. Basically, Domain serves as a main layer for any feature (a.k.a business logic that is platform-agnostic).

API is in turn business logic that is platform-specific (i.e. it depends on Foundation, but Core Domain does not depend on anything). Note here that APIClient lives inside Data Layer along with RemoteWeeklyForcastModel since we do not want to depend on other modules (invert the dependency) and force infrastructure components to be plugged-in.

Infrastructure components live at the boundary of the system. It could be HTTP/DIO/Any implemention you prefer. Frameworks are just plug-ins and we can easily replace them without affecting the rest of the system.

Presentation is used for not letting UI to depend on Domain. Presentation layer is mainly used for separating UI from domain models and managing the state. Thus, Presentation layer simply includes everything UI needs to render which in this case is done using Bloc .

UI is last piece in the chain and can be swapped easily (since no other layers depend on it). This diagram shows flutter as our main UI code which is used to render Android and iOS but we can reuse everything else as well for other platforms like web and desktop.

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

an app showcasing clean architecture with Tdd approach using the open weather api with github actions as CI
