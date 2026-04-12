<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }
        body { background: #0d0d1a; color: #e0e0f0; min-height: 100vh; }

        .navbar-admin {
            background: rgba(13,13,26,0.97);
            border-bottom: 1px solid rgba(168,85,247,0.15);
            backdrop-filter: blur(20px);
            padding: 14px 0; position: sticky; top: 0; z-index: 100;
        }
        .navbar-brand-text {
            font-size: 1.35rem; font-weight: 700; color: #fff !important;
            display: flex; align-items: center; gap: 10px;
        }
        .logo-dot {
            width: 32px; height: 32px;
            background: linear-gradient(135deg, #a855f7, #7c3aed);
            border-radius: 8px; display: flex; align-items: center;
            justify-content: center; font-size: 0.85rem; color: #fff;
        }
        .nav-link-admin {
            color: #9999bb !important; font-weight: 500;
            padding: 6px 14px !important; border-radius: 8px;
            transition: color 0.2s, background 0.2s;
        }
        .nav-link-admin:hover { color: #fff !important; background: rgba(168,85,247,0.15); }
        .admin-badge {
            background: rgba(168,85,247,0.15); border: 1px solid rgba(168,85,247,0.3);
            border-radius: 20px; padding: 4px 12px; font-size: 0.8rem; color: #c084fc;
        }

        /* Hero */
        .hero {
            background: linear-gradient(135deg, #2d1b69 0%, #1a0a3d 50%, #0d0d1a 100%);
            padding: 60px 0 50px; text-align: center; position: relative; overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(168,85,247,0.1) 0%, transparent 70%);
            top: -200px; left: 50%; transform: translateX(-50%);
        }
        .hero h1 {
            font-size: 2.6rem; font-weight: 800;
            background: linear-gradient(135deg, #fff, #c084fc);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
        }
        .hero p { color: #9977bb; font-size: 1rem; }

        /* Stat cards */
        .stat-card {
            background: #161628;
            border: 1px solid rgba(255,255,255,0.06);
            border-radius: 20px; padding: 36px 30px;
            text-align: center; position: relative; overflow: hidden;
            transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
            cursor: pointer; text-decoration: none; display: block; color: inherit;
        }
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 24px 60px rgba(0,0,0,0.4);
            color: inherit; text-decoration: none;
        }
        .stat-card::before {
            content: '';
            position: absolute; top: 0; left: 0; right: 0; height: 3px;
        }

        .card-cat::before  { background: linear-gradient(90deg, #6c63ff, #3b2dbf); }
        .card-prod::before { background: linear-gradient(90deg, #10b981, #059669); }
        .card-cust::before { background: linear-gradient(90deg, #f59e0b, #d97706); }

        .card-cat:hover  { border-color: rgba(108,99,255,0.3); }
        .card-prod:hover { border-color: rgba(16,185,129,0.3); }
        .card-cust:hover { border-color: rgba(245,158,11,0.3); }

        .stat-icon {
            width: 64px; height: 64px; border-radius: 18px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.6rem; margin: 0 auto 20px;
        }
        .icon-cat  { background: rgba(108,99,255,0.15); color: #818cf8; }
        .icon-prod { background: rgba(16,185,129,0.15); color: #34d399; }
        .icon-cust { background: rgba(245,158,11,0.15); color: #fbbf24; }

        .stat-title { color: #7777aa; font-size: 0.82rem; font-weight: 600;
                      letter-spacing: 0.8px; text-transform: uppercase; margin-bottom: 6px; }
        .stat-name  { color: #fff; font-size: 1.4rem; font-weight: 700; margin-bottom: 8px; }
        .stat-desc  { color: #666688; font-size: 0.85rem; margin-bottom: 20px; }

        .btn-manage {
            border: none; border-radius: 10px; font-size: 0.85rem;
            font-weight: 600; padding: 9px 22px; transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-cat  { background: linear-gradient(135deg,#6c63ff,#3b2dbf); color:#fff; }
        .btn-prod { background: linear-gradient(135deg,#10b981,#059669); color:#fff; }
        .btn-cust { background: linear-gradient(135deg,#f59e0b,#d97706); color:#fff; }
        .btn-manage:hover { transform: translateY(-1px); box-shadow: 0 6px 18px rgba(0,0,0,0.3); color:#fff; }

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
            <div class="ms-auto d-flex align-items-center gap-3 flex-wrap">
                <span class="admin-badge"><i class="fas fa-user-shield me-1"></i>Administrator</span>
                <a class="nav-link-admin" href="/admin/">
                    <i class="fas fa-house me-1"></i>Dashboard
                </a>
                <a class="nav-link-admin" href="/admin/logout">
                    <i class="fas fa-right-from-bracket me-1"></i>Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="hero">
    <div class="container">
        <h1><i class="fas fa-gauge-high me-2"></i>Admin Dashboard</h1>
        <p>Manage your ShopEase store from one central place</p>
    </div>
</div>

<div class="container py-5">
    <div class="row g-4 justify-content-center">

        <div class="col-lg-4 col-md-6">
            <div class="stat-card card-cat">
                <div class="stat-icon icon-cat"><i class="fas fa-tags"></i></div>
                <div class="stat-title">Manage</div>
                <div class="stat-name">Categories</div>
                <div class="stat-desc">Add, update, or remove product categories available on the store.</div>
                <a href="/admin/categories" class="btn-manage btn-cat">
                    <i class="fas fa-arrow-right me-2"></i>Manage Categories
                </a>
            </div>
        </div>

        <div class="col-lg-4 col-md-6">
            <div class="stat-card card-prod">
                <div class="stat-icon icon-prod"><i class="fas fa-box-open"></i></div>
                <div class="stat-title">Manage</div>
                <div class="stat-name">Products</div>
                <div class="stat-desc">View, add, update pricing and stock for all available products.</div>
                <a href="/admin/products" class="btn-manage btn-prod">
                    <i class="fas fa-arrow-right me-2"></i>Manage Products
                </a>
            </div>
        </div>

        <div class="col-lg-4 col-md-6">
            <div class="stat-card card-cust">
                <div class="stat-icon icon-cust"><i class="fas fa-users"></i></div>
                <div class="stat-title">Manage</div>
                <div class="stat-name">Customers</div>
                <div class="stat-desc">View all registered customers and their account details.</div>
                <a href="/admin/customers" class="btn-manage btn-cust">
                    <i class="fas fa-arrow-right me-2"></i>Manage Customers
                </a>
            </div>
        </div>

    </div>
</div>

<footer><p>&copy; 2024 ShopEase Admin Panel. All rights reserved.</p></footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>