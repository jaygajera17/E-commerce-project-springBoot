<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
            min-height: 100vh;
        }

        /* Navbar */
        .navbar-custom {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            padding: 12px 0;
            position: sticky;
            top: 0; z-index: 100;
        }
        .navbar-brand-text {
            font-size: 1.25rem;
            font-weight: 700;
            color: #0f172a !important;
            display: flex; align-items: center; gap: 8px;
        }
        .navbar-brand-text .logo-dot {
            width: 32px; height: 32px;
            background: #eef2ff;
            color: #4f46e5;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem;
        }
        .nav-link-custom {
            color: #475569 !important;
            font-weight: 500;
            transition: all 0.2s;
            padding: 8px 12px !important;
            border-radius: 6px;
        }
        .nav-link-custom:hover { color: #0f172a !important; background-color: #f1f5f9; }

        .page-header {
            padding: 30px 0;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 30px;
        }
        .page-header h2 { font-weight: 700; color: #0f172a; margin: 0; font-size: 1.75rem; }

        .product-grid { padding-bottom: 60px; }

        .product-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.2s;
            height: 100%;
            display: flex; flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            border-color: #cbd5e1;
        }

        .card-img-wrapper {
            background: #f8fafc;
            height: 180px;
            display: flex; align-items: center; justify-content: center;
            border-bottom: 1px solid #f1f5f9;
            padding: 16px;
            position: relative;
        }
        .card-img-wrapper img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }
        .stock-badge {
            position: absolute;
            top: 12px; right: 12px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            color: #64748b;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 2px 8px;
            border-radius: 12px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .card-body-custom {
            padding: 20px;
            display: flex; flex-direction: column; flex: 1;
        }
        .category-badge {
            display: inline-block;
            background: #eef2ff;
            color: #4f46e5;
            border-radius: 20px;
            padding: 2px 10px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .product-name {
            color: #0f172a;
            font-weight: 700;
            font-size: 1.125rem;
            margin-bottom: 6px;
        }
        .product-desc {
            color: #64748b;
            font-size: 0.875rem;
            line-height: 1.5;
            flex: 1;
            margin-bottom: 20px;
        }
        .product-footer {
            display: flex; align-items: center; justify-content: space-between;
            margin-top: auto;
        }
        .price-text {
            color: #0f172a;
            font-weight: 700;
            font-size: 1.25rem;
        }
        .btn-cart {
            background-color: #4f46e5;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 600;
            padding: 8px 16px;
            transition: background-color 0.2s;
        }
        .btn-cart:hover { background-color: #4338ca; color: #ffffff; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/">
            <div class="logo-dot"><i class="fas fa-shopping-bag"></i></div>
            ShopEase
        </a>
        <div class="ms-auto d-flex gap-2">
            <a class="nav-link-custom" href="/user/cartproducts"><i class="fas fa-cart-shopping me-1"></i>Cart</a>
            <a class="nav-link-custom" href="/profileDisplay"><i class="fas fa-user me-1"></i>Profile</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2>All Products</h2>
    </div>
</div>

<div class="product-grid">
    <div class="container">
        <c:choose>
            <c:when test="${empty products}">
                <div class="text-center py-5 text-muted">No products available at the moment.</div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="product" items="${products}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-card">
                                <div class="card-img-wrapper">
                                    <span class="stock-badge">${product.quantity} in stock</span>
                                    <img src="${product.image}" alt="${product.name}">
                                </div>
                                <div class="card-body-custom">
                                    <span class="category-badge">${product.category.name}</span>
                                    <div class="product-name">${product.name}</div>
                                    <div class="product-desc">${product.description}</div>
                                    <div class="product-footer">
                                        <span class="price-text">$${product.price}</span>
                                        <!-- Form to add item to cart -->
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>