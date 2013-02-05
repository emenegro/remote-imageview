Replacement for `UIImageView` that asynchronously shows an image downloaded from an URL.

While the download is running an activity indicator is shown over the view. A block is invoked when the image has finishing download.

Installation instructions
=========================

1. Import `MNMremoteImageView` files into your project.
2. Create the image the as always, from a XIB or initializing with the regular constructors.
3. You can show an image from an URL this way

    [remoteImageView displayImageFromURL:url
                       completionHandler:^(NSError *error) {
                          // Do something 
                       }];

4. You can see some examples in `ViewController` class.

Documentation
=============

Execute `appledoc appledoc.plist` in the root of the project path to generate documentation. 