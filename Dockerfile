FROM ubuntu:16.04
MAINTAINER Daniel Kinsman <danielkinsman@riseup.net>

ARG GODOT_VERSION=2.1.4

RUN apt-get update -qq \
    && apt-get install -y -qq curl unzip software-properties-common ca-certificates sudo zip

RUN mkdir -p /root/.godot/
RUN curl -s -L -o godot_export_templates.zip -C - https://downloads.tuxfamily.org/godotengine/$GODOT_VERSION/Godot_v$GODOT_VERSION-stable_export_templates.tpz \
    && unzip godot_export_templates.zip -d /root/.godot/ \
    && rm -f godot_export_templates.zip

RUN mkdir -p /opt/
RUN curl -s -L -o godot_server.zip -C - https://downloads.tuxfamily.org/godotengine/$GODOT_VERSION/Godot_v$GODOT_VERSION-stable_linux_server.64.zip \
    && unzip godot_server.zip -d /opt/ \
    && rm -f godot_server.zip
RUN ln -s /opt/Godot_v$GODOT_VERSION-stable_linux_server.64 /usr/local/bin/godot_server


# Android export
RUN apt-get install -y -qq openjdk-8-jdk-headless
RUN keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore /root/debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999

RUN mkdir -p /opt/android
RUN curl -s -L -o android_sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
    && unzip -qq android_sdk.zip -d /opt/android/ \
    && rm -f android_sdk.zip

COPY android_licenses /opt/android/licenses
RUN /opt/android/tools/bin/sdkmanager tools

COPY editor_settings.tres /root/.godot/editor_settings.tres

# hacky stuff to get gui access just to test it
RUN curl -s -L -o godot.zip -C - https://downloads.tuxfamily.org/godotengine/$GODOT_VERSION/Godot_v$GODOT_VERSION-stable_x11.64.zip \
    && unzip godot.zip -d /opt/ \
    && rm -f godot.zip
RUN ln -s /opt/Godot_v$GODOT_VERSION-stable_x11.64 /usr/local/bin/godot

RUN apt-get install -y -qq libxinerama1 libxcursor1 libxrandr2 libasound2 libpulse0 libgl1 libgles2 x11vnc xvfb
run mkdir ~/.vnc
run x11vnc -storepasswd 1234 ~/.vnc/passwd
