<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - ShopEase Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --ink: #102a43;
            --accent: #ef8354;
            --accent-deep: #d96b3c;
            --surface: #fffdf8;
            --mist: #f6f2eb;
            --line: #eadfce;
            --muted: #6b7280;
        }

        body {
            font-family: 'Inter', sans-serif;
            background:
                linear-gradient(180deg, rgba(255, 248, 240, 0.95), rgba(246, 242, 235, 1)),
                var(--mist);
            color: var(--ink);
            min-height: 100vh;
        }

        .navbar-admin {
            background: rgba(255, 253, 248, 0.94);
            backdrop-filter: blur(12px);
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
        }

        .nav-link-admin:hover {
            background: #fff4ef;
            color: var(--ink) !important;
        }

        .hero-shell {
            padding: 36px 0 26px;
        }

        .hero-card {
            background: linear-gradient(135deg, rgba(16, 42, 67, 0.98), rgba(36, 59, 85, 0.92));
            color: #fff;
            border-radius: 28px;
            padding: 28px;
            box-shadow: 0 25px 60px rgba(16, 42, 67, 0.22);
        }

        .hero-card h2 {
            font-weight: 800;
            margin-bottom: 8px;
        }

        .hero-card p {
            color: rgba(255,255,255,0.78);
            max-width: 620px;
            margin-bottom: 0;
        }

        .btn-add {
            background: var(--accent);
            color: white;
            border: none;
            border-radius: 999px;
            padding: 12px 20px;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-add:hover {
            background: var(--accent-deep);
            color: white;
        }

        .panel {
            background: var(--surface);
            border: 1px solid var(--line);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 18px 50px rgba(16, 42, 67, 0.08);
            margin-bottom: 36px;
        }

        .panel-head {
            padding: 18px 22px;
            border-bottom: 1px solid var(--line);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
        }

        .panel-head strong {
            font-size: 1.05rem;
        }

        .panel-head span {
            color: var(--muted);
            font-size: 0.92rem;
        }

        .table-custom {
            margin: 0;
        }

        .table-custom thead th {
            background: #fff7f1;
            color: var(--muted);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            border-bottom: 1px solid var(--line);
            padding: 14px 18px;
            white-space: nowrap;
        }

        .table-custom td {
            padding: 16px 18px;
            border-bottom: 1px solid #f4ece2;
            vertical-align: middle;
        }

        .table-custom tbody tr:hover {
            background: #fffaf5;
        }

        .prod-thumb {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 16px;
            background: #f8f4ef;
            border: 1px solid #f1e5d5;
        }

        .product-name {
            font-weight: 700;
            margin-bottom: 4px;
        }

        .product-copy {
            color: var(--muted);
            font-size: 0.88rem;
            max-width: 320px;
        }

        .meta-chip {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 999px;
            border: 1px solid #f1dfca;
            background: #fff8f1;
            font-size: 0.82rem;
            color: #915b35;
            font-weight: 600;
        }

        .price {
            font-weight: 800;
            font-size: 1.05rem;
        }

        .stock {
            font-weight: 700;
        }

        .stock.low {
            color: #c2410c;
        }

        .stock.good {
            color: #1d6b4d;
        }

        .btn-action {
            background: #fff;
            border: 1px solid var(--line);
            border-radius: 999px;
            padding: 8px 12px;
            color: var(--muted);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }

        .btn-action:hover {
            color: var(--ink);
            background: #fff7f1;
        }

        .btn-action.delete {
            color: #c2410c;
            border-color: #f8d6c3;
            background: #fff1ea;
        }

        .btn-action.delete:hover {
            background: #ffe6da;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-admin">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/admin/">
            <i class="fas fa-shield-halved text-primary me-2"></i>ShopEase Admin
        </a>
        <div class="ms-auto d-flex gap-2">
            <a class="nav-link-admin" href="/admin/"><i class="fas fa-house me-1"></i>Dashboard</a>
            <a class="nav-link-admin" href="/admin/logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
        </div>
    </div>
</nav>

<div class="container hero-shell">
    <div class="hero-card d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
        <div>
            <h2>Product Catalog</h2>
            <p>Review stock, keep pricing sharp, and publish richer product cards that feel like a real marketplace instead of placeholder inventory.</p>
        </div>
        <a href="/admin/products/add" class="btn-add"><i class="fas fa-plus"></i>New Product</a>
    </div>
</div>

<div class="container">
    <div class="panel">
        <div class="panel-head">
            <div>
                <strong>All products</strong>
                <span class="d-block">Manage every live item from one place.</span>
            </div>
            <span>${empty products ? '0 items' : products.size()} items</span>
        </div>

        <c:choose>
            <c:when test="${empty products}">
                <div class="p-5 text-center">
                    <i class="fas fa-box-open fa-2x mb-3 text-secondary"></i>
                    <h5 class="fw-bold">No products yet</h5>
                    <p class="text-secondary mb-0">Start by adding your first product to populate the storefront.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Weight</th>
                                <th>Stock</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <img src="${product.image}" class="prod-thumb" alt="${product.name}">
                                            <div>
                                                <div class="product-name">${product.name}</div>
                                                <div class="product-copy">${product.description}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="meta-chip"><i class="fas fa-tag"></i>${product.category.name}</span></td>
                                    <td class="price">Rs. ${product.price}</td>
                                    <td>${product.weight} g</td>
                                    <td>
                                        <span class="stock ${product.quantity < 15 ? 'low' : 'good'}">
                                            ${product.quantity} units
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-2 flex-wrap">
                                            <a href="products/update/${product.id}" class="btn-action"><i class="fas fa-pen"></i>Edit</a>
                                            <form action="products/delete" method="get" style="margin:0;">
                                                <input type="hidden" name="id" value="${product.id}">
                                                <button type="submit" class="btn-action delete"><i class="fas fa-trash"></i>Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
