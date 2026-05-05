package com.jtspringproject.JtSpringProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan("com.jtspringproject.JtSpringProject.models")
@EnableJpaRepositories("com.jtspringproject.JtSpringProject.repository")
public class JtSpringProjectApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(JtSpringProjectApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(JtSpringProjectApplication.class, args);
	}

}
