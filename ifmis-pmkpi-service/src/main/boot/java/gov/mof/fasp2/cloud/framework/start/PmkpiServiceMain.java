package gov.mof.fasp2.cloud.framework.start;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan("gov.mof.fasp2")
public class PmkpiServiceMain {
    public static void main(String[] args) {
        System.setProperty("org.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH","true");
        System.setProperty("tomcat.util.http.parser.HttpParser.requestTargetAllow","|{}");
        SpringApplication application = new SpringApplication(StartApplication.class);
        application.run(args);
    }
}
