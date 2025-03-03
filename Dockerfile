#Imagen modelo
FROM eclipse-temurin:21.0.3_9-jdk

#Informar el puerto donde se ejecuta el contenedor
EXPOSE 8080

#Definir directorio raiz de contenedor
WORKDIR /root

#Copiar y pegar archivos dentro del contenedor
COPY ./pom.xml /root
COPY ./.mvn /root/.mvn

#mvnw.cmd para Windows y wvnw para Linux
COPY ./mvnw /root

#Descargar las dependencias
RUN ./mvnw dependency:go-offline

#Copiar codigo fuente dentro de contenedor
COPY ./src /root/src

#Construir la aplicacion
RUN ./mvnw clean install -DskipTests

#Levantar la aplicacion cuando el contenedor inicie
ENTRYPOINT ["java","-jar","/root/target/SpringDocker-0.0.1-SNAPSHOT.jar"]