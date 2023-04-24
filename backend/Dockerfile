FROM gradle:jdk17-focal as build

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

FROM openjdk:17
EXPOSE 8080
COPY --from=build /home/gradle/src//build/libs/realworld.jar /app/app.jar
WORKDIR /app
CMD ["java", "-jar", "app.jar"]
