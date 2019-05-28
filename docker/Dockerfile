FROM openjdk:8
COPY interview-test/countries-assembly-1.0.1.jar /countries-assembly-1.0.1.jar
COPY test_countries-assembly/isReady.sh /isReady.sh
EXPOSE 8080
ENTRYPOINT java -jar /countries-assembly-1.0.1.jar
