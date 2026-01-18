# waggltest

A new Flutter project.


## Project Working

1. Scan a QR to connect to wifi of iOT device and fetch details and display 
(Wifi barcode scanning and connection is implemented and wifi details are shown but fetching iOT device details are simulated for now)
User can scan using camera or use gallery image for scanning and connecting, If the wifi is available, it will connect and show the information
or else it will show could not connect message in a snack bar.

2. Capture and attach photos from camera and gallery
The user can select multiple photos from camera or gallery, can add more, can remove from the list,
Once the user clicks on attach button, it simulates a REST API connection and shows images upload success message

3. Webrtc simulation
Since no physical IoT camera or signaling server is available, the live stream is simulated using a single local media stream. 
The mobile device camera acts as the IoT camera, and the stream is rendered locally. 
This demonstrates WebRTC integration without requiring backend infrastructure.

How it works
•	A RTCPeerConnection is created locally
•	The device camera stream is captured using getUserMedia
•	The local video stream is rendered using RTCVideoRenderer
•	No external signaling server is used
•	The stream runs entirely on-device, simulating a real-time IoT camera feed

Behavior
•	When the user opens the Live Stream screen:
•	Camera permission is requested
•	Video preview starts immediately
•	The stream stops when the screen is disposed
•	This mimics how an IoT camera stream would be viewed after device onboarding

Works in android and iOS

4. Location service to fetch GPS even on killed state, background and foreground state.
In Background and killed state, it will not work on iOS,since iOS has some restrictions on background tasks and killed state
But entirely supported on Android with proper usage of android components and follow guidelines


In android, user has to give location and notification permission, when user clicks on start tracking button,
the location coordinates is shown in the page and also a notification is shown with coordinates,
even if the user comes to home screen or kill the app.

When the location is changed in emulator or real device, it shows the updated location coordinates in the notification
without app refresh.


## Getting Started


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# waggletest
