package com.jtspringproject.JtSpringProject.services;

import java.util.List;
import org.springframework.stereotype.Service;
import com.jtspringproject.JtSpringProject.repository.CategoryRepository;
import com.jtspringproject.JtSpringProject.models.Category;

@Service
public class CategoryService {

	private final CategoryRepository categoryRepository;

	// Constructor Injection (Enterprise Standard)
	public CategoryService(CategoryRepository categoryRepository) {
		this.categoryRepository = categoryRepository;
	}

	public Category addCategory(String name) {
		Category category = new Category();
		category.setName(name);
		return categoryRepository.save(category);
	}

	public List<Category> getCategories() {
		return categoryRepository.findAll();
	}

	public Boolean deleteCategory(int id) {
		if (categoryRepository.existsById(id)) {
			categoryRepository.deleteById(id);
			return true;
		}
		return false;
	}

	public Category updateCategory(int id, String name) {
		Category category = categoryRepository.findById(id).orElse(null);
		if (category != null) {
			category.setName(name);
			return categoryRepository.save(category);
		}
		return null;
	}

	public Category getCategory(int id) {
		return categoryRepository.findById(id).orElse(null);
	}
}