<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f0c29 0%, #1a1060 50%, #24243e 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 16px;
        }

        .register-card {
            background: rgba(26,26,46,0.95);
            border: 1px solid rgba(108,99,255,0.2);
            border-radius: 24px;
            padding: 48px 44px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 30px 80px rgba(0,0,0,0.5);
            backdrop-filter: blur(20px);
        }

        .brand {
            text-align: center;
            margin-bottom: 32px;
        }
        .brand .icon {
            width: 60px; height: 60px;
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
            color: #fff;
            margin: 0 auto 12px;
        }
        .brand h4 { color: #fff; font-weight: 700; font-size: 1.5rem; margin: 0; }
        .brand p  { color: #8888aa; font-size: 0.88rem; margin: 0; }

        .form-floating label { color: #8888aa; font-size: 0.9rem; }
        .form-floating .form-control,
        .form-floating textarea.form-control {
            background: #0f0c29;
            border: 1.5px solid #2e2e4d;
            border-radius: 10px;
            color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-floating .form-control:focus,
        .form-floating textarea.form-control:focus {
            background: #0f0c29;
            border-color: #6c63ff;
            box-shadow: 0 0 0 3px rgba(108,99,255,0.25);
            color: #fff;
        }

        .btn-register {
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
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(108,99,255,0.45);
            color: #fff;
        }

        .auth-link { color: #8888aa; font-size: 0.88rem; text-align: center; margin-top: 14px; }
        .auth-link a { color: #6c63ff; text-decoration: none; font-weight: 600; }
        .auth-link a:hover { text-decoration: underline; }

        small.form-text { color: #555577; }
        .error-msg { color: #ff6b7a; font-size: 0.9rem; text-align: center; margin-top: 8px; }
    </style>
</head>
<body>
<div class="register-card">
    <div class="brand">
        <div class="icon"><i class="fas fa-shopping-bag"></i></div>
        <h4>Create Account</h4>
        <p>Join ShopEase and start shopping fresh products</p>
    </div>

    <form action="newuserregister" method="post">
        <div class="form-floating mb-3">
            <input type="text" name="username" id="username"
                   class="form-control" placeholder="Username" required>
            <label for="username"><i class="fas fa-user me-2"></i>Username</label>
        </div>

        <div class="form-floating mb-3">
            <input type="email" name="email" id="email"
                   class="form-control" placeholder="Email" required minlength="6">
            <label for="email"><i class="fas fa-envelope me-2"></i>Email address</label>
            <small class="form-text">We'll never share your email with anyone else.</small>
        </div>

        <div class="form-floating mb-3">
            <input type="password" name="password" id="password"
                   class="form-control" placeholder="Password" required>
            <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
        </div>

        <div class="form-floating mb-4">
            <textarea name="address" id="address" class="form-control"
                      placeholder="Address" style="height:90px"></textarea>
            <label for="address"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
        </div>

        <button type="submit" class="btn-register">
            <i class="fas fa-user-plus me-2"></i>Create Account
        </button>

        <p class="error-msg">${msg}</p>
        <p class="auth-link">Already have an account? <a href="/userlogin">Login here</a></p>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>