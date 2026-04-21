<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories – ShopEase Admin</title>
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

        .btn-add { background-color: #0f172a; color: white; border: none; border-radius: 8px; padding: 10px 20px; font-weight: 500; }
        .btn-add:hover { background-color: #334155; color: white; }

        .table-wrapper { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .table-custom { margin: 0; }
        .table-custom thead th { background: #f8fafc; color: #64748b; font-size: 0.75rem; text-transform: uppercase; border-bottom: 1px solid #e2e8f0; padding: 14px 16px; }
        .table-custom td { padding: 14px 16px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }

        .btn-action { background: none; border: 1px solid #e2e8f0; border-radius: 6px; padding: 6px 12px; font-size: 0.875rem; color: #475569; font-weight: 500; transition: all 0.2s; }
        .btn-action.edit:hover { background: #f8fafc; color: #0f172a; border-color: #cbd5e1; }
        .btn-action.delete { color: #ef4444; border-color: #fecaca; background: #fef2f2; }
        .btn-action.delete:hover { background: #fee2e2; }

        .modal-content { border-radius: 12px; border: none; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1); }
        .modal-header { border-bottom: 1px solid #e2e8f0; }
        .modal-footer { border-top: 1px solid #e2e8f0; }
        .form-control { border-radius: 8px; border: 1px solid #cbd5e1; }
        .form-control:focus { border-color: #0f172a; box-shadow: 0 0 0 3px rgba(15,23,42,0.1); }
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
    <div class="container d-flex justify-content-between align-items-center">
        <h2>Categories</h2>
        <button type="button" class="btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
            <i class="fas fa-plus me-1"></i>Add Category
        </button>
    </div>
</div>

<div class="container mb-5">
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
                        <td class="text-secondary">#${category.id}</td>
                        <td class="fw-semibold">${category.name}</td>
                        <td>
                            <div class="d-flex gap-2">
                                <button type="button" class="btn-action edit" data-bs-toggle="modal" data-bs-target="#editModal"
                                        onclick="document.getElementById('editCategoryName').value='${category.name}'; document.getElementById('editCategoryId').value='${category.id}';">
                                    <i class="fas fa-pen me-1"></i>Edit
                                </button>
                                <form action="categories/delete" method="get" style="margin:0;">
                                    <input type="hidden" name="id" value="${category.id}">
                                    <button type="submit" class="btn-action delete"><i class="fas fa-trash me-1"></i>Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="categories" method="post">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Add Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <label class="form-label text-secondary fw-semibold">Category Name</label>
                    <input type="text" name="categoryname" class="form-control" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="categories/update" method="get">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Edit Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <input type="hidden" id="editCategoryId" name="categoryid">
                    <label class="form-label text-secondary fw-semibold">Category Name</label>
                    <input type="text" id="editCategoryName" name="categoryname" class="form-control" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>