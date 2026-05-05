<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart – ShopEase</title>
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

        .page-header {
            padding: 30px 0;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 30px;
        }
        .page-header h2 { font-weight: 700; color: #0f172a; margin: 0; font-size: 1.75rem; }

        .table-wrapper {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .table-custom { margin: 0; }
        .table-custom thead th {
            background: #f8fafc;
            color: #64748b;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #e2e8f0;
            padding: 16px;
        }
        .table-custom td {
            vertical-align: middle;
            padding: 16px;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
        }
        .table-custom tbody tr:last-child td { border-bottom: none; }

        .btn-checkout {
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            font-weight: 600;
            transition: background-color 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-checkout:hover {
            background-color: #4338ca;
            color: white;
        }
        .btn-remove {
            color: #ef4444;
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 6px;
            padding: 6px 12px;
            font-size: 0.875rem;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-remove:hover {
            background: #fee2e2;
            color: #dc2626;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-custom">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/">
            <div class="logo-dot"><i class="fas fa-shopping-bag"></i></div> ShopEase
        </a>
        <a href="/" class="btn btn-outline-secondary btn-sm"><i class="fas fa-arrow-left me-1"></i>Back to Shop</a>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2>Your Shopping Cart</h2>
    </div>
</div>

<div class="container py-4">
    <c:choose>
        <c:when test="${empty cartProducts}">
            <div class="text-center py-5">
                <i class="fas fa-cart-arrow-down text-muted" style="font-size: 3rem; margin-bottom: 16px;"></i>
                <h4 class="text-secondary">Your cart is empty</h4>
                <a href="/" class="btn-checkout mt-3">Start Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-wrapper mb-4">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartProducts}">
                            <tr>
                                <td><strong>${item.name}</strong></td>
                                <td><span class="badge bg-light text-secondary border">${item.category.name}</span></td>
                                <td class="fw-bold">$${item.price}</td>
                                <td>
                                    <!-- Add real remove route when implemented in controller -->
                                    <a class="btn-remove" href="#"><i class="fas fa-trash me-1"></i>Remove</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-end">
                <a href="/buy" class="btn-checkout"><i class="fas fa-credit-card me-2"></i>Proceed to Checkout</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>