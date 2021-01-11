
# Oifyoo Makassar

This is application for handle stok in oifyoo makassar


## TODO
#### - Change Root Folder Name
#### - Delete folder .git
#### - Change package name on Android and iOS

 - Android :
 
**AndroidManifest.xml :**

     <application android:name="io.flutter.app.FlutterApplication" android:label="TheNameOfYourApp">
     <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="your.package.name">

  **app/build.gradle**

    defaultConfig {
    	 **applicationId "your.package.name"**
    	 minSdkVersion 16
    	 targetSdkVersion 27
    	 versionCode 1
    	 versionName "1.0"
    	 testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    	 }

**Change package name  (MainActivity.java/MainActivity.kt)**

 **package your.package.name;**
 
 **From:**


    android\app\src\main\java\com\example\name

**To :**

     android\app\src\main\java\your\package\name

 - iOS


Edit file **Info.plist** in  **ios/Runner**


    <key>CFBundleIdentifier</key>
    <string>com.your.packagename</string>


### Or Lazy Way

    $ cd oifyoo_mksr (you can change it when you clone project)
    $ flutter create --org package.name project_name
    $ rm -Rf android ios
    $ mv project_name/ios .
    $ mv project_name/android .
    $ rm -Rf project_name

### Need to create script to recreate folder android and iOS

