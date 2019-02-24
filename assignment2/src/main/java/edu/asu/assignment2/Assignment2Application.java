package edu.asu.assignment2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

@SpringBootApplication
public class Assignment2Application extends SpringBootServletInitializer {
	public Assignment2Application() {
		super();
		setRegisterErrorPageFilter(false);
	}
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(Assignment2Application.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(Assignment2Application.class, args);
	}
}
