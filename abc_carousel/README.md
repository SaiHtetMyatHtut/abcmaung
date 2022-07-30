TODO: This package is created for instance carousel for ABC_Maung Project by
Arkar Mann Aung. Dec 13 2021

## Features

TODO: Carousel Image set in List<AssetImage> [
    AssetImage('assets/home/carousel.png'),
    AssetImage('assets/home/carousel.png'),
    AssetImage('assets/home/carousel.png'),
    AssetImage('assets/home/carousel.png'),
] Instance and padding set by EdgesInsets, default parameter intervel(milisecond), speed(milisecond) will be set.

## Getting started
TODO: (new) ABCCarousel ABCCarousel({
  Key? key,
  required EdgeInsets edgeInsets,
  required List<AssetImage> children,
  int intervel = 5000, // auto slide intervel time by milisecond
  int speed = 500, // auto slide speed by milisecond
})

## Usage

    ABCCarousel(
        intervel: 5000,
        speed: 1000,
        edgeInsets: const EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 5.0),
        children: const[
            AssetImage('assets/home/carousel.png'),
            AssetImage('assets/home/carousel.png'),
            AssetImage('assets/home/carousel.png'),
            AssetImage('assets/home/carousel.png'),
        ]
    )

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
