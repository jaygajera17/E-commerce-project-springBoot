<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile – ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f0c29, #1a1060, #24243e);
            display: flex; align-items: center; justify-content: center;
            padding: 40px 16px;
        }
        .profile-card {
            background: rgba(26,26,46,0.95);
            border: 1px solid rgba(108,99,255,0.2);
            border-radius: 24px; padding: 48px 44px;
            width: 100%; max-width: 520px;
            box-shadow: 0 30px 80px rgba(0,0,0,0.5);
        }
        .avatar-ring {
            width: 80px; height: 80px;
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem; color: #fff;
            margin: 0 auto 20px;
            box-shadow: 0 8px 24px rgba(108,99,255,0.4);
        }
        .card-title { color: #fff; font-weight: 700; font-size: 1.5rem; text-align: center; margin-bottom: 4px; }
        .card-sub { color: #8888aa; text-align: center; font-size: 0.88rem; margin-bottom: 30px; }

        .form-floating label { color: #8888aa; font-size: 0.9rem; }
        .form-floating .form-control, .form-floating textarea.form-control {
            background: #0f0c29; border: 1.5px solid #2e2e4d;
            border-radius: 10px; color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-floating .form-control:focus, .form-floating textarea.form-control:focus {
            background: #0f0c29; border-color: #6c63ff;
            box-shadow: 0 0 0 3px rgba(108,99,255,0.25); color: #fff;
        }

        .btn-update {
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            border: none; border-radius: 10px; color: #fff;
            font-weight: 600; font-size: 1rem; padding: 12px;
            width: 100%; transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(108,99,255,0.45); color: #fff;
        }
        .divider { border-color: rgba(108,99,255,0.15); margin: 20px 0; }
    </style>
</head>
<body>
<div class="profile-card">
    <div class="avatar-ring"><i class="fas fa-user"></i></div>
    <div class="card-title">User Profile</div>
    <div class="card-sub">Update your personal information below</div>
    <hr class="divider">

    <form action="updateuser" method="post">
        <input type="hidden" name="userid" value="${userid}">

        <div class="form-floating mb-3">
            <input type="text" name="username" id="username"
                   class="form-control" placeholder="Username"
                   value="${username}" required>
            <label for="username"><i class="fas fa-user me-2"></i>Username</label>
        </div>

        <div class="form-floating mb-3">
            <input type="email" name="email" id="email"
                   class="form-control" placeholder="Email"
                   value="${email}" required minlength="6">
            <label for="email"><i class="fas fa-envelope me-2"></i>Email address</label>
        </div>

        <div class="form-floating mb-3">
            <input type="password" name="password" id="password"
                   class="form-control" placeholder="Password"
                   value="${password}" required>
            <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
        </div>

        <div class="form-floating mb-4">
            <textarea name="address" id="address" class="form-control"
                      placeholder="Address" style="height:90px">${address}</textarea>
            <label for="address"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
        </div>

        <button type="submit" class="btn-update">
            <i class="fas fa-save me-2"></i>Update Profile
        </button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>