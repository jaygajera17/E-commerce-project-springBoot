<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - ShopEase Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --ink: #14213d;
            --accent: #e76f51;
            --accent-deep: #d65b3e;
            --accent-soft: #ffe8e2;
            --mist: #f5f1ea;
            --card: #fffdfa;
            --line: #e8ded1;
            --muted: #6c7a89;
        }

        body {
            font-family: 'Inter', sans-serif;
            background:
                radial-gradient(circle at top left, rgba(231, 111, 81, 0.14), transparent 26%),
                radial-gradient(circle at bottom right, rgba(20, 33, 61, 0.08), transparent 34%),
                var(--mist);
            color: var(--ink);
            min-height: 100vh;
        }

        .navbar-admin {
            background: rgba(255, 253, 250, 0.92);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--line);
            padding: 12px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand-text {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--ink) !important;
        }

        .nav-link-admin {
            color: var(--muted) !important;
            font-weight: 600;
            border-radius: 999px;
            padding: 8px 14px !important;
            text-decoration: none;
        }

        .nav-link-admin:hover {
            background: var(--accent-soft);
            color: var(--ink) !important;
        }

        .page-header {
            padding: 44px 0 24px;
        }

        .page-header h2 {
            font-weight: 800;
            margin: 0 0 8px;
            font-size: 2rem;
        }

        .page-header p {
            margin: 0;
            color: var(--muted);
            max-width: 640px;
        }

        .layout-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.6fr) minmax(280px, 0.9fr);
            gap: 24px;
            margin-bottom: 40px;
        }

        .form-card, .side-card {
            background: var(--card);
            border: 1px solid var(--line);
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 18px 50px rgba(20, 33, 61, 0.08);
        }

        .section-kicker {
            font-size: 0.78rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--accent);
            font-weight: 700;
            margin-bottom: 10px;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .form-floating label {
            color: var(--muted);
        }

        .form-floating .form-control, .form-floating .form-select {
            border: 1px solid var(--line);
            border-radius: 14px;
            color: var(--ink);
            background: #fff;
            box-shadow: none;
        }

        .form-floating .form-control:focus, .form-floating .form-select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(231, 111, 81, 0.14);
        }

        .img-preview-box {
            background: linear-gradient(135deg, rgba(255, 232, 226, 0.85), rgba(255, 253, 250, 1));
            border: 1px dashed #d6b6aa;
            border-radius: 18px;
            min-height: 240px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            text-align: center;
            color: #9a8c7c;
            padding: 18px;
        }

        .img-preview-box img {
            max-height: 220px;
            max-width: 100%;
            object-fit: contain;
        }

        .help-list {
            display: grid;
            gap: 12px;
            margin-top: 18px;
        }

        .help-item {
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 14px 16px;
            background: #fff;
        }

        .help-item strong {
            display: block;
            margin-bottom: 4px;
            font-size: 0.95rem;
        }

        .help-item span {
            color: var(--muted);
            font-size: 0.88rem;
        }

        .btn-submit {
            background-color: var(--accent);
            color: white;
            border: none;
            border-radius: 999px;
            padding: 12px 24px;
            font-weight: 700;
        }

        .btn-submit:hover {
            background-color: var(--accent-deep);
            color: white;
        }

        .btn-cancel {
            background-color: transparent;
            color: var(--muted);
            border: 1px solid var(--line);
            border-radius: 999px;
            padding: 12px 24px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }

        .btn-cancel:hover {
            background-color: #fff;
            color: var(--ink);
            border-color: #d6c7b7;
        }

        @media (max-width: 991px) {
            .layout-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-admin">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/admin/">
            <i class="fas fa-shield-halved text-primary me-2"></i>ShopEase Admin
        </a>
        <div class="ms-auto">
            <a class="nav-link-admin" href="/admin/products"><i class="fas fa-arrow-left me-1"></i>Back to Products</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2>Add New Product</h2>
        <p>Publish better catalog entries with clear pricing, sharp imagery, and enough detail for customers to buy confidently.</p>
    </div>
</div>

<div class="container">
    <div class="layout-grid">
        <div class="form-card">
            <div class="section-kicker">Catalog Entry</div>
            <div class="section-title">New product information</div>

            <form action="/admin/products/add" method="post">
                <div class="row g-3">
                    <div class="col-12">
                        <div class="form-floating">
                            <input type="text" name="name" id="productName" class="form-control" placeholder="Product Name" required>
                            <label for="productName">Product Name</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select name="categoryid" id="categorySelect" class="form-select" required>
                                <option value="" selected disabled>Select Category</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}">${category.name}</option>
                                </c:forEach>
                            </select>
                            <label for="categorySelect">Category</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" name="weight" id="weight" class="form-control" placeholder="Weight" min="1" required>
                            <label for="weight">Weight (grams)</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" name="price" id="price" class="form-control" placeholder="Price" min="1" required>
                            <label for="price">Price (INR)</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" name="quantity" id="quantity" class="form-control" placeholder="Quantity" min="1" required>
                            <label for="quantity">Units in stock</label>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-floating">
                            <textarea name="description" id="description" class="form-control" placeholder="Description" style="height: 150px;" required></textarea>
                            <label for="description">Description</label>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-floating">
                            <input type="text" name="productImage" id="imageUrl" class="form-control" placeholder="Image URL" onchange="previewFromUrl(this.value)" required>
                            <label for="imageUrl">Image URL</label>
                        </div>
                    </div>
                </div>

                <hr class="my-4 text-muted border-top border-2">

                <div class="d-flex gap-2 justify-content-end flex-wrap">
                    <a href="/admin/products" class="btn-cancel">Cancel</a>
                    <button type="submit" class="btn-submit">Add Product</button>
                </div>
            </form>
        </div>

        <div class="side-card">
            <div class="section-kicker">Preview</div>
            <div class="section-title">Product card snapshot</div>

            <div class="img-preview-box mb-3">
                <div id="imgPlaceholder">
                    <i class="fas fa-image fa-2x mb-2 d-block"></i>
                    <small>Paste an image URL to preview the storefront card.</small>
                </div>
                <img id="imgPreview" src="" alt="Preview" style="display:none">
            </div>

            <div class="help-list">
                <div class="help-item">
                    <strong>Use descriptive names</strong>
                    <span>Example: "Cold Pressed Orange Juice" is stronger than a generic product title.</span>
                </div>
                <div class="help-item">
                    <strong>Write shopper-facing copy</strong>
                    <span>Call out freshness, taste, pack size, or the best use case in one compact paragraph.</span>
                </div>
                <div class="help-item">
                    <strong>Keep inventory believable</strong>
                    <span>Weight, price, and stock should align so the catalog feels curated instead of placeholder-driven.</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewFromUrl(url) {
        const img = document.getElementById('imgPreview');
        const placeholder = document.getElementById('imgPlaceholder');
        if (url) {
            img.src = url;
            img.style.display = 'block';
            placeholder.style.display = 'none';
            img.onerror = () => {
                img.style.display = 'none';
                placeholder.style.display = 'block';
            };
        } else {
            img.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }
</script>
</body>
</html>
