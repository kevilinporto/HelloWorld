# Use uma imagem base com o OpenJDK, a versão 17 é uma escolha popular e estável.
FROM openjdk:17-jdk-slim

# Crie um volume para a pasta /tmp.
# Isso é útil para otimizar o uso da memória do JVM.
VOLUME /tmp

# Copie o arquivo JAR da sua aplicação para o container.
# Para isso, primeiro compile o projeto localmente com `mvn clean package`.
# Depois, o Docker irá encontrar o JAR na pasta `target`.
# O `*.jar` é um curinga para garantir que ele encontre o arquivo gerado.
COPY target/*.jar app.jar

# Defina o comando para rodar a aplicação quando o container iniciar.
# O comando 'exec java' é uma boa prática para evitar problemas de sinalização.
ENTRYPOINT ["java", "-jar", "/app.jar"]

# Exponha a porta 8080 (padrão do Spring Boot) para o mundo exterior.
EXPOSE 8080