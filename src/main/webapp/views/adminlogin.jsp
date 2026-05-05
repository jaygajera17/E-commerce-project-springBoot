<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Admin Login – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }

        body {
            min-height: 100vh;
            margin: 0;
            background: #0d0d1a;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-wrapper {
            display: flex;
            width: 900px;
            max-width: 95vw;
            min-height: 520px;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(0,0,0,0.6);
        }

        .auth-panel {
            flex: 1;
            background: linear-gradient(135deg, #a855f7 0%, #7c3aed 50%, #2d1b69 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 30px;
            color: #fff;
            position: relative;
            overflow: hidden;
        }
        .auth-panel::before {
            content: '';
            position: absolute;
            width: 300px; height: 300px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
            top: -80px; left: -80px;
        }
        .auth-panel::after {
            content: '';
            position: absolute;
            width: 220px; height: 220px;
            border-radius: 50%;
            background: rgba(255,255,255,0.04);
            bottom: -60px; right: -60px;
        }
        .auth-panel .brand-icon { font-size: 3rem; margin-bottom: 16px; z-index: 1; }
        .auth-panel h2 { font-weight: 700; font-size: 1.8rem; z-index: 1; }
        .auth-panel p  { font-size: 0.95rem; opacity: 0.8; text-align: center; z-index: 1; }

        .shield-badge {
            background: rgba(255,255,255,0.15);
            border-radius: 50%;
            width: 70px; height: 70px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 14px;
            z-index: 1;
            backdrop-filter: blur(10px);
        }

        .auth-form {
            flex: 1;
            background: #161628;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .auth-form h3 { color: #fff; font-weight: 700; font-size: 1.6rem; margin-bottom: 4px; }
        .auth-form .sub { color: #7777aa; font-size: 0.9rem; margin-bottom: 30px; }

        .form-floating label { color: #7777aa; }
        .form-floating .form-control {
            background: #0d0d1a;
            border: 1.5px solid #2a2a4a;
            border-radius: 10px;
            color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-floating .form-control:focus {
            background: #0d0d1a;
            border-color: #a855f7;
            box-shadow: 0 0 0 3px rgba(168,85,247,0.25);
            color: #fff;
        }

        .btn-login {
            background: linear-gradient(135deg, #a855f7, #7c3aed);
            border: none;
            border-radius: 10px;
            color: #fff;
            font-weight: 600;
            font-size: 1rem;
            padding: 12px;
            width: 100%;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(168,85,247,0.45);
            color: #fff;
        }
        .btn-login:active { transform: translateY(0); }

        .error-msg { color: #ff6b7a; font-size: 0.9rem; text-align: center; margin-top: 10px; }

        @media (max-width: 650px) {
            .auth-panel { display: none; }
            .auth-form { padding: 40px 24px; }
        }
    </style>
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-panel">
        <div class="shield-badge"><i class="fas fa-shield-halved"></i></div>
        <h2>Admin Portal</h2>
        <p>Secure access to ShopEase administration. Authorised personnel only.</p>
    </div>

    <div class="auth-form">
        <h3>Admin Sign In</h3>
        <p class="sub">Enter your admin credentials to continue</p>

        <form action="/admin/loginvalidate" method="post">
            <div class="form-floating mb-3">
                <input type="text" name="username" id="username"
                       class="form-control" placeholder="Admin Username" required>
                <label for="username"><i class="fas fa-user-shield me-2"></i>Admin Username</label>
            </div>
            <div class="form-floating mb-4">
                <input type="password" name="password" id="password"
                       class="form-control" placeholder="Password" required>
                <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
            </div>

            <button type="submit" class="btn-login">
                <i class="fas fa-right-to-bracket me-2"></i>Sign In
            </button>

            <p class="error-msg">${msg}</p>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
