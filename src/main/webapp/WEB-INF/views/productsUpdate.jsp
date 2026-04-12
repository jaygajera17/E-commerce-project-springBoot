<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product – ShopEase Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f1f5f9; color: #1e293b; min-height: 100vh; }

        .navbar-admin { background-color: #ffffff; border-bottom: 1px solid #e2e8f0; padding: 12px 0; position: sticky; top: 0; z-index: 100; }
        .navbar-brand-text { font-size: 1.25rem; font-weight: 700; color: #0f172a !important; }
        .nav-link-admin { color: #475569 !important; font-weight: 500; border-radius: 6px; padding: 8px 12px !important; }

        .page-header { padding: 30px 0; background: #ffffff; border-bottom: 1px solid #e2e8f0; margin-bottom: 30px; }
        .page-header h2 { font-weight: 700; color: #0f172a; margin: 0; font-size: 1.5rem; }

        .form-card { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 30px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }

        .form-floating label { color: #64748b; }
        .form-floating .form-control, .form-floating .form-select {
            border: 1px solid #cbd5e1; border-radius: 8px; color: #0f172a; box-shadow: none;
        }
        .form-floating .form-control:focus, .form-floating .form-select:focus {
            border-color: #0f172a; box-shadow: 0 0 0 3px rgba(15,23,42,0.1);
        }

        .img-preview-box {
            background: #f8fafc; border: 1px dashed #cbd5e1; border-radius: 8px;
            height: 160px; display: flex; align-items: center; justify-content: center; overflow: hidden;
        }
        .img-preview-box img { max-height: 150px; max-width: 100%; object-fit: contain; }

        .btn-submit { background-color: #0f172a; color: white; border: none; border-radius: 8px; padding: 10px 24px; font-weight: 500; }
        .btn-submit:hover { background-color: #334155; color: white; }
        .btn-cancel { background-color: #ffffff; color: #475569; border: 1px solid #cbd5e1; border-radius: 8px; padding: 10px 24px; font-weight: 500; text-decoration: none; display: inline-block; }
        .btn-cancel:hover { background-color: #f8fafc; color: #0f172a; border-color: #94a3b8; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-admin">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/admin/">
            <i class="fas fa-shield-halved text-primary me-2"></i>ShopEase Admin
        </a>
        <div class="ms-auto">
            <a class="nav-link-admin" href="/admin/products"><i class="fas fa-arrow-left me-1"></i>Back</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2>Edit Product</h2>
    </div>
</div>

<div class="container mb-5" style="max-width: 800px;">
    <div class="form-card">
        <form action="/admin/products/update/${product.id}" method="post">
            <div class="row g-4 d-flex">
                <div class="col-md-6">
                    <h6 class="mb-3 fw-bold text-secondary text-uppercase" style="font-size:0.8rem">Product Details</h6>
                    <div class="form-floating mb-3">
                        <input type="number" name="id" id="productId" class="form-control bg-light"
                               placeholder="ID" readonly value="${product.id}">
                        <label for="productId">Product ID</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="name" id="productName" class="form-control" placeholder="Name" value="${product.name}" required>
                        <label for="productName">Product Name</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select name="categoryid" id="categorySelect" class="form-select" required>
                            <option disabled>Select Category</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${product.category.id == category.id ? 'selected' : ''}>${category.name}</option>
                            </c:forEach>
                        </select>
                        <label for="categorySelect">Category</label>
                    </div>
                    <div class="row g-2">
                        <div class="col-6">
                            <div class="form-floating mb-3">
                                <input type="number" name="price" id="price" class="form-control" placeholder="Price" value="${product.price}" min="1" required>
                                <label for="price">Price ($)</label>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-floating mb-3">
                                <input type="number" name="quantity" id="quantity" class="form-control" placeholder="Quantity" value="${product.quantity}" min="1" required>
                                <label for="quantity">Quantity</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="number" name="weight" id="weight" class="form-control" placeholder="Weight" value="${product.weight}" min="1" required>
                        <label for="weight">Weight (grams)</label>
                    </div>
                </div>

                <div class="col-md-6">
                    <h6 class="mb-3 fw-bold text-secondary text-uppercase" style="font-size:0.8rem">Media & Description</h6>
                    <div class="form-floating mb-3">
                        <textarea name="description" id="description" class="form-control" placeholder="Description" style="height: 130px;" required>${product.description}</textarea>
                        <label for="description">Description</label>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-secondary fw-semibold mb-1" style="font-size:0.875rem">Product Image</label>
                        <input type="text" name="productImage" class="form-control" placeholder="Image URL" value="${product.image}" onchange="document.getElementById('imgPreview').src = this.value">
                    </div>
                    <div class="img-preview-box">
                        <img id="imgPreview" src="${product.image}" alt="Preview">
                    </div>
                    <input type="hidden" name="imgName">
                </div>
            </div>

            <hr class="my-4 text-muted border-top border-2">

            <div class="d-flex gap-2 justify-content-end">
                <a href="/admin/products" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit">Update Product</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>