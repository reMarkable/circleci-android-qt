FROM circleci/android:api-23-alpha
LABEL maintainers="henrik.hedlund@remarkable.com, morten.gunnufsen@remarkable.com"

ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_NDK_VERSION r10e
ENV QT_VERSION 5.11.3

RUN mkdir /tmp/android-ndk-tmp && \
    cd /tmp/android-ndk-tmp && \
    wget  -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && sudo mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME} && \
    sudo chmod +x /opt/android-ndk/build/tools/*.sh && \
    cd ${ANDROID_NDK_HOME} && \
    rm -rf /tmp/android-ndk-tmp && \
    mkdir /tmp/qt

ADD qt-install-non-interactive.js /tmp/qt/qt-install-non-interactive.js

RUN cd /tmp/qt && \
    wget -q http://download.qt.io/archive/qt/5.11/${QT_VERSION}/qt-opensource-linux-x64-${QT_VERSION}.run && \
    chmod +x qt-opensource-linux-x64-${QT_VERSION}.run && \
    ./qt-opensource-linux-x64-${QT_VERSION}.run --platform minimal --script /tmp/qt/qt-install-non-interactive.js && \
    rm -rf /tmp/qt

ENV ANDROID_NDK_ROOT ${ANDROID_NDK_HOME}
ENV PATH ${PATH}:${ANDROID_NDK_HOME}:${HOME}/Qt/${QT_VERSION}/android_armv7/bin
