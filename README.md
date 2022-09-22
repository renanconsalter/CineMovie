# CineMovie

<div style="display: grid; grid-template-columns: repeat(24, auto);align-items: center;">
<div>
<img align="left" src="https://github.com/renanconsalter/CineMovie/blob/main/CineMovie/Resources/Assets.xcassets/Logo.imageset/logo.png?raw=true" alt="CineMovie logo" width="200">
</div>
<div>
<p>

![Build/Test Workflow](https://github.com/renanconsalter/CineMovie/actions/workflows/ios.yml/badge.svg)

The project consists in a application to list and get details of movies around the world.

You can navigate between Top Rated, Popular or Search movies.
    
All the information and data used in this project came from the [TMDB API](https://developers.themoviedb.org/3/getting-started/introduction).
</p>
</div>
</div>

## Features

- [x] List Top Rated & Popular movies 
- [x] Search movie by name
- [x] Movie details (genres, rating, overview, duration, year of release, etc.)
- [x] 100% programmatically UI (ViewCode)
- [x] Model-View-ViewModel-Coordinator pattern (MVVM-C)
- [x] CI/CD automated integration (build, test and lint)
- [x] Dark Mode
- [x] Pagination using Infinite Scroll
- [x] Error handling
- [x] Image caching

## Screenshots

#### iPhone 13 Pro
![CineMovie-Image1](Images/iPhone-13-Pro.png "App CineMovie iPhone-13-Pro")

#### iPhone SE (2022)
![CineMovie-Image2](Images/iPhone-SE.png "App CineMovie iPhone-SE")

## Technologies

- [Swift](https://www.swift.org)
- [UIKit](https://developer.apple.com/documentation/uikit)
- [GitHub Actions](https://github.com/features/actions)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [Conventional Commits](https://www.conventionalcommits.org)
- [GitFlow](https://www.atlassian.com/br/git/tutorials/comparing-workflows/gitflow-workflow)
- [TMDB API Documentation](https://developers.themoviedb.org/3/getting-started/introduction)

## Instructions

1. Clone or download this repository.
2. This project uses SwifLint for enforcing Swift style and conventions, so you'll need to [install it](https://github.com/realm/SwiftLint#installation).
3. Open ```.xcodeproj``` file using [Xcode](https://apps.apple.com/br/app/xcode/id497799835?mt=12).
4. Open ```TMDB-Auth-Info.plist``` file in the target root directory.
5. On the ```TMDB_API_KEY``` value field, paste your own *(v4 auth)*  secret key generated by [TMDB API](https://developers.themoviedb.org/3/getting-started/introduction).
6. Hit ```Command (⌘) + R``` and enjoy.

## Coming Soon

- [ ] Localization Strings to support more regions and languages
- [ ] Create Upcoming and Now Playing menus
- [ ] Create cast, director, crew and trailers section
- [ ] Add new feature to show trailers from YouTube using [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview)
- [ ] List and manage favorite movies using local storage
- [ ] Add snapshot tests to UI components
- [ ] Upgrade project to use Reactive Programming

## Contributing

If you have any improvement or feedback, feel free to open an issue or submit a pull request.

## Author

<b>Renan Consalter</b>
<br>
<span>
<small>iOS Engineer</small>
</span>

[![LinkedIn Badge](https://img.shields.io/badge/Linkedin-blue?style=for-the-badge&logo=Linkedin&link=https://www.linkedin.com/in/renan-consalter)](https://www.linkedin.com/in/renan-consalter)
[![Instagram Badge](https://img.shields.io/badge/Instagram-f2f2f2?style=for-the-badge&logo=Instagram&link=https://www.instagram.com/renanconsalter)](https://www.instagram.com/renanconsalter)
[![Gmail Badge](https://img.shields.io/badge/GMAIL-c14438?style=for-the-badge&logo=Gmail&logoColor=white&link=mailto:renan.consalter@gmail.com)](mailto:renan.consalter@gmail.com)
