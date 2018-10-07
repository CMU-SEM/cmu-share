# cmu-share

Please open the cmu-share.xcworkspace instead of choosing the cmu-share folder in xcode. Otherwise the app won't build successfully. (don't know why)

1. To install pod:

    % sudo gem install cocoapods

2. If extra dependencies are added to the project, pull the project and run

    % pod install

    to install all the pod dependencies

3. Naming convention for segue: startingPageToEndingPage
  
    eg. signUpTosignInSegue
  
4. Compile Failure resolution:

    1) Quit Xcode
    2) Delete cmu-share.xcworkspace, Podfile.lock, Pods(folder)
    3) Run % pod install
    4) Open cmu-share.xcworkspace
    5) Compile and run
    
