<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 – Access Forbidden | ShopEase</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Inter', sans-serif; margin: 0; padding: 0; box-sizing: border-box; }

        body {
            min-height: 100vh;
            background: #0d0d1a;
            display: flex; align-items: center; justify-content: center;
            overflow: hidden;
        }

        /* Animated blobs */
        .blob {
            position: fixed; border-radius: 50%; filter: blur(80px); opacity: 0.15;
            animation: floatBlob 8s ease-in-out infinite;
        }
        .blob-1 { width: 500px; height: 500px; background: #ef4444; top: -150px; left: -100px; }
        .blob-2 { width: 400px; height: 400px; background: #7c3aed; bottom: -100px; right: -100px; animation-delay: -4s; }
        @keyframes floatBlob {
            0%, 100% { transform: translate(0,0) scale(1); }
            50%       { transform: translate(30px, 20px) scale(1.05); }
        }

        .card {
            background: rgba(22,22,40,0.9);
            border: 1px solid rgba(239,68,68,0.2);
            border-radius: 24px;
            padding: 60px 50px;
            text-align: center;
            max-width: 480px;
            width: 90%;
            backdrop-filter: blur(20px);
            box-shadow: 0 40px 100px rgba(0,0,0,0.5);
            position: relative;
            z-index: 1;
            animation: cardIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
        }
        @keyframes cardIn {
            from { opacity: 0; transform: scale(0.8); }
            to   { opacity: 1; transform: scale(1); }
        }

        .error-code {
            font-size: 7rem; font-weight: 800; line-height: 1;
            background: linear-gradient(135deg, #ef4444, #f97316);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
            animation: pulse 2s ease-in-out infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50%       { opacity: 0.75; }
        }

        .lock-icon {
            width: 80px; height: 80px;
            background: rgba(239,68,68,0.12);
            border: 1px solid rgba(239,68,68,0.3);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem; color: #f87171;
            margin: 0 auto 20px;
        }

        h2 { color: #fff; font-size: 1.5rem; font-weight: 700; margin-bottom: 10px; }
        p  { color: #777799; font-size: 0.95rem; line-height: 1.6; margin-bottom: 30px; }

        .btn-home {
            display: inline-block;
            background: linear-gradient(135deg, #6c63ff, #3b2dbf);
            color: #fff; border-radius: 12px;
            padding: 13px 30px; font-weight: 600; font-size: 0.95rem;
            text-decoration: none;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(108,99,255,0.45);
            color: #fff;
        }

        .divider {
            height: 1px; background: rgba(239,68,68,0.1); margin: 24px 0;
        }
        .hint { color: #444466; font-size: 0.82rem; }
    </style>
</head>
<body>
    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="card">
        <div class="lock-icon"><i class="fas fa-lock"></i></div>
        <div class="error-code">403</div>
        <h2>Access Forbidden</h2>
        <p>You don't have permission to view this page. Please contact your administrator if you believe this is a mistake.</p>
        <a href="/" class="btn-home">
            <i class="fas fa-house me-2"></i>Go to Homepage
        </a>
        <div class="divider"></div>
        <p class="hint">Error code: HTTP 403 Forbidden</p>
    </div>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</body>
</html>
