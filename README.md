# themoviedb
Create an iOS application for browsing the latest movies, display a short detail page of a selected movie, and play a short movie trailer. For this purpose, you are going to use “The Movie Database API” (https://developers.themoviedb.org/3/getting-started). To use the API you need to register and get an “api_key” (https://www.themoviedb.org/account/signup ). 
1. The first screen of your application should display an easy catalog with the most popular movies. Use the following API call to get the list of the movies: https://api.themoviedb.org/3/movie/popular?api_key=### (for more info see: https://developers.themoviedb.org/3/movies/get-popular-movies). 
            a. It should support pagination 
            b. The first page to load on the screen page = 10 
            c. It should load the previous &amp; next pages on demand i.e both side (earlier and next) pagination. 
            d. Show a snack bar/toast message if there is no further record, i.e no earlier record for page = 1 and no next records for the last page, 
2. After selecting one of the titles the application should navigate you to the detail page of the movie (see Picture 3 and Picture 4). Use the following API call to load the needed detail information: https://api.themoviedb.org/3/movie/271110?api_key=### (for more information see: https://developers.themoviedb.org/3/movies/get-movie-details) 
3. After pressing the “Watch Trailer” the application should display a full-screen movie player and should automatically start the playback (to get the needed URLs to use the “movie/#MOVIE_ID#/videos” API call). After the trailer is finished the player should be automatically closed, and the app should return to the detail page. The playback can be also canceled by pressing the “Done” button. 
4. Handle “offline mode” in the app. 
5. OPTIONAL TASK 
                1: create a search functionality in the catalog page by filtering content downloaded. 
                2: support both iOS device types (iPad and iPhone).
                3: create at least one unit test!
                4: Use some tool to generate the documentation matching Apple’s official reference documentation. https://developer.apple.com/documentation/swift




# How To Build
download the Project and run xcworkspace in xcode 
select simulator and click run button on top left corner 
if you want to run on device then you need developer account
