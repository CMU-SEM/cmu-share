# cmu-share

Please open the cmu-share.xcworkspace instead of choosing the cmu-share folder in xcode. Otherwise the app won't build successfully. (don't know why)

1. To install pod:

% sudo gem install cocoapods

2. If extra dependencies are added to the project, pull the project and run

% pod install

to install all the pod dependencies

3. Naming convention for segue:

<starting page>To<ending page>
  
  eg. signUpTosignInSegue
  

