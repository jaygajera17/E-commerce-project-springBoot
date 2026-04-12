<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopEase – Fresh Perishable Products</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }

        body { background: #0f0f1a; color: #e0e0f0; min-height: 100vh; }

        /* Navbar */
        .navbar-custom {
            background: rgba(15,12,40,0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(108,99,255,0.15);
            padding: 14px 0;
            position: sticky;
            top: 0; z-index: 100;
        }
        .navbar-brand-text {
            font-size: 1.4rem;
            font-weight: 700;
            color: #fff !important;
            display: flex; align-items: center; gap: 10px;
        }
        .navbar-brand-text .logo-dot {
            width: 32px; height: 32px;
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.9rem;
        }
        .nav-link-custom {
            color: #9999bb !important;
            font-weight: 500;
            transition: color 0.2s;
            padding: 6px 14px !important;
            border-radius: 8px;
        }
        .nav-link-custom:hover { color: #fff !important; background: rgba(108,99,255,0.15); }
        .welcome-chip {
            background: rgba(108,99,255,0.15);
            border: 1px solid rgba(108,99,255,0.3);
            border-radius: 20px;
            padding: 4px 14px;
            font-size: 0.85rem;
            color: #9999ff;
        }

        /* Hero */
        .hero {
            background: linear-gradient(135deg, #1a1060 0%, #0f0c29 60%, #0f0f1a 100%);
            padding: 60px 0 50px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(108,99,255,0.12) 0%, transparent 70%);
            top: -150px; left: 50%; transform: translateX(-50%);
        }
        .hero h1 {
            font-size: 2.6rem; font-weight: 800;
            background: linear-gradient(135deg, #fff, #b8b0ff);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }
        .hero p { color: #8888aa; font-size: 1.05rem; }

        /* Product cards */
        .product-grid { padding: 40px 0 60px; }

        .product-card {
            background: #1a1a2e;
            border: 1px solid rgba(108,99,255,0.1);
            border-radius: 16px;
            overflow: hidden;
            transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
            height: 100%;
            display: flex; flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.4);
            border-color: rgba(108,99,255,0.35);
        }

        .card-img-wrapper {
            background: #12121f;
            height: 180px;
            display: flex; align-items: center; justify-content: center;
            overflow: hidden;
        }
        .card-img-wrapper img {
            max-height: 160px; max-width: 100%;
            object-fit: contain;
            transition: transform 0.3s;
        }
        .product-card:hover .card-img-wrapper img { transform: scale(1.06); }

        .card-body-custom {
            padding: 18px 20px 20px;
            display: flex; flex-direction: column; flex: 1;
        }
        .category-badge {
            display: inline-block;
            background: rgba(108,99,255,0.15);
            color: #9999ff;
            border-radius: 20px;
            padding: 2px 10px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }
        .product-name {
            color: #fff;
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 6px;
        }
        .product-desc {
            color: #7777aa;
            font-size: 0.82rem;
            line-height: 1.5;
            flex: 1;
            margin-bottom: 14px;
        }
        .product-footer {
            display: flex; align-items: center; justify-content: space-between;
        }
        .price-pill {
            background: linear-gradient(135deg, rgba(16,185,129,0.2), rgba(5,150,105,0.15));
            border: 1px solid rgba(16,185,129,0.3);
            color: #34d399;
            border-radius: 20px;
            padding: 4px 14px;
            font-weight: 700;
            font-size: 0.95rem;
        }
        .btn-cart {
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            border: none;
            border-radius: 10px;
            color: #fff;
            font-size: 0.82rem;
            font-weight: 600;
            padding: 7px 14px;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-cart:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(108,99,255,0.4);
            color: #fff;
        }

        /* Empty state */
        .empty-state {
            text-align: center; padding: 80px 20px; color: #555577;
        }
        .empty-state i { font-size: 4rem; margin-bottom: 20px; opacity: 0.4; }

        /* Footer */
        footer {
            background: #0a0a14;
            border-top: 1px solid rgba(108,99,255,0.1);
            padding: 20px 0;
            text-align: center;
            color: #444466;
            font-size: 0.85rem;
        }

        .navbar-toggler { border-color: rgba(108,99,255,0.3); }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="#">
            <div class="logo-dot"><i class="fas fa-shopping-bag"></i></div>
            ShopEase
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#mainNav" aria-controls="mainNav" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <div class="ms-auto d-flex align-items-center gap-3 flex-wrap">
                <span class="welcome-chip">
                    <i class="fas fa-user-circle me-1"></i>Welcome, ${username}
                </span>
                <a class="nav-link-custom" href="cartproducts">
                    <i class="fas fa-cart-shopping me-1"></i>My Cart
                </a>
                <a class="nav-link-custom" href="profileDisplay">
                    <i class="fas fa-user me-1"></i>Profile
                </a>
                <a class="nav-link-custom" href="logout">
                    <i class="fas fa-right-from-bracket me-1"></i>Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero -->
<div class="hero">
    <div class="container">
        <h1>Welcome to ShopEase</h1>
        <p>Discover fresh, premium perishable products at great prices</p>
    </div>
</div>

<!-- Products -->
<div class="product-grid">
    <div class="container">
        <c:choose>
            <c:when test="${empty products}">
                <div class="empty-state">
                    <i class="fas fa-box-open"></i>
                    <h4 style="color:#8888aa;">No products available</h4>
                    <p>Check back soon for fresh arrivals!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="product" items="${products}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-card">
                                <div class="card-img-wrapper">
                                    <img src="${product.image}" alt="${product.name}">
                                </div>
                                <div class="card-body-custom">
                                    <span class="category-badge">${product.category.name}</span>
                                    <div class="product-name">${product.name}</div>
                                    <div class="product-desc">${product.description}</div>
                                    <div class="product-footer">
                                        <span class="price-pill">$${product.price}</span>
                                        <a href="#" class="btn-cart">
                                            <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                        </a>
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
    <p>&copy; 2024 ShopEase. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>