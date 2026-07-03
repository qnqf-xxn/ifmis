package gov.mof.fasp2.cloud.framework.start;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
@EnableEurekaClient
public class PmkpiWebMain {

    public static void main(String[] args) {
        System.setProperty("spring.application.webapp","true");
        SpringApplication.run(StartWebApp.class, args);
    }
}
