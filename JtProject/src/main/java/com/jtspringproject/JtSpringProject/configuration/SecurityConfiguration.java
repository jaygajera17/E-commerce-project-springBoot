package com.jtspringproject.JtSpringProject.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.userService;

@Configuration
public class SecurityConfiguration {
	
	userService UserService;

	public SecurityConfiguration(userService UserService) {
		this.UserService = UserService;
	}

	@Configuration
	@Order(1)
	public static class AdminConfigurationAdapter{
		
		@Bean
		SecurityFilterChain adminFilterChain(HttpSecurity http) throws Exception {
            http.authorizeHttpRequests(requests -> requests
            		.antMatchers("/admin/login").permitAll()
                    .antMatchers("/admin/**").hasRole("ADMIN"))
                    .formLogin(login -> login
                            .loginPage("/admin/login")
                            .loginProcessingUrl("/adminloginvalidate")
                            .successHandler((request, response, authentication) -> {
                                response.sendRedirect("/admin/"); // Redirect on success
                            })
                            .failureHandler((request, response, exception) -> {
                                response.sendRedirect("/admin/login?error=true"); // Redirect on failure
                            }))
                    
                    .logout(logout -> logout.logoutUrl("/admin/logout")
                            .logoutSuccessUrl("/admin/login")
                            .deleteCookies("JSESSIONID"));
            http.csrf(csrf -> csrf.disable());
			return http.build();
		}
	}
	
	@Bean
	UserDetailsService userDetailsService() {
		return username -> {
			User user = UserService.getUserByUsername(username);
			if(user == null) {
	            throw new UsernameNotFoundException("User with username " + username + " not found.");
			}
			String role =  user.getRole().equals("ROLE_ADMIN") ? "ADMIN":"USER"; 
			
			return org.springframework.security.core.userdetails.User
					.withUsername(username)
					.passwordEncoder(input->passwordEncoder().encode(input))
					.password(user.getPassword())
					.roles(role)
					.build();
		};
	}

	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
