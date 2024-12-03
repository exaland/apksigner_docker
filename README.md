Build Image 

docker build -t apksigner-image .


./sign-apk.sh wearitagain.jks wearitagain 123456 123456 app-release-unsigned.apk app-release-signed.apk


docker run --rm -it apksigner-image /bin/bash



keytool -genkey -v -keystore djooni.jks -keyalg RSA -keysize 2048 -validity 10000 -alias djooni


./sign-apk.sh obbled.jks obbled 123456 123456 app-production-release-unsigned.apk app-production-release-signed.apk


keytool -genkey -v -keystore needeale.jks -keyalg RSA -keysize 2048 -validity 10000 -alias needeale
