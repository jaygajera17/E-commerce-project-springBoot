<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${empty pageTitle ? 'Update Profile' : pageTitle} - ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background:
                radial-gradient(circle at top left, rgba(79, 70, 229, 0.08), transparent 26%),
                #f8fafc;
            color: #1e293b;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar-custom {
            background-color: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid #e2e8f0;
            padding: 12px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand-text {
            font-size: 1.25rem;
            font-weight: 700;
            color: #0f172a !important;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .main-content {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .profile-card {
            background: #ffffff;
            width: 100%;
            max-width: 520px;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(15, 23, 42, 0.08);
            border: 1px solid #e2e8f0;
        }

        .avatar-ring {
            width: 84px;
            height: 84px;
            background: #eef2ff;
            color: #4f46e5;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 20px;
        }

        .subtitle {
            color: #64748b;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-floating label { color: #64748b; }
        .form-floating .form-control {
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            color: #0f172a;
            box-shadow: none;
            transition: all 0.2s;
        }
        .form-floating .form-control:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .helper-text {
            font-size: 0.85rem;
            color: #64748b;
            margin-top: -8px;
            margin-bottom: 16px;
        }

        .btn-primary-custom {
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            transition: background-color 0.2s;
        }

        .btn-primary-custom:hover {
            background-color: #4338ca;
            color: white;
        }

        .error-msg {
            color: #dc2626;
            font-size: 0.9rem;
            text-align: center;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-custom">
    <div class="container">
        <a class="navbar-brand navbar-brand-text" href="${empty backLink ? '/' : backLink}">
            <i class="fas fa-user-gear"></i> ShopEase
        </a>
        <a href="${empty backLink ? '/' : backLink}" class="btn btn-outline-secondary btn-sm"><i class="fas fa-arrow-left me-1"></i>Back</a>
    </div>
</nav>

<div class="main-content">
    <div class="profile-card">
        <div class="avatar-ring"><i class="fas fa-user-circle"></i></div>
        <h3 class="text-center mb-2 fw-bold">${empty pageTitle ? 'Update Profile' : pageTitle}</h3>
        <p class="subtitle">Keep your account details current. Leave the password field blank if you do not want to change it.</p>

        <div class="error-msg">${msg}</div>

        <form action="${empty formAction ? '/updateuser' : formAction}" method="post">
            <input type="hidden" name="userid" value="${userid}">

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="username" name="username" value="${username}" required>
                <label for="username"><i class="fas fa-user text-muted me-2"></i>Username</label>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                <label for="email"><i class="fas fa-envelope text-muted me-2"></i>Email</label>
            </div>

            <div class="form-floating mb-2">
                <input type="password" class="form-control" id="password" name="password" placeholder="New password">
                <label for="password"><i class="fas fa-lock text-muted me-2"></i>New Password</label>
            </div>
            <div class="helper-text">Leave blank to keep your current password.</div>

            <div class="form-floating mb-4">
                <input type="text" class="form-control" id="address" name="address" value="${address}" required>
                <label for="address"><i class="fas fa-location-dot text-muted me-2"></i>Address</label>
            </div>

            <button type="submit" class="btn-primary-custom"><i class="fas fa-save me-2"></i>Save Changes</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
