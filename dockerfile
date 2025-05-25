FROM node:20 as build-frontend
WORKDIR /app/frontend
COPY frontend/ .
RUN npm install
RUN npm run build

FROM eclipse-temurin:17-jdk as build-backend
WORKDIR /app/backend
COPY backend/ .
RUN ./gradlew build

FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build-backend /app/backend/build/libs/*.jar app.jar
COPY --from=build-frontend /app/frontend/build ./static
ENTRYPOINT ["java", "-jar", "app.jar"]










