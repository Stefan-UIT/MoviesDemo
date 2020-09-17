# Movies Demo

An application to help our users discover movies easily. For the UI:

           Discovery         ->          Movie Detail           ->         Booking 

![](demo_files/Discovery.png)    ![](demo_files/MovieDetail.png)   ![](demo_files/Booking.png)

##  Requirements
- iOS 13.4+
- Xcode 11
### Installations
Remember to run ``` pod install ``` before running the project.

##  Resources
- ``` SwiftLint ```: a tool to enforce Swift style and conventions. Keeping a codebase consistent and maintainable.
- ``` Moya ``` : a network abstraction layer that leverages Swift’s APIs like enums to make working with the network layer better than ever.
- ``` SDWebImage ```: an asynchronous memory + disk image caching with automatic cache expiration handling, support background image decompression to avoid frame rate drop.

##  Structure
- App flow: Loading -> Movies (Discovery) -> MovieDetail -> Booking
- MVVM: Model - View - ViewModel
- Api services:
    + NetworkManager contains a provider which will be the main object that we will use to interact with any network service.
    + A Service (MovieService) should conforms to a protocol named "TargetType", which requires the entire endpoints information of the service, such as: baseUrl,        header, path, parameters, method, task(make request), etc..
    ( by using enum, case by case, entirely type-safe 🎉.)
    
    => To summarize: Provider -> Service(MovieService..) -> Endpoint -> make Request.

## That's it! Enjoy the app!
