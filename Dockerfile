# Utiliser une image de base légère avec OpenJDK 11
FROM openjdk:11-jdk-slim

# Définir les variables d'environnement pour le SDK Android
ENV ANDROID_SDK_ROOT="/sdk"
ENV PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/30.0.3:$PATH"

# Installer des dépendances nécessaires
RUN apt-get update && apt-get install -y wget unzip

# Télécharger les outils de ligne de commande du SDK Android
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O /sdk/tools.zip && \
    unzip /sdk/tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools && \
    rm /sdk/tools.zip && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest

# Accepter les licences des SDKs
RUN yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses

# Installer l'outil apksigner via SDK Manager (dans le package build-tools)
RUN $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --install "build-tools;30.0.3" "platform-tools"

# Vérifier si apksigner est correctement installé
RUN ls $ANDROID_SDK_ROOT/build-tools/30.0.3/

# Définir le répertoire de travail
WORKDIR /app

COPY app-production-release-unsigned.apk /app/app-production-release-unsigned.apk

COPY obbled.jks /app/obbled.jks
# Copier et donner les permissions d'exécution au script de signature
COPY sign-apk.sh /app/sign-apk.sh
RUN chmod 755 /app/sign-apk.sh

# Commande par défaut : afficher l'aide de apksigner
CMD ["apksigner", "--help"]
