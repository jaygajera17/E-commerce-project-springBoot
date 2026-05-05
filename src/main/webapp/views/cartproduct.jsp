<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }
        body { background: #0f0f1a; color: #e0e0f0; min-height: 100vh; }

        .navbar-custom {
            background: rgba(15,12,40,0.95); backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(108,99,255,0.15);
            padding: 14px 0; position: sticky; top: 0; z-index: 100;
        }
        .navbar-brand-text {
            font-size: 1.4rem; font-weight: 700; color: #fff !important;
            display: flex; align-items: center; gap: 10px;
        }
        .navbar-brand-text .logo-dot {
            width: 32px; height: 32px;
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            border-radius: 8px; display: flex; align-items: center;
            justify-content: center; font-size: 0.9rem;
        }
        .nav-link-custom {
            color: #9999bb !important; font-weight: 500;
            transition: color 0.2s; padding: 6px 14px !important; border-radius: 8px;
        }
        .nav-link-custom:hover { color: #fff !important; background: rgba(108,99,255,0.15); }

        .page-header {
            background: linear-gradient(135deg, #1a1060, #0f0c29, #0f0f1a);
            padding: 40px 0 35px; text-align: center;
        }
        .page-header h2 {
            font-size: 2rem; font-weight: 800;
            background: linear-gradient(135deg, #fff, #b8b0ff);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .page-header p { color: #8888aa; }

        .cart-table-wrapper {
            background: #1a1a2e;
            border: 1px solid rgba(108,99,255,0.12);
            border-radius: 16px; overflow: hidden;
        }
        .table-dark-custom {
            color: #e0e0f0; margin: 0; border-color: transparent;
        }
        .table-dark-custom thead th {
            background: rgba(108,99,255,0.12);
            color: #9999ff; font-size: 0.8rem; font-weight: 600;
            letter-spacing: 0.5px; text-transform: uppercase;
            border-color: rgba(108,99,255,0.1); padding: 14px 16px;
        }
        .table-dark-custom tbody tr {
            background: transparent;
            border-color: rgba(255,255,255,0.04);
            transition: background 0.2s;
        }
        .table-dark-custom tbody tr:hover { background: rgba(108,99,255,0.06); }
        .table-dark-custom td {
            vertical-align: middle; padding: 14px 16px;
            border-color: rgba(255,255,255,0.04); color: #c8c8e8;
        }

        .btn-remove {
            background: rgba(239,68,68,0.15); border: 1px solid rgba(239,68,68,0.3);
            color: #f87171; border-radius: 8px; padding: 5px 12px;
            font-size: 0.82rem; font-weight: 600; transition: background 0.2s;
        }
        .btn-remove:hover { background: rgba(239,68,68,0.3); color: #fca5a5; }

        .price-text { color: #34d399; font-weight: 600; }

        .empty-cart {
            text-align: center; padding: 80px 20px;
        }
        .empty-cart i { font-size: 4rem; color: #333355; margin-bottom: 20px; }
        .empty-cart h4 { color: #7777aa; }

        .btn-shop {
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            border: none; border-radius: 10px; color: #fff;
            font-weight: 600; padding: 10px 24px; text-decoration: none;
            display: inline-block; transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-shop:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(108,99,255,0.4); color: #fff;
        }

        footer {
            background: #0a0a14; border-top: 1px solid rgba(108,99,255,0.1);
            padding: 20px 0; text-align: center; color: #444466; font-size: 0.85rem;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/user/products">
            <div class="logo-dot"><i class="fas fa-shopping-bag"></i></div>
            ShopEase
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#mainNav" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <div class="ms-auto d-flex align-items-center gap-2">
                <a class="nav-link-custom" href="/user/products">
                    <i class="fas fa-store me-1"></i>Continue Shopping
                </a>
                <a class="nav-link-custom" href="/logout">
                    <i class="fas fa-right-from-bracket me-1"></i>Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2><i class="fas fa-cart-shopping me-2"></i>My Cart</h2>
        <p>Review the items added to your cart</p>
    </div>
</div>

<div class="container py-5">
    <c:choose>
        <c:when test="${empty cartProducts}">
            <div class="empty-cart">
                <i class="fas fa-cart-arrow-down"></i>
                <h4>Your cart is empty</h4>
                <p style="color:#555577; margin-bottom:24px">Looks like you haven't added anything yet.</p>
                <a href="/user/products" class="btn-shop">
                    <i class="fas fa-store me-2"></i>Browse Products
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="cart-table-wrapper">
                <table class="table table-dark-custom">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Description</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartProducts}">
                            <tr>
                                <td>${item.id}</td>
                                <td><strong style="color:#fff">${item.name}</strong></td>
                                <td><span class="price-text">$${item.price}</span></td>
                                <td>${item.description}</td>
                                <td>
                                    <form action="cart/delete" method="get" style="margin:0">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <button type="submit" class="btn-remove">
                                            <i class="fas fa-trash me-1"></i>Remove
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer><p>&copy; 2024 ShopEase. All rights reserved.</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>