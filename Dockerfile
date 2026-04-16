# Fase 1: Construcción (usamos Maven para compilar el proyecto)
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Fase 2: Ejecución (usamos un JRE ligero para que la imagen pese menos)
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copiamos el .jar generado en la fase anterior
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
