# -----------------------
# Etapa 1: Construir el JAR
# -----------------------
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# -----------------------
# Etapa 2: Ejecutar el JAR
# -----------------------
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copiar el JAR generado en la etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Render asigna $PORT automáticamente
ENV PORT=8080
EXPOSE 8080

# Comando de ejecución
CMD ["java", "-jar", "app.jar"]
