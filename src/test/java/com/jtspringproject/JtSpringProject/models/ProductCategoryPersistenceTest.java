package com.jtspringproject.JtSpringProject.models;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import com.jtspringproject.JtSpringProject.services.productService;

import static org.assertj.core.api.Assertions.assertThat;

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
class ProductCategoryPersistenceTest {

    @Autowired
    private SessionFactory sessionFactory;

      @Autowired
      private productService prodService;

    private Session session;


    private int savedCategoryId;
    private int savedProductId;
    private int siblingProductId;

    @BeforeEach
    void setUp() {
        session = sessionFactory.openSession();
    }

    @AfterEach
    void tearDown() {
        if (session != null && session.isOpen()) {

            session.beginTransaction();
              session.createQuery("delete from PRODUCT").executeUpdate();
              session.createQuery("delete from CATEGORY").executeUpdate();
            session.getTransaction().commit();
            session.close();
        }
    }

    private Category persistCategory(String name) {
        Category category = new Category();
        category.setName(name);
        session.beginTransaction();
        session.save(category);
        session.getTransaction().commit();
        session.clear();
        return category;
    }

    private Product persistProduct(String name, int price, int quantity, Category category) {
        Product product = new Product();
        product.setName(name);
        product.setPrice(price);
        product.setQuantity(quantity);
        session.beginTransaction();
        Category managedCategory = session.get(Category.class, category.getId());
        product.setCategory(managedCategory);
        session.save(product);
        session.getTransaction().commit();
        session.clear();
        return product;
    }

    @Test
    @DisplayName("Deleting a Product must not cascade-delete its Category")
    void whenProductIsDeleted_categoryMustSurvive() {
        Category electronics = persistCategory("Electronics");
            savedCategoryId = electronics.getId();

        Product laptop = persistProduct("Gaming Laptop", 80000, 10, electronics);
            savedProductId = laptop.getId();

        assertThat(session.get(Product.class, savedProductId))
                .as("Product should exist before deletion")
                .isNotNull();
        assertThat(session.get(Category.class, savedCategoryId))
                .as("Category should exist before deletion")
                .isNotNull();

        session.beginTransaction();
        Product toDelete = session.get(Product.class, savedProductId);
        session.delete(toDelete);
        session.getTransaction().commit();
        session.clear();

        assertThat(session.get(Product.class, savedProductId))
                .as("Product must be gone after deletion")
                .isNull();

        Category survivingCategory = session.get(Category.class, savedCategoryId);
        assertThat(survivingCategory)
                .as("Category must NOT be deleted when its Product is deleted — cascade bug regression")
                .isNotNull();
        assertThat(survivingCategory.getName())
                .as("Category name must be unchanged")
                .isEqualTo("Electronics");
    }

    @Test
    @DisplayName("Deleting one Product must not affect sibling Products sharing the same Category")
    void whenOneProductIsDeleted_siblingProductsSharingCategoryMustSurvive() {
        Category electronics = persistCategory("Electronics");
            savedCategoryId = electronics.getId();

        Product laptop = persistProduct("Gaming Laptop", 80000, 10, electronics);
            savedProductId = laptop.getId();

        session.beginTransaction();
        Category refetchedCategory = session.get(Category.class, savedCategoryId);
        session.getTransaction().commit();
        session.clear();

        Product phone = persistProduct("Smartphone", 50000, 25, refetchedCategory);
            siblingProductId = phone.getId();

        session.beginTransaction();
        Product toDelete = session.get(Product.class, savedProductId);
        session.delete(toDelete);
        session.getTransaction().commit();
        session.clear();

        assertThat(session.get(Product.class, savedProductId))
                .as("Deleted product must be gone")
                .isNull();

        assertThat(session.get(Product.class, siblingProductId))
                .as("Sibling Product sharing the same Category must still exist")
                .isNotNull();

        assertThat(session.get(Category.class, savedCategoryId))
                .as("Shared Category must still exist after one Product is deleted")
                .isNotNull();
    }

    @Test
    @DisplayName("Product category field must be readable after persist and reload")
    void productCategoryRelationship_mustBeAccessibleAfterPersist() {
        Category electronics = persistCategory("Electronics");
            savedCategoryId = electronics.getId();

        Product laptop = persistProduct("Gaming Laptop", 80000, 10, electronics);
            savedProductId = laptop.getId();

        session.beginTransaction();
        Product reloaded = session.get(Product.class, savedProductId);
        session.getTransaction().commit();

        assertThat(reloaded).isNotNull();
        assertThat(reloaded.getCategory())
                .as("Product.getCategory() must not throw NullPointerException and must return the linked Category")
                .isNotNull();
            assertThat(reloaded.getCategory().getId())
                .as("Category ID on reloaded Product must match the persisted Category")
                .isEqualTo(savedCategoryId);
    }

                  @Test
                  @DisplayName("Product service must return products with categories already available")
                  void productService_mustReturnProductsWithCategories() {

                    Category electronics = persistCategory("Electronics");
                    Product laptop = persistProduct("Gaming Laptop", 80000, 10, electronics);
                    Product phone = persistProduct("Smartphone", 50000, 25, electronics);

                    List<Product> products = this.prodService.getProducts();

                    assertThat(products)
                        .extracting(Product::getId)
                        .contains(laptop.getId(), phone.getId());
                    assertThat(products)
                        .filteredOn(product -> product.getId() == laptop.getId() || product.getId() == phone.getId())
                        .allSatisfy(product -> assertThat(product.getCategory())
                            .as("Category should already be available after service fetch")
                            .isNotNull());
                  }
}