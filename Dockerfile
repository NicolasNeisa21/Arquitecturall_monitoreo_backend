# -----------------------
# Etapa 1: Construir el JAR con Java 21
# -----------------------
FROM maven:3-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# -----------------------
# Etapa 2: Ejecutar el JAR con Java 21
# -----------------------
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copiar el JAR generado en la etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Render asigna $PORT automáticamente
ENV PORT=8080
EXPOSE 8080

# Comando de ejecución
CMD ["java", "-jar", "app.jar"]

