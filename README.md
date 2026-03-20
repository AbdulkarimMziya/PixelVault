# PixelVault
A modern iOS image discovery app built with Swift and UIKit that fetches and displays high-quality images from [Pixabay API](https://pixabay.com/api/docs/). Users can search, browse, and save favorite images for later.

## Features
- Search for images using custom keywords
- View results in a clean UICollectionView grid with image previews
- Tap any image to view full-screen details including author, views, downloads, and likes
- Favorite images and persist them across app launches
- Smooth scrolling using async image loading and local caching
- Prefetching images for seamless collection view performance
- Navigate between Search and Favorites using a segmented control

## Screenshots


## Requirements
- **iOS** 15.0+
- **Xcode** 14.0+
- **Swift** 5.7+
- A free API key from [Pixabay](https://pixabay.com/api/docs/)

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/AbdulkarimMziya/PixelVault.git
cd PixelVault
```

### 2. Add your API key
The app reads the API key from a `Secret` struct. Create a new Swift file inside the `PixelVault` target (e.g., `PixelVault/Supporting Files/Secret.swift`) and add:

```swift
enum Secret {
    static let apiKey = "YOUR_PIXABAY_API_KEY_HERE"
}
```

> **Note:** This file is excluded from version control to keep your key private. Never commit your API key to source control.

### 3. Open and run
Open `PixelVault/PixelVault.xcodeproj` in Xcode, select a simulator or connected device, and press **Run** (⌘R).

## Architecture
The project follows the **MVC (Model-View-Controller)** pattern and uses modern Swift concurrency (`async`/`await`) for network calls and image loading.

```
PixelVault/
├── Controllers/
│   ├── ViewController.swift                  # Main search screen
│   ├── PostDetailViewController.swift        # Detail view for a single image
│   └── FavoritePostsViewController.swift     # Displays user favorites
├── Models/
│   ├── PixelAPIModel.swift                   # Codable models for API responses
│   ├── PersistanceError.swift                # Persistence error types
│   └── AppError.swift                        # App-wide error types
├── Views/
│   └── PostCollectionViewCell.swift          # UICollectionViewCell for image posts
├── Delegates/
│   ├── CollectionViewDelegate.swift          # Main collection view delegate
│   ├── FavoritePostCollectionDelegate.swift  # Favorites collection view delegate
│   └── SearchBarDelegate.swift               # Search bar delegate
├── Network Services/
│   ├── PixelApiService.swift                 # Fetches images from Pixabay API
│   ├── NetworkHelper.swift                   # Thread-safe URLSession actor
│   ├── PersistanceService.swift              # Save/load/delete favorite posts
│   └── PersistanceManager.swift              # File path helper
└── Support/
    └── Assets.xcassets                       # App icons and image assets
```

### Key components

| Component | Responsibility |
|-----------|---------------|
| `ViewController` | Hosts search bar, segmented control, and main collection view; triggers image searches |
| `PostDetailViewController` | Full-screen scrollable detail view with author info, stats, and favorite toggle |
| `FavoritePostsViewController` | Displays a grid of favorited posts with caching and prefetching |
| `PixelApiService` | Builds API requests and decodes Pixabay JSON responses |
| `NetworkHelper` | Swift `actor` wrapping `URLSession` for safe concurrent network calls |
| `PersistanceService` | Handles saving/loading/deleting favorites using `PropertyListEncoder`/`Decoder` |
| `PersistanceManager` | Centralized helper for documents directory file paths |
| `PostCollectionViewCell` | Displays image preview, author, and favorite button |
| `CollectionViewDelegate` | Handles selection and layout for the main image grid |
| `FavoritePostCollectionDelegate` | Handles selection and layout for the favorites grid |
| `SearchBarDelegate` | Responds to search bar input and triggers API calls |

## API
Image data is sourced from [Pixabay](https://pixabay.com/api/docs/). The app requests images filtered by user search query:

```
GET https://pixabay.com/api/?key=<key>&q=<query>&image_type=photo
```

## License
This project is available for personal and educational use.# PixelVault
