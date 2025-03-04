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


#                              COMANDOS POR CMD
#-----------------------------------------------------------------------------------------------
# docker build -t "nombre-de-app" .   || Crea una imagen
# docker ps -a                        || Muestra los id de las imagenes dentro del contenedor
# docker rm ******                    || Elimina la imagen dentro del contenedor
# docker images                       || Muestra las imagenes creadas
# docker rmi "nombre-de-image"        || Elimina la imagen definitivamente
# docker-compose up                   || Levanta el contenedor y crea la imagen que no exista
#-----------------------------------------------------------------------------------------------