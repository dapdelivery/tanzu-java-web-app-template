ARG BUILDER_IMAGE=dev.registry.tanzu.vmware.com/tanzu-advanced-edition/maven
ARG RUNTIME_IMAGE=dev.registry.tanzu.vmware.com/tanzu-advanced-edition/java17-debian11 


FROM $BUILDER_IMAGE AS build

        ADD . .
        RUN unset MAVEN_CONFIG && ./mvnw clean package -B -DskipTests


FROM $RUNTIME_IMAGE AS runtime

        COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar /demo.jar
        CMD [ "/demo.jar" ]
