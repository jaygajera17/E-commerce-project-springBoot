package com.jtspringproject.JtSpringProject;

import com.jtspringproject.JtSpringProject.services.productService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;


@SpringBootApplication(exclude = HibernateJpaAutoConfiguration.class)
public class JtSpringProjectApplication {
	public static void main(String[] args) {
		SpringApplication.run(JtSpringProjectApplication.class, args);
	}

}
