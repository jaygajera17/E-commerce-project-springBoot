<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopEase - Fresh Perishable Products</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --ink: #17324d;
            --muted: #687585;
            --accent: #eb5e28;
            --accent-deep: #d94d17;
            --cream: #f7f3ec;
            --card: rgba(255, 255, 255, 0.84);
            --line: rgba(23, 50, 77, 0.08);
        }

        body {
            font-family: 'Inter', sans-serif;
            background:
                radial-gradient(circle at top left, rgba(235, 94, 40, 0.15), transparent 26%),
                radial-gradient(circle at top right, rgba(38, 70, 83, 0.12), transparent 30%),
                linear-gradient(180deg, #fffaf3 0%, var(--cream) 100%);
            color: var(--ink);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar-custom {
            background-color: rgba(255,255,255,0.72);
            border-bottom: 1px solid rgba(255,255,255,0.5);
            backdrop-filter: blur(12px);
            padding: 12px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand-text {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--ink) !important;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .navbar-brand-text .logo-dot {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, #fff0e7, #ffe0d2);
            color: var(--accent);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }

        .nav-link-custom {
            color: var(--muted) !important;
            font-weight: 600;
            transition: all 0.2s;
            padding: 8px 12px !important;
            border-radius: 999px;
        }

        .nav-link-custom:hover {
            color: var(--ink) !important;
            background-color: rgba(255,255,255,0.8);
        }

        .welcome-chip {
            background: rgba(255,255,255,0.75);
            border: 1px solid rgba(23, 50, 77, 0.08);
            border-radius: 999px;
            padding: 6px 14px;
            font-size: 0.875rem;
            color: var(--muted);
            font-weight: 600;
        }

        .hero {
            padding: 56px 0 28px;
        }

        .hero-card {
            background: linear-gradient(140deg, rgba(17, 44, 72, 0.97), rgba(27, 68, 98, 0.94));
            color: white;
            border-radius: 32px;
            padding: 34px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 30px 60px rgba(23, 50, 77, 0.2);
        }

        .hero-card::after {
            content: "";
            position: absolute;
            right: -40px;
            top: -30px;
            width: 220px;
            height: 220px;
            background: radial-gradient(circle, rgba(255,255,255,0.24), transparent 64%);
        }

        .hero-card h1 {
            font-size: 2.7rem;
            font-weight: 800;
            margin-bottom: 12px;
            position: relative;
            z-index: 1;
        }

        .hero-card p {
            color: rgba(255,255,255,0.8);
            font-size: 1.05rem;
            max-width: 660px;
            position: relative;
            z-index: 1;
            margin-bottom: 20px;
        }

        .hero-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            position: relative;
            z-index: 1;
        }

        .hero-badges span {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.14);
            border-radius: 999px;
            padding: 8px 12px;
            font-size: 0.88rem;
            font-weight: 600;
        }

        .section-head {
            padding: 8px 0 20px;
        }

        .section-head h2 {
            font-size: 1.55rem;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .section-head p {
            color: var(--muted);
            margin: 0;
        }

        .product-grid {
            padding-bottom: 48px;
        }

        .product-card {
            background: var(--card);
            border: 1px solid rgba(255,255,255,0.5);
            backdrop-filter: blur(12px);
            border-radius: 22px;
            overflow: hidden;
            transition: transform 0.22s ease, box-shadow 0.22s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            box-shadow: 0 16px 40px rgba(23, 50, 77, 0.08);
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 24px 50px rgba(23, 50, 77, 0.14);
        }

        .card-img-wrapper {
            background: linear-gradient(180deg, #fff9f4, #f8ede2);
            height: 210px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 22px;
        }

        .card-img-wrapper img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }

        .card-body-custom {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .card-topline {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .category-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #fff2e9;
            color: #b45309;
            border-radius: 999px;
            padding: 5px 11px;
            font-size: 0.76rem;
            font-weight: 700;
        }

        .weight-chip {
            color: var(--muted);
            font-size: 0.82rem;
            font-weight: 600;
        }

        .product-name {
            color: var(--ink);
            font-weight: 800;
            font-size: 1.15rem;
            margin-bottom: 8px;
        }

        .product-desc {
            color: var(--muted);
            font-size: 0.9rem;
            line-height: 1.55;
            flex: 1;
            margin-bottom: 18px;
        }

        .product-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
            color: var(--muted);
            font-size: 0.88rem;
            font-weight: 600;
        }

        .product-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-top: auto;
        }

        .price-text {
            color: var(--ink);
            font-weight: 800;
            font-size: 1.28rem;
        }

        .btn-cart {
            background-color: var(--accent);
            color: #ffffff;
            border: none;
            border-radius: 999px;
            font-size: 0.88rem;
            font-weight: 700;
            padding: 9px 16px;
            transition: background-color 0.2s;
        }

        .btn-cart:hover {
            background-color: var(--accent-deep);
            color: #ffffff;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: rgba(255,255,255,0.75);
            border: 1px dashed rgba(23, 50, 77, 0.18);
            border-radius: 24px;
        }

        .empty-state i {
            font-size: 3rem;
            color: #c8b7a6;
            margin-bottom: 16px;
        }

        .empty-state h4 {
            color: var(--ink);
            font-weight: 700;
        }

        .empty-state p {
            color: var(--muted);
            margin: 0;
        }

        footer {
            background: rgba(255,255,255,0.6);
            border-top: 1px solid rgba(23, 50, 77, 0.06);
            padding: 24px 0;
            text-align: center;
            color: var(--muted);
            font-size: 0.875rem;
            margin-top: auto;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/">
            <div class="logo-dot"><i class="fas fa-shopping-basket"></i></div>
            ShopEase
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#mainNav" aria-controls="mainNav" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <div class="ms-auto d-flex align-items-center gap-2 flex-wrap">
                <span class="welcome-chip">
                    <i class="fas fa-user-circle me-1"></i>${username}
                </span>
                <a class="nav-link-custom" href="/user/cartproducts"><i class="fas fa-cart-shopping me-1"></i>Cart</a>
                <a class="nav-link-custom" href="/profileDisplay"><i class="fas fa-user me-1"></i>Profile</a>
                <a class="nav-link-custom" href="/logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="hero">
    <div class="container">
        <div class="hero-card">
            <h1>Fresh picks for every basket</h1>
            <p>Discover fruit, vegetables, dairy, bakery, drinks, and more from a cleaner catalog with better product detail and daily-ready stock.</p>
            <div class="hero-badges">
                <span><i class="fas fa-leaf"></i>Seasonal produce</span>
                <span><i class="fas fa-temperature-low"></i>Perishable handled with care</span>
                <span><i class="fas fa-truck-fast"></i>Fast local delivery</span>
            </div>
        </div>
    </div>
</div>

<div class="product-grid">
    <div class="container">
        <div class="section-head">
            <h2>Available now</h2>
            <p>Shop from the latest seeded product range and anything newly added from the admin catalog.</p>
        </div>

        <c:choose>
            <c:when test="${empty products}">
                <div class="empty-state">
                    <i class="fas fa-box-open"></i>
                    <h4>No products found</h4>
                    <p>Check back later for fresh inventory.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="product" items="${products}">
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="product-card">
                                <div class="card-img-wrapper">
                                    <img src="${product.image}" alt="${product.name}">
                                </div>
                                <div class="card-body-custom">
                                    <div class="card-topline">
                                        <span class="category-badge"><i class="fas fa-tag"></i>${product.category.name}</span>
                                        <span class="weight-chip">${product.weight} g</span>
                                    </div>
                                    <div class="product-name">${product.name}</div>
                                    <div class="product-desc">${product.description}</div>
                                    <div class="product-meta">
                                        <span>${product.quantity} in stock</span>
                                        <span>Ready to dispatch</span>
                                    </div>
                                    <div class="product-footer">
                                        <span class="price-text">Rs. ${product.price}</span>
                                        <form action="/user/addtocart" method="post" style="margin: 0;">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            <button type="submit" class="btn-cart">Add to Cart</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer>
    <div class="container">
        &copy; 2026 ShopEase. Fresh inventory, cleaner catalog, faster shopping.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
