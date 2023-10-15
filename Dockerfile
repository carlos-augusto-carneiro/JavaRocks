# Etapa 1: Preparação
FROM ubuntu:latest AS preparation

# Instale as ferramentas necessárias
RUN apt-get update
RUN apt-get install -y openjdk-20.0.2-jdk maven

# Copie o código-fonte para o contêiner
WORKDIR /app
COPY . .

# Construa o aplicativo
RUN mvn clean install

# Etapa 2: Construção da Imagem do Aplicativo
FROM adoptopenjdk/openjdk17:latest

# Copie o artefato do build anterior
COPY --from=preparation /app/target/todolist-1.0.0.jar app.jar

# Exponha a porta necessária
EXPOSE 8080

# Comando de inicialização do aplicativo
CMD ["java", "-jar", "app.jar"]
