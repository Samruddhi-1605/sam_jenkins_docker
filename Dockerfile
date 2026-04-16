FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY . /app
RUN javac Hello.java
CMD ["java","Hello"]
