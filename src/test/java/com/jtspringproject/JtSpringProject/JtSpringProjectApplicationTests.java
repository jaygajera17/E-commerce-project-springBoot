package com.jtspringproject.JtSpringProject;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource(properties = {
		"db.driver=org.h2.Driver",
		"db.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;MODE=MySQL",
		"db.username=sa",
		"db.password=",
		"hibernate.dialect=org.hibernate.dialect.H2Dialect",
		"hibernate.hbm2ddl.auto=create-drop",
		"hibernate.show_sql=true"
})
class JtSpringProjectApplicationTests {

	@Test
	void contextLoads() {
	}

}
