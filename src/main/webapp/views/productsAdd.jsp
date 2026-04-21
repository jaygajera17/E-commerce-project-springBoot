<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product – ShopEase Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }
        body { background: #0d0d1a; color: #e0e0f0; min-height: 100vh; }

        .navbar-admin {
            background: rgba(13,13,26,0.97); border-bottom: 1px solid rgba(168,85,247,0.15);
            backdrop-filter: blur(20px); padding: 14px 0; position: sticky; top: 0; z-index: 100;
        }
        .navbar-brand-text {
            font-size: 1.35rem; font-weight: 700; color: #fff !important;
            display: flex; align-items: center; gap: 10px;
        }
        .logo-dot {
            width: 32px; height: 32px; background: linear-gradient(135deg, #a855f7, #7c3aed);
            border-radius: 8px; display: flex; align-items: center;
            justify-content: center; font-size: 0.85rem; color: #fff;
        }
        .nav-link-admin {
            color: #9999bb !important; font-weight: 500;
            padding: 6px 14px !important; border-radius: 8px; transition: color 0.2s, background 0.2s;
        }
        .nav-link-admin:hover { color: #fff !important; background: rgba(168,85,247,0.15); }

        .page-header {
            background: linear-gradient(135deg, #2d1b69, #1a0a3d, #0d0d1a);
            padding: 36px 0 30px; text-align: center;
        }
        .page-header h2 {
            font-size: 1.9rem; font-weight: 800;
            background: linear-gradient(135deg, #fff, #c084fc);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }

        .form-card {
            background: #161628; border: 1px solid rgba(168,85,247,0.12);
            border-radius: 20px; padding: 36px; box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }
        .section-label {
            color: #c084fc; font-size: 0.75rem; font-weight: 700;
            letter-spacing: 0.8px; text-transform: uppercase;
            margin-bottom: 18px; display: flex; align-items: center; gap: 8px;
        }
        .section-label::after {
            content: ''; flex: 1; height: 1px; background: rgba(168,85,247,0.2);
        }

        .form-floating label { color: #8888aa; font-size: 0.88rem; }
        .form-floating .form-control,
        .form-floating .form-select,
        .form-floating textarea.form-control {
            background: #0d0d1a; border: 1.5px solid #2a2a4a;
            border-radius: 10px; color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-floating .form-control:focus,
        .form-floating .form-select:focus,
        .form-floating textarea.form-control:focus {
            background: #0d0d1a; border-color: #a855f7;
            box-shadow: 0 0 0 3px rgba(168,85,247,0.2); color: #fff;
        }
        .form-floating .form-select option { background: #0d0d1a; }

        .img-preview-box {
            background: #0d0d1a; border: 1.5px dashed #2a2a4a;
            border-radius: 12px; height: 160px;
            display: flex; align-items: center; justify-content: center;
            overflow: hidden; position: relative; margin-top: 12px;
        }
        .img-preview-box img { max-height: 150px; max-width: 100%; object-fit: contain; }
        #imgPlaceholder { color: #444466; text-align: center; }

        .btn-submit {
            background: linear-gradient(135deg, #a855f7, #7c3aed);
            border: none; border-radius: 10px; color: #fff;
            font-weight: 700; font-size: 1rem; padding: 12px 32px;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(168,85,247,0.45); color: #fff; }
        .btn-back {
            background: #1e1e38; border: 1px solid #2a2a4a; border-radius: 10px;
            color: #9999bb; font-weight: 600; padding: 12px 24px; text-decoration: none;
            display: inline-block; transition: background 0.2s;
        }
        .btn-back:hover { background: #252540; color: #fff; }

        footer {
            background: #080814; border-top: 1px solid rgba(168,85,247,0.08);
            padding: 20px 0; text-align: center; color: #333355; font-size: 0.85rem; margin-top: 40px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-admin">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/admin/">
            <div class="logo-dot"><i class="fas fa-shield-halved"></i></div>
            ShopEase Admin
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#adminNav" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNav">
            <div class="ms-auto d-flex align-items-center gap-2">
                <a class="nav-link-admin" href="/admin/products"><i class="fas fa-arrow-left me-1"></i>Back to Products</a>
                <a class="nav-link-admin" href="/admin/logout"><i class="fas fa-right-from-bracket me-1"></i>Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2><i class="fas fa-plus-circle me-2"></i>Add New Product</h2>
    </div>
</div>

<div class="container py-5" style="max-width: 860px">
    <div class="form-card">
        <form action="/admin/products/add" method="post">
            <div class="row g-4">
                <!-- Left column -->
                <div class="col-md-6">
                    <div class="section-label"><i class="fas fa-info-circle me-1"></i>Product Info</div>

                    <div class="form-floating mb-3">
                        <c:forEach var="product" items="${products}">
                            <input type="number" name="id" id="productId" class="form-control"
                                   placeholder="ID" readonly value="${product.id + 1}">
                            <label for="productId">Product ID (auto)</label>
                        </c:forEach>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" name="name" id="productName" class="form-control"
                               placeholder="Product Name" required>
                        <label for="productName"><i class="fas fa-tag me-1"></i>Product Name</label>
                    </div>

                    <div class="form-floating mb-3">
                        <select name="categoryid" id="categorySelect" class="form-select" required>
                            <option selected disabled>Select a category</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        <label for="categorySelect"><i class="fas fa-tags me-1"></i>Category</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="number" name="price" id="price" class="form-control"
                               placeholder="Price" min="1" required>
                        <label for="price"><i class="fas fa-dollar-sign me-1"></i>Price ($)</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="number" name="weight" id="weight" class="form-control"
                               placeholder="Weight" min="1" required>
                        <label for="weight"><i class="fas fa-weight-hanging me-1"></i>Weight (grams)</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="number" name="quantity" id="quantity" class="form-control"
                               placeholder="Quantity" min="1" required>
                        <label for="quantity"><i class="fas fa-boxes-stacked me-1"></i>Available Quantity</label>
                    </div>
                </div>

                <!-- Right column -->
                <div class="col-md-6">
                    <div class="section-label"><i class="fas fa-image me-1"></i>Media & Description</div>

                    <div class="form-floating mb-3">
                        <textarea name="description" id="description" class="form-control"
                                  placeholder="Description" style="height:120px"></textarea>
                        <label for="description">Product Description</label>
                    </div>

                    <div class="form-floating mb-2">
                        <input type="text" name="productImage" id="imageUrl" class="form-control"
                               placeholder="Image URL" onchange="previewFromUrl(this.value)" required>
                        <label for="imageUrl"><i class="fas fa-link me-1"></i>Image URL</label>
                    </div>

                    <div class="img-preview-box">
                        <div id="imgPlaceholder">
                            <i class="fas fa-image fa-2x mb-2 d-block"></i>
                            <small>Image preview</small>
                        </div>
                        <img id="imgPreview" src="" alt="Preview" style="display:none">
                    </div>
                    <input type="hidden" name="imgName">
                </div>
            </div>

            <hr style="border-color:rgba(168,85,247,0.1); margin:28px 0">

            <div class="d-flex gap-3 justify-content-end">
                <a href="/admin/products" class="btn-back"><i class="fas fa-xmark me-1"></i>Cancel</a>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-plus me-2"></i>Add Product
                </button>
            </div>
        </form>
    </div>
</div>

<footer><p>&copy; 2024 ShopEase Admin. All rights reserved.</p></footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewFromUrl(url) {
        const img = document.getElementById('imgPreview');
        const placeholder = document.getElementById('imgPlaceholder');
        if (url) {
            img.src = url;
            img.style.display = 'block';
            placeholder.style.display = 'none';
            img.onerror = () => { img.style.display='none'; placeholder.style.display='block'; };
        } else {
            img.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }
</script>
</body>
</html>