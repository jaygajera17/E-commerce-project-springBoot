<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories – ShopEase Admin</title>
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

        .btn-add {
            background: linear-gradient(135deg, #a855f7, #7c3aed);
            border: none; border-radius: 10px; color: #fff;
            font-weight: 600; padding: 10px 22px; font-size: 0.9rem;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-add:hover { transform: translateY(-1px); box-shadow: 0 8px 24px rgba(168,85,247,0.4); color: #fff; }

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
            background: transparent; transition: background 0.2s;
            border-color: rgba(255,255,255,0.04);
        }
        .table-custom tbody tr:hover { background: rgba(168,85,247,0.06); }
        .table-custom td { vertical-align: middle; padding: 14px 18px; border-color: rgba(255,255,255,0.04); }

        .cat-badge {
            background: rgba(168,85,247,0.15); color: #c084fc;
            border: 1px solid rgba(168,85,247,0.25);
            border-radius: 20px; padding: 3px 12px; font-size: 0.82rem; font-weight: 600;
        }
        .btn-delete {
            background: rgba(239,68,68,0.12); border: 1px solid rgba(239,68,68,0.25);
            color: #f87171; border-radius: 8px; padding: 5px 12px; font-size: 0.8rem;
            font-weight: 600; transition: background 0.2s;
        }
        .btn-delete:hover { background: rgba(239,68,68,0.25); color: #fca5a5; }
        .btn-edit {
            background: rgba(245,158,11,0.12); border: 1px solid rgba(245,158,11,0.25);
            color: #fbbf24; border-radius: 8px; padding: 5px 12px; font-size: 0.8rem;
            font-weight: 600; transition: background 0.2s;
        }
        .btn-edit:hover { background: rgba(245,158,11,0.25); color: #fde68a; }

        /* Modal */
        .modal-content {
            background: #161628; border: 1px solid rgba(168,85,247,0.2); border-radius: 16px;
        }
        .modal-header {
            border-bottom: 1px solid rgba(168,85,247,0.1); padding: 20px 24px;
        }
        .modal-title { color: #fff; font-weight: 700; }
        .btn-close { filter: invert(1) brightness(0.7); }
        .modal-body { padding: 24px; }
        .modal-footer { border-top: 1px solid rgba(168,85,247,0.1); padding: 16px 24px; }
        .modal-body .form-control {
            background: #0d0d1a; border: 1.5px solid #2a2a4a;
            border-radius: 10px; color: #fff;
        }
        .modal-body .form-control:focus {
            background: #0d0d1a; border-color: #a855f7;
            box-shadow: 0 0 0 3px rgba(168,85,247,0.2); color: #fff;
        }
        .modal-body label { color: #9999bb; font-size: 0.88rem; margin-bottom: 6px; }
        .btn-secondary-custom {
            background: #2a2a4a; border: none; color: #9999bb;
            border-radius: 8px; padding: 8px 18px; font-weight: 600;
        }
        .btn-secondary-custom:hover { background: #333355; color: #fff; }
        .btn-primary-custom {
            background: linear-gradient(135deg, #a855f7, #7c3aed);
            border: none; color: #fff; border-radius: 8px; padding: 8px 18px; font-weight: 600;
        }
        .btn-primary-custom:hover { color: #fff; box-shadow: 0 4px 14px rgba(168,85,247,0.4); }

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
        <h2><i class="fas fa-tags me-2"></i>Categories</h2>
        <p>Manage all product categories</p>
    </div>
</div>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 style="color:#9999bb; margin:0">All Categories</h5>
        <button type="button" class="btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
            <i class="fas fa-plus me-2"></i>Add Category
        </button>
    </div>

    <div class="table-wrapper">
        <table class="table table-custom">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Category Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="category" items="${categories}">
                    <tr>
                        <td style="color:#666688; font-size:0.85rem">#${category.id}</td>
                        <td><span class="cat-badge">${category.name}</span></td>
                        <td>
                            <div class="d-flex gap-2">
                                <form action="categories/delete" method="get" style="margin:0">
                                    <input type="hidden" name="id" value="${category.id}">
                                    <button type="submit" class="btn-delete">
                                        <i class="fas fa-trash me-1"></i>Delete
                                    </button>
                                </form>
                                <button type="button" class="btn-edit"
                                        data-bs-toggle="modal" data-bs-target="#editModal"
                                        onclick="document.getElementById('editCategoryName').value='${category.name}'; document.getElementById('editCategoryId').value='${category.id}';">
                                    <i class="fas fa-pen me-1"></i>Update
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="categories" method="post">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus me-2"></i>Add New Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label for="addCatName">Category Name</label>
                    <input type="text" name="categoryname" id="addCatName"
                           class="form-control" placeholder="Enter category name" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-primary-custom">
                        <i class="fas fa-save me-1"></i>Save Category
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="categories/update" method="get">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-pen me-2"></i>Update Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label for="editCategoryId">Category ID</label>
                    <input type="number" class="form-control mb-3" id="editCategoryId"
                           name="categoryid" readonly>
                    <label for="editCategoryName">Category Name</label>
                    <input type="text" class="form-control" id="editCategoryName"
                           name="categoryname" required placeholder="Category name">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-primary-custom">
                        <i class="fas fa-check me-1"></i>Update
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<footer><p>&copy; 2024 ShopEase Admin. All rights reserved.</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>