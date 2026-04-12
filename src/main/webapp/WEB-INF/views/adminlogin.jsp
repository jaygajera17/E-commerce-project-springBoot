<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Admin Login – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f1f5f9;
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
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
            border-top: 4px solid #0f172a;
        }

        .brand {
            text-align: center;
            margin-bottom: 30px;
        }
        .brand-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 56px; height: 56px;
            background: #f8fafc;
            color: #0f172a;
            border-radius: 50%;
            border: 1px solid #e2e8f0;
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
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            color: #0f172a;
            box-shadow: none;
            transition: all 0.2s;
        }
        .form-floating .form-control:focus {
            border-color: #0f172a;
            box-shadow: 0 0 0 3px rgba(15, 23, 42, 0.1);
        }

        .btn-admin {
            background-color: #0f172a;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            transition: background-color 0.2s;
        }
        .btn-admin:hover {
            background-color: #1e293b;
            color: white;
        }

        .error-msg {
            color: #ef4444;
            font-size: 0.875rem;
            text-align: center;
            margin-top: 12px;
            min-height: 20px;
        }
    </style>
</head>
<body>

<div class="auth-card">
    <div class="brand">
        <div class="brand-icon"><i class="fas fa-shield-halved"></i></div>
        <h2>Admin Portal</h2>
        <p>Secure administrative access</p>
    </div>

    <form action="/admin/loginvalidate" method="post">
        <div class="form-floating mb-3">
            <input type="text" name="username" id="username" class="form-control" placeholder="Admin Username" required>
            <label for="username"><i class="fas fa-user-shield text-muted me-2"></i>Admin Username</label>
        </div>
        <div class="form-floating mb-4">
            <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
            <label for="password"><i class="fas fa-key text-muted me-2"></i>Password</label>
        </div>

        <button type="submit" class="btn-admin">Sign In</button>

        <div class="error-msg">${msg}</div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
