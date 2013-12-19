
# OCUDL

OCUDL is an experiment to bring user defined literals to Objective-C. A literal is a shorthand expression that creates a value of a certain type. For example, `25ul` creates an unsigned long of *25*, and `@"hello"` creates an NSString of *hello*. User defined literals bring this brevity and expressivity to our own types.  
 
Literals are usually baked right in to the compiler. OCUDL, however, does not extend the compiler; it simply uses what already exists in the Objective-C runtime. You can learn more about OCUDL's internals at [OCUDL In Depth](http://dbachrach.com/posts/ocudl-in-depth/).

The [OCUDL source](https://github.com/dbachrach/OCUDL) is available on GitHub under the [MIT License](http://opensource.org/licenses/MIT). Documentation is at [CocoaDocs](http://cocoadocs.org/docsets/OCUDL/). Pull requests, bugs, and issues are welcome.

## Example

OCUDL defines literals using prefixes or suffixes. Here, we've defined a UIColor literal that uses the *#* prefix.

```objc
// Creates a UIColor
myView.backgroundColor = $(#FE22AA);
```

The *$* tells OCUDL to interpret this value as a user defined literal. If user defined literals were baked right into the language, you wouldn't need the *$* at all.

Explore the Useful Literals section for additional examples of literals for UIKit and Foundation types.

## Experimental

OCUDL is an experiment, and might not be appropriate for your project. Please read [OCUDL In Depth](http://dbachrach.com/posts/ocudl-in-depth/) to understand what's happening behind the scenes. **NOTE: OCUDL has been updated to not rely upon method swizzling.**

## Using OCUDL

You can get OCUDL through [CocoaPods](http://cocoapods.org). You can [learn more] about dependency management with CocoaPods, but we'll cover the basics.

Install CocoaPods:

``` bash
gem install cocoapods
pod setup
```

Create a `Podfile`, in your project directory. Add the following lines:

```
platform :ios

pod 'OCUDL'
```

Then install the Podfile:

``` bash
pod install
```

CocoaPods will create a `.xcworkspace` for you if you haven't already created one. You will need to open your code in XCode through the workspace file and not the `.xcodeproj` file from now on.

Now your project is all set to start using OCUDL. Get started by importing the header:

```objc
#import <OCUDL/OCUDL.h>
```

To create a literal for your class, first implement the `OCUDLClass` protocol.

```objc
@interface YourClass : NSObject <OCUDLClass>
```

Then, register a literal prefix or suffix for your class.

```objc
@implementation YourClass
+ (void)load
{
    [[OCUDLManager defaultManager] registerSuffix:@"your-suffix" forClass:[YourClass class]];
}
@end
```

Finally, implement the literal initializer.

```objc
- (id)initWithLiteral:(NSString*)literal suffix:(NSString*)suffix
{
    if (self = [super init]) {
        // ...
    }
    return self;
}
```

Now anywhere in your project you can use your literal.

```objc
YourClass *foo = $(555your-suffix);
```

## Blocks

Sometimes you might want to add literals for classes you didn't author. Instead of using categories, just use OCUDL's support for blocks.

```objc
[[OCUDLManager defaultManager] registerPrefix:@"#" forBlock:^id(NSString *literal, NSString *prefix) {
    // return a new instance of some class
}];
```

## Useful literals

OCUDL comes with a bunch of useful built-in literals for UIKit and Foundation types.

```
#import <OCUDL/OCUDLBuiltins.h>

// ...

[OCUDLBuiltins use];
```

After you `[OCUDLBuiltins use]`, you can take advantage of all the built-in literals anywhere in your code.

### NSNull

```objc
NSNull *n = $(null);
```

### NSURL

```objc
NSURL *url = $(http:www.apple.com);
NSURL *url2 = $(https:www.gmail.com);
```

### NSUUID

```objc
NSUUID *uuid = $(68753A44-4D6F-1226-9C60-0050E4C00067uuid);
```

### UIColor

```objc
UIColor *color = $(#FE22AA);
UIColor *color2 = $(#FFF);
UIColor *color3 = $(#yellow);
```

### UIImage

```objc
UIImage *img = $(pic.img);
```

### UINib

```objc
UINib *nib = $(MyNib.xib);
```

### UIStoryboard

```objc
UIStoryboard *board = $(MyBoard.storyboard);
```


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/dbachrach/ocudl/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

