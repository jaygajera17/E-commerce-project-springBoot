<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers – ShopEase Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f1f5f9; color: #1e293b; min-height: 100vh; }

        .navbar-admin {
            background-color: #ffffff; border-bottom: 1px solid #e2e8f0;
            padding: 12px 0; position: sticky; top: 0; z-index: 100;
        }
        .navbar-brand-text { font-size: 1.25rem; font-weight: 700; color: #0f172a !important; }
        .nav-link-admin { color: #475569 !important; font-weight: 500; border-radius: 6px; padding: 8px 12px !important; }
        .nav-link-admin:hover { background-color: #f1f5f9; color: #0f172a !important; }

        .page-header { padding: 30px 0; background: #ffffff; border-bottom: 1px solid #e2e8f0; margin-bottom: 30px; }
        .page-header h2 { font-weight: 700; color: #0f172a; margin: 0; font-size: 1.5rem; }

        .table-wrapper { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .table-custom { margin: 0; }
        .table-custom thead th { background: #f8fafc; color: #64748b; font-size: 0.75rem; text-transform: uppercase; border-bottom: 1px solid #e2e8f0; padding: 14px 16px; }
        .table-custom td { padding: 14px 16px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }

        .avatar-initials {
            width: 40px; height: 40px; border-radius: 50%;
            display: inline-flex; align-items: center; justify-content: center;
            font-weight: 600; font-size: 0.875rem; color: #0f172a; background: #e2e8f0;
        }
        .customer-name { font-weight: 600; color: #0f172a; }
        .customer-email { color: #64748b; font-size: 0.875rem; }
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

<div class="page-header">
    <div class="container">
        <h2>Customers</h2>
    </div>
</div>

<div class="container mb-5">
    <div class="table-wrapper">
        <table class="table table-custom">
            <thead>
                <tr>
                    <th>Avatar</th>
                    <th>Customer Name</th>
                    <th>Email Address</th>
                    <th>Delivery Address</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="customer" items="${customers}">
                    <tr>
                        <td>
                            <div class="avatar-initials">
                                ${customer.username.substring(0,1).toUpperCase()}
                            </div>
                        </td>
                        <td><span class="customer-name">${customer.username}</span></td>
                        <td><span class="customer-email">${customer.email}</span></td>
                        <td><span class="text-secondary">${customer.address}</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>