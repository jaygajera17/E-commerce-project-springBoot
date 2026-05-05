<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>User Login – ShopEase</title>
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
            background: #0f0c29;
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
            box-shadow: 0 30px 80px rgba(0,0,0,0.5);
        }

        /* Left decorative panel */
        .auth-panel {
            flex: 1;
            background: linear-gradient(135deg, #6c63ff 0%, #3b2dbf 50%, #1a1060 100%);
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
            width: 280px; height: 280px;
            border-radius: 50%;
            background: rgba(255,255,255,0.07);
            top: -60px; left: -60px;
        }
        .auth-panel::after {
            content: '';
            position: absolute;
            width: 200px; height: 200px;
            border-radius: 50%;
            background: rgba(255,255,255,0.05);
            bottom: -50px; right: -50px;
        }
        .auth-panel .brand-icon {
            font-size: 3rem;
            margin-bottom: 16px;
            z-index: 1;
        }
        .auth-panel h2 { font-weight: 700; font-size: 1.8rem; z-index: 1; }
        .auth-panel p  { font-size: 0.95rem; opacity: 0.8; text-align: center; z-index: 1; }

        /* Right form panel */
        .auth-form {
            flex: 1;
            background: #1a1a2e;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .auth-form h3 { color: #fff; font-weight: 700; font-size: 1.6rem; margin-bottom: 6px; }
        .auth-form .sub { color: #8888aa; font-size: 0.9rem; margin-bottom: 30px; }

        .form-floating label { color: #8888aa; }
        .form-floating .form-control {
            background: #0f0c29;
            border: 1.5px solid #2e2e4d;
            border-radius: 10px;
            color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-floating .form-control:focus {
            background: #0f0c29;
            border-color: #6c63ff;
            box-shadow: 0 0 0 3px rgba(108,99,255,0.25);
            color: #fff;
        }
        .form-floating .form-control::placeholder { color: #44446a; }

        .btn-login {
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
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
            box-shadow: 0 8px 24px rgba(108,99,255,0.45);
            color: #fff;
        }
        .btn-login:active { transform: translateY(0); }

        .auth-link { color: #8888aa; font-size: 0.89rem; }
        .auth-link a { color: #6c63ff; text-decoration: none; font-weight: 600; }
        .auth-link a:hover { text-decoration: underline; }

        .error-msg { color: #ff6b7a; font-size: 0.9rem; text-align: center; margin-top: 10px; }

        @media (max-width: 650px) {
            .auth-panel { display: none; }
            .auth-form { padding: 40px 24px; }
        }
    </style>
</head>
<body>

<div class="auth-wrapper">
    <!-- Left panel -->
    <div class="auth-panel">
        <div class="brand-icon"><i class="fas fa-shopping-bag"></i></div>
        <h2>ShopEase</h2>
        <p>Your one-stop destination for fresh perishable products, delivered with care.</p>
    </div>

    <!-- Right form -->
    <div class="auth-form">
        <h3>Welcome back</h3>
        <p class="sub">Sign in to your account</p>

        <form action="/userloginvalidate" method="post">
            <div class="form-floating mb-3">
                <input type="text" name="username" id="username"
                       class="form-control" placeholder="Username" required>
                <label for="username"><i class="fas fa-user me-2"></i>Username</label>
            </div>
            <div class="form-floating mb-4">
                <input type="password" name="password" id="password"
                       class="form-control" placeholder="Password" required>
                <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
            </div>

            <button type="submit" class="btn-login">Sign In</button>

            <p class="error-msg">${msg}</p>
            <p class="auth-link mt-3 text-center">
                Don't have an account? <a href="/register">Register here</a>
            </p>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
