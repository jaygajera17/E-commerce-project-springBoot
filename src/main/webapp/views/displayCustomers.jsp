<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers – ShopEase Admin</title>
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

        .table-wrapper {
            background: #161628; border: 1px solid rgba(168,85,247,0.1);
            border-radius: 16px; overflow: hidden;
        }
        .table-custom { color: #e0e0f0; margin: 0; }
        .table-custom thead th {
            background: rgba(168,85,247,0.1); color: #c084fc;
            font-size: 0.78rem; font-weight: 600; letter-spacing: 0.6px;
            text-transform: uppercase; border-color: rgba(168,85,247,0.1); padding: 14px 18px;
        }
        .table-custom tbody tr {
            background: transparent; transition: background 0.2s; border-color: rgba(255,255,255,0.04);
        }
        .table-custom tbody tr:hover { background: rgba(168,85,247,0.06); }
        .table-custom td { vertical-align: middle; padding: 14px 18px; border-color: rgba(255,255,255,0.04); }

        .avatar-initials {
            width: 40px; height: 40px; border-radius: 50%;
            display: inline-flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 0.85rem; color: #fff; flex-shrink: 0;
        }
        .customer-name { font-weight: 600; color: #e0e0f0; }
        .customer-email { color: #7777aa; font-size: 0.85rem; }
        .customer-addr { color: #666688; font-size: 0.83rem; max-width: 200px; }

        footer {
            background: #080814; border-top: 1px solid rgba(168,85,247,0.08);
            padding: 20px 0; text-align: center; color: #333355; font-size: 0.85rem;
        }

        .count-badge {
            background: rgba(168,85,247,0.15); border: 1px solid rgba(168,85,247,0.25);
            border-radius: 20px; padding: 4px 14px; font-size: 0.8rem; color: #c084fc;
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
        <h2><i class="fas fa-users me-2"></i>Customers</h2>
        <p>View all registered customers</p>
    </div>
</div>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 style="color:#9999bb; margin:0">All Customers</h5>
    </div>

    <div class="table-wrapper">
        <table class="table table-custom">
            <thead>
                <tr>
                    <th>Avatar</th>
                    <th>Customer</th>
                    <th>Email</th>
                    <th>Address</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="customer" items="${customers}">
                    <tr>
                        <td>
                            <div class="avatar-initials" style="background: hsl(${customer.username.charAt(0).hashCode() % 360}, 60%, 35%)">
                                ${customer.username.substring(0,1).toUpperCase()}
                            </div>
                        </td>
                        <td>
                            <span class="customer-name">${customer.username}</span>
                        </td>
                        <td><span class="customer-email">${customer.email}</span></td>
                        <td><span class="customer-addr">${customer.address}</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<footer><p>&copy; 2024 ShopEase Admin. All rights reserved.</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>