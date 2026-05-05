<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products – ShopEase Admin</title>
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
            padding: 40px 0 35px; text-align: center;
        }
        .page-header h2 {
            font-size: 2rem; font-weight: 800;
            background: linear-gradient(135deg, #fff, #c084fc);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .page-header p { color: #9977bb; }

        .btn-add-product {
            background: linear-gradient(135deg, #10b981, #059669);
            border: none; border-radius: 10px; color: #fff;
            font-weight: 600; padding: 10px 22px; font-size: 0.9rem;
            text-decoration: none; display: inline-block;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-add-product:hover { transform: translateY(-1px); box-shadow: 0 8px 24px rgba(16,185,129,0.35); color: #fff; }

        .table-wrapper {
            background: #161628; border: 1px solid rgba(168,85,247,0.1);
            border-radius: 16px; overflow: hidden;
        }
        .table-custom { color: #e0e0f0; margin: 0; }
        .table-custom thead th {
            background: rgba(168,85,247,0.1); color: #c084fc;
            font-size: 0.78rem; font-weight: 600; letter-spacing: 0.6px;
            text-transform: uppercase; border-color: rgba(168,85,247,0.1); padding: 14px 16px;
        }
        .table-custom tbody tr { background: transparent; transition: background 0.2s; border-color: rgba(255,255,255,0.04); }
        .table-custom tbody tr:hover { background: rgba(168,85,247,0.06); }
        .table-custom td { vertical-align: middle; padding: 12px 16px; border-color: rgba(255,255,255,0.04); }

        .product-thumb {
            width: 56px; height: 56px; border-radius: 10px;
            object-fit: cover; background: #12121f;
            border: 1px solid rgba(168,85,247,0.15);
        }
        .product-thumb-placeholder {
            width: 56px; height: 56px; border-radius: 10px;
            background: #1a1a2e; display: flex; align-items: center;
            justify-content: center; color: #333355; font-size: 1.2rem;
            border: 1px solid rgba(168,85,247,0.15);
        }
        .cat-badge {
            background: rgba(168,85,247,0.12); color: #c084fc;
            border-radius: 20px; padding: 2px 10px; font-size: 0.75rem; font-weight: 600;
        }
        .price-text { color: #34d399; font-weight: 700; }
        .qty-text { color: #fbbf24; }

        .btn-delete {
            background: rgba(239,68,68,0.12); border: 1px solid rgba(239,68,68,0.25);
            color: #f87171; border-radius: 8px; padding: 5px 10px; font-size: 0.78rem;
            font-weight: 600; transition: background 0.2s;
        }
        .btn-delete:hover { background: rgba(239,68,68,0.25); color: #fca5a5; }
        .btn-edit {
            background: rgba(245,158,11,0.12); border: 1px solid rgba(245,158,11,0.25);
            color: #fbbf24; border-radius: 8px; padding: 5px 10px; font-size: 0.78rem;
            font-weight: 600; transition: background 0.2s; text-decoration: none; display: inline-block;
        }
        .btn-edit:hover { background: rgba(245,158,11,0.25); color: #fde68a; }

        footer {
            background: #080814; border-top: 1px solid rgba(168,85,247,0.08);
            padding: 20px 0; text-align: center; color: #333355; font-size: 0.85rem;
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
                <a class="nav-link-admin" href="/admin/"><i class="fas fa-house me-1"></i>Dashboard</a>
                <a class="nav-link-admin" href="/admin/logout"><i class="fas fa-right-from-bracket me-1"></i>Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2><i class="fas fa-box-open me-2"></i>Products</h2>
        <p>Manage your product inventory</p>
    </div>
</div>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
        <h5 style="color:#9999bb; margin:0">All Products</h5>
        <a href="/admin/products/add" class="btn-add-product">
            <i class="fas fa-plus me-2"></i>Add Product
        </a>
    </div>

    <div class="table-wrapper">
        <div class="table-responsive">
            <table class="table table-custom">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Preview</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Weight</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td style="color:#666688; font-size:0.83rem">#${product.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty product.image}">
                                        <img class="product-thumb" src="${product.image}" alt="${product.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-thumb-placeholder"><i class="fas fa-image"></i></div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong style="color:#fff">${product.name}</strong></td>
                            <td><span class="cat-badge">${product.category.name}</span></td>
                            <td><span class="price-text">$${product.price}</span></td>
                            <td><span class="qty-text">${product.quantity}</span></td>
                            <td style="color:#9999bb">${product.weight}g</td>
                            <td style="color:#7777aa; font-size:0.82rem; max-width:180px">${product.description}</td>
                            <td>
                                <div class="d-flex gap-2 flex-wrap">
                                    <form action="products/delete" method="get" style="margin:0">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <button type="submit" class="btn-delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                    <a href="products/update/${product.id}" class="btn-edit">
                                        <i class="fas fa-pen"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<footer><p>&copy; 2024 ShopEase Admin. All rights reserved.</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>