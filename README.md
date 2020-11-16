# Docker image for Android application.

This is the docker image for example for building android application.
This image based on *openjdk 8*, use the *android API 28* and *android NDK r20*.

## Example of .gitlab-ci.yml

```yaml
image: kostyabro/droid_ndk:28.20

before_script:
  - chmod +x ./gradlew

stages:
  - build
  - test

lintDebug:
  stage: build
  tags:
    - shared
    - docker
  script:
    - ./gradlew -Pci --console=plain :app:lintDebug -PbuildDir=lint

assembleDebug:
  stage: build
  tags:
    - shared
    - docker
  script:
    - ./gradlew assembleDebug
  artifacts:
    paths:
      - app/build/outputs/

debugTests:
  stage: test
  tags:
    - shared
    - docker
  script:
    - ./gradlew -Pci --console=plain :app:testDebug
```
