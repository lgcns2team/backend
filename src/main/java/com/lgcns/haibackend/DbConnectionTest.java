package com.lgcns.haibackend;

import jakarta.persistence.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Component;

@SpringBootApplication
@EnableJpaRepositories(considerNestedRepositories = true)
public class DbConnectionTest {

    public static void main(String[] args) {
        SpringApplication.run(DbConnectionTest.class, args);
    }

    // ---------------------
    //  Entity (내부 클래스)
    // ---------------------
    @Entity
    @Table(name = "test_user")
    public static class TestUser {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        private String name;

        protected TestUser() {}

        public TestUser(String name) {
            this.name = name;
        }

        public Long getId() {
            return id;
        }

        public String getName() {
            return name;
        }
    }

    // ---------------------
    //  Repository (내부 인터페이스)
    // ---------------------
    public interface TestUserRepository extends JpaRepository<TestUser, Long> {}

    // ---------------------
    //  Runner (앱 실행 시 테스트)
    // ---------------------
    @Component
    public static class TestRunner implements CommandLineRunner {

        private final TestUserRepository repo;

        public TestRunner(TestUserRepository repo) {
            this.repo = repo;
        }

        @Override
        public void run(String... args) {
            TestUser user = new TestUser("PostgreSQL 연결 성공 테스트");
            repo.save(user);
            System.out.println("DB 저장 완료: 생성된 ID = " + user.getId());
        }
    }
}
