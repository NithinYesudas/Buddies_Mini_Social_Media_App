# Buddies Social Media App
Buddies is Mini-Social Media application built using Flutter and Dart with Firebase as backend


https://user-images.githubusercontent.com/85782209/226194547-385acd57-5f06-43b6-8322-c67ecef171f0.mp4



## App Features

###  Authentication
  * Login using e-mail and password
  * SignUP using e-mail and password
  * User-detail collection including name, profile picture and bio for new users
 <p>
<image src = "https://user-images.githubusercontent.com/85782209/226190504-00369a2c-25c1-407b-ba21-17c94e4c62d4.png" width = "25%" height = "25%"/>
<image src = "https://user-images.githubusercontent.com/85782209/226191230-00f96483-0fa3-49cf-bd73-fbfaeb434296.png" width = "23%" height = "23%"/>
<image src = "https://user-images.githubusercontent.com/85782209/226191287-e25e4386-c98d-488d-9d1c-f111b1e606f9.png" width = "23%" height = "23%"/>
</p>

<h1>                         </h1>
<h1>                         </h1>





### Post  
  * Post photo posts from  gallery
  * Add captions for posts
  
  <image src = "https://user-images.githubusercontent.com/85782209/226191522-1412ac12-2032-43f5-884b-94a23141abc8.png" width = "25%" height = "25%"/>
  <h1>                         </h1>

### View posts of the users you followed on the homescreen
  * Like posts
  * Comment on posts
      * View all comments on a post
   <p> 
  <image src = "https://user-images.githubusercontent.com/85782209/226191664-f177ba79-3df3-47d1-8a83-7901fe3b9e4b.png" width = "25%" height = "25%"/>
  <image src = "https://user-images.githubusercontent.com/85782209/226191969-3f7982bf-735f-4fc3-bc44-417fe9a30561.png" width = "25%" height = "25%"/>
        
</p>
<h1>                         </h1>

### Search for users

<image src = "https://user-images.githubusercontent.com/85782209/226192165-1bbc0a6d-3a62-4393-b901-3bcb25f55011.png" width = "25%" height = "25%"/>


<h1>                         </h1>

### Realtime Messaging to followed users
<image src = "https://user-images.githubusercontent.com/85782209/226192290-72e60893-420d-4d77-96dc-67d47bb8346f.png" width = "25%" height = "25%"/>
<h1>                         </h1>

### Profile Pages
  * Follow and unfollow Users
  * View mutual friends list
  * View users posts
  * View users post count, followers count and following count
<image src = "https://user-images.githubusercontent.com/85782209/226192344-15340d47-cd1e-42f7-9d5b-9d32edee4711.png" width = "25%" height = "25%"/>
<h1>                         </h1>
  


### Story
  * View Stories/Status of followed users
  * Add story
  * Stories get autodeleted after 24 hours

## Technical Features
* Databasse - Firebase Firestore NoSQL Database
* Authentication - Firebase Authentication
* Media Storage - Firebase Storage
* Custom backend functions - Firebase Cloud functions `https://github.com/NithinYesudas/Buddies_cloud_functions`
* State Management - Provider Package
## Installation

#### 1. [Setup Flutter](https://flutter.dev/docs/get-started/install)

#### 2. Clone the repo

#### 3. Setup the firebase app

- You'll need to create a Firebase instance. Follow the instructions
  at https://console.firebase.google.com.
- Once your Firebase instance is created, you'll need to enable Google authentication.

* Go to the Firebase Console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click "Email and Password" and enable it
* From the left tabbar enable Firestore, Firebase Storage and Cloud functions
* Install Firebase cli to deploy firebase cloud functions
* The cloud functions used int this project is available in `https://github.com/NithinYesudas/Buddies_cloud_functions`
* Clone the above mentioned repo and deploy it using firebase cli
* Create an app within your Firebase instance for Android, with package name com.yourcompany.news
* Run the following command to get your SHA-1 key:

```
keytool -exportcert -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
```

* In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking "Add
  Fingerprint".
* Follow instructions to download google-services.json
* place `google-services.json` into `/android/app/`.





Double check install instructions for both

- Google Auth Plugin
    - https://pub.dartlang.org/packages/firebase_auth
- Firestore Plugin
    - https://pub.dartlang.org/packages/cloud_firestore
- All the plugins used in this project is available in:
    - https://pub.dev/
# What's Next?
* Mutliple stories
* Voice call and video call in chat
* Video sharing as posts
* Two-factor authentication
* Posts Editing
