# This is the dockerfile with workspace for buildfing this application.
FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK 28
ENV ANDROID_BUILD_TOOLS 28.0.2
ENV ANDROID_SDK_TOOLS 4333796
ENV VERSION_ANDROID_NDK android-ndk-r20b
ENV ANDROID_NDK_HOME /sdk/${VERSION_ANDROID_NDK}
ENV ANDROID_HOME /android-sdk-linux
ENV PATH $PATH:/android-sdk-linux/platform-tools/
RUN apt-get -qq update && apt-get install -qqy --no-install-recommends build-essential file && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget --output-document=/ndk.zip https://dl.google.com/android/repository/${VERSION_ANDROID_NDK}-linux-x86_64.zip && \
    unzip /ndk.zip -d /sdk && rm -v /ndk.zip && \
    apt-get --quiet update --yes && \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 && \
    wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip && \
    unzip -d /android-sdk-linux android-sdk.zip && \
    mkdir -p /root/.android && \
    touch /root/.android/repositories.cfg && \
    echo y | /android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
    echo y | /android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null && \
    echo y | /android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null && \
    yes | /android-sdk-linux/tools/bin/sdkmanager --licenses
