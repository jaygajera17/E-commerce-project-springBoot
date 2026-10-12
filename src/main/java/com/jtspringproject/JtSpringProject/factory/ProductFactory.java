package com.jtspringproject.JtSpringProject.factory;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.services.categoryService;
import org.springframework.stereotype.Component;

@Component
public class ProductFactory {
    private final categoryService categoryService;

    public ProductFactory(categoryService categoryService) {
        this.categoryService = categoryService;
    }

    public Product createProduct(String name, int categoryId, int price, int weight, int quantity,
                                 String description, String productImage) {
        Category category = this.categoryService.getCategory(categoryId);
        Product product = new Product();
        product.setName(name);
        product.setCategory(category);
        product.setDescription(description);
        product.setPrice(price);
        product.setImage(productImage);
        product.setWeight(weight);
        product.setQuantity(quantity);
        return product;
    }
}
