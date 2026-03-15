# NorthPoint Mobile
Official mobile app for NorthPoint Church in Muncie, Indiana.
[Official Website](https://www.northpointmuncie.com/)
![Logo](https://github.com/JasonYoder2026/northpoint_church_app/blob/main/assets/images/logo.png)
<br>
## Our system
```mermaid
flowchart TD
    A["Flutter App (Client)"]  <--> B
    B["Supabase (Database)"] <--> C
    B <--> D
    C["YouTube API (Google Cloud)"]
    D["Planning Center API"]
```

## Development
To contribute to this project follow these steps:
- Have a working Flutter environment
- Clone this repo
- Get a copy of the .env file from me at jason.yoder2023@gmail.com
- Run ```flutter pub get``` from the root of the repository
- Start programming!
