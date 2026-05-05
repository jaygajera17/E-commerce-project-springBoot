<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>User Login – ShopEase</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .auth-card {
            background: #ffffff;
            width: 100%;
            max-width: 440px;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 10px 15px -3px rgba(0, 0, 0, 0.05);
            border: 1px solid #f1f5f9;
        }

        .brand {
            text-align: center;
            margin-bottom: 30px;
        }
        .brand-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 48px; height: 48px;
            background: #eef2ff;
            color: #4f46e5;
            border-radius: 12px;
            font-size: 1.5rem;
            margin-bottom: 16px;
        }
        .brand h2 {
            font-weight: 700;
            font-size: 1.5rem;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .brand p {
            color: #64748b;
            font-size: 0.95rem;
            margin: 0;
        }

        .form-floating label { color: #64748b; }
        .form-floating .form-control {
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            color: #1e293b;
            box-shadow: none;
            transition: all 0.2s;
        }
        .form-floating .form-control:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
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
            color: #ef4444;
            font-size: 0.875rem;
            text-align: center;
            margin-top: 12px;
            min-height: 20px;
        }

        .auth-link {
            text-align: center;
            margin-top: 24px;
            font-size: 0.9rem;
            color: #64748b;
        }
        .auth-link a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
        }
        .auth-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="auth-card">
    <div class="brand">
        <div class="brand-icon"><i class="fas fa-shopping-bag"></i></div>
        <h2>Welcome back</h2>
        <p>Sign in to your account</p>
    </div>

    <form action="/userloginvalidate" method="post">
        <div class="form-floating mb-3">
            <input type="text" name="username" id="username" class="form-control" placeholder="Username" required>
            <label for="username"><i class="fas fa-user text-muted me-2"></i>Username</label>
        </div>
        <div class="form-floating mb-4">
            <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
            <label for="password"><i class="fas fa-lock text-muted me-2"></i>Password</label>
        </div>

        <button type="submit" class="btn-primary-custom">Sign In</button>

        <div class="error-msg">${msg}</div>

        <div class="auth-link">
            Don't have an account? <a href="/register">Register here</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
