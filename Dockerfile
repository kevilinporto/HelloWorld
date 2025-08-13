# Use uma imagem base com o OpenJDK e o Maven, que é necessário para o build
FROM maven:3.8.5-openjdk-17 as builder

# Defina o diretório de trabalho
WORKDIR /app

# Copie o pom.xml para gerenciar as dependências do Maven
COPY pom.xml .

# Baixe as dependências do Maven
RUN mvn dependency:go-offline

# Copie o código-fonte da aplicação
COPY src ./src

# Execute o build do projeto, gerando o JAR na pasta 'target'
RUN mvn clean package -DskipTests

# Crie a imagem final
# Use uma imagem base mais leve para a aplicação final, sem o Maven
FROM openjdk:17-jdk-slim

# Crie um volume para a pasta /tmp
VOLUME /tmp

# Copie o arquivo JAR da etapa de 'builder' para a imagem final
COPY --from=builder /app/target/*.jar app.jar

# Defina o comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "/app.jar"]

# Exponha a porta 8080
EXPOSE 8080