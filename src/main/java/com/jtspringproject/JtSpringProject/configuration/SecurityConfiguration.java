package com.jtspringproject.JtSpringProject.configuration;

import com.jtspringproject.JtSpringProject.services.UserService;
import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

	private final UserService userService;
	private final PasswordEncoder passwordEncoder;

	public SecurityConfiguration(UserService userService, PasswordEncoder passwordEncoder) {
		this.userService = userService;
		this.passwordEncoder = passwordEncoder;
	}

	// ==========================================
	// ADMIN SECURITY FILTER CHAIN
	// ==========================================
	@Bean
	@Order(1)
	public SecurityFilterChain adminFilterChain(HttpSecurity http) throws Exception {
		http.securityMatcher("/admin/**")
				.authenticationProvider(authenticationProvider())
				.authorizeHttpRequests(auth -> auth
						.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
						.requestMatchers("/admin/login", "/admin/loginvalidate").permitAll()
						.requestMatchers("/admin/**").hasRole("ADMIN")
				)
				.formLogin(form -> form
						.loginPage("/admin/login")
						.loginProcessingUrl("/admin/loginvalidate")
						.defaultSuccessUrl("/admin/", true)
						.failureUrl("/admin/login?error=true")
						.permitAll()
				)
				.logout(logout -> logout
						.logoutUrl("/admin/logout")
						.logoutSuccessUrl("/admin/login")
						.deleteCookies("JSESSIONID")
						.invalidateHttpSession(true)
				)
				.exceptionHandling(ex -> ex.accessDeniedPage("/403"))
				.csrf(AbstractHttpConfigurer::disable);

		return http.build();
	}

	// ==========================================
	// USER SECURITY FILTER CHAIN
	// ==========================================
	@Bean
	@Order(2)
	public SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
		http.authenticationProvider(authenticationProvider())
				.authorizeHttpRequests(auth -> auth
						.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()

						.requestMatchers("/css/**", "/js/**", "/images/**", "/views/**").permitAll()
						.requestMatchers("/", "/login", "/register", "/newuserregister").permitAll()

						.anyRequest().hasAnyRole("ADMIN", "NORMAL")
				)
				.formLogin(form -> form
						.loginPage("/login")
						.loginProcessingUrl("/userloginvalidate")
						.defaultSuccessUrl("/", true)
						.failureUrl("/login?error=true")
						.permitAll()
				)
				.logout(logout -> logout
						.logoutUrl("/logout")
						.logoutSuccessUrl("/login")
						.deleteCookies("JSESSIONID")
						.invalidateHttpSession(true)
				)
				.exceptionHandling(ex -> ex.accessDeniedPage("/403"))
				.csrf(AbstractHttpConfigurer::disable);

		return http.build();
	}

	// ==========================================
	// USER DETAILS SERVICE (FIXED ROLE MAPPING)
	// ==========================================
	@Bean
	public UserDetailsService userDetailsService() {
		return username -> {
			com.jtspringproject.JtSpringProject.models.User user =
					userService.getUserByUsername(username);

			if (user == null) {
				throw new UsernameNotFoundException("User not found: " + username);
			}

			// 🔥 FIX: dynamic role mapping
			// Map stored ROLE_* values to Spring Security role names.
			String role = user.getRole().replace("ROLE_", "");

			return org.springframework.security.core.userdetails.User
					.withUsername(user.getUsername())
					.password(user.getPassword())
					.roles(role)   // Spring adds ROLE_ automatically
					.build();
		};
	}

	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(userDetailsService());
		provider.setPasswordEncoder(passwordEncoder);
		return provider;
	}
}
