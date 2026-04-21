<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f1f5f9; color: #1e293b; min-height: 100vh; }

        .navbar-admin {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            padding: 12px 0;
            position: sticky; top: 0; z-index: 100;
        }
        .navbar-brand-text {
            font-size: 1.25rem; font-weight: 700; color: #0f172a !important;
            display: flex; align-items: center; gap: 8px;
        }
        .nav-link-admin {
            color: #475569 !important; font-weight: 500;
            padding: 8px 12px !important; border-radius: 6px;
            transition: all 0.2s;
        }
        .nav-link-admin:hover { color: #0f172a !important; background-color: #f1f5f9; }
        .admin-badge {
            background: #eef2ff; color: #4f46e5;
            border: 1px solid #c7d2fe; border-radius: 20px;
            padding: 4px 12px; font-size: 0.875rem; font-weight: 600;
        }

        .page-header { padding: 40px 0; background: #ffffff; border-bottom: 1px solid #e2e8f0; margin-bottom: 40px; }
        .page-header h2 { font-weight: 700; color: #0f172a; margin-bottom: 8px; }
        .page-header p { color: #64748b; margin: 0; }

        .stat-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px;
            text-align: center;
            transition: all 0.2s;
            text-decoration: none;
            display: block; color: inherit;
        }
        .stat-card:hover {
            transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); border-color: #cbd5e1; color: inherit;
        }

        .stat-icon {
            width: 56px; height: 56px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; margin: 0 auto 16px;
        }
        .icon-cat  { background: #eef2ff; color: #4f46e5; }
        .icon-prod { background: #ecfdf5; color: #10b981; }
        .icon-cust { background: #fffbeb; color: #f59e0b; }

        .stat-name  { color: #0f172a; font-size: 1.25rem; font-weight: 600; margin-bottom: 8px; }
        .stat-desc  { color: #64748b; font-size: 0.875rem; margin-bottom: 16px; }

        .btn-manage { font-weight: 600; font-size: 0.875rem; color: #4f46e5; }
        .stat-card:hover .btn-manage { text-decoration: underline; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-admin">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="/admin/">
            <i class="fas fa-shield-halved text-primary"></i> ShopEase Admin
        </a>
        <div class="ms-auto d-flex align-items-center gap-3">
            <span class="admin-badge"><i class="fas fa-user-shield me-1"></i>Admin</span>
            <a class="nav-link-admin" href="/admin/logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2>Dashboard</h2>
        <p>Overview of your store's operations</p>
    </div>
</div>

<div class="container">
    <div class="row g-4">
        <div class="col-lg-4 col-md-6">
            <a href="/admin/categories" class="stat-card">
                <div class="stat-icon icon-cat"><i class="fas fa-tags"></i></div>
                <div class="stat-name">Categories</div>
                <div class="stat-desc">Manage product categories</div>
                <div class="btn-manage">View Categories &rarr;</div>
            </a>
        </div>
        <div class="col-lg-4 col-md-6">
            <a href="/admin/products" class="stat-card">
                <div class="stat-icon icon-prod"><i class="fas fa-box-open"></i></div>
                <div class="stat-name">Products</div>
                <div class="stat-desc">Manage inventory and pricing</div>
                <div class="btn-manage">View Products &rarr;</div>
            </a>
        </div>
        <div class="col-lg-4 col-md-6">
            <a href="/admin/customers" class="stat-card">
                <div class="stat-icon icon-cust"><i class="fas fa-users"></i></div>
                <div class="stat-name">Customers</div>
                <div class="stat-desc">View registered users</div>
                <div class="btn-manage">View Customers &rarr;</div>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>