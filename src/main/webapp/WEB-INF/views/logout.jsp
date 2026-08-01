<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout - Secure File Sharing</title>
    <meta http-equiv="refresh" content="3;url=login">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/external.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
  <header>
    <div class="nav">
      <div class="logo"><i class="fa-solid fa-shield-halved"></i> SecureShare</div>
    </div>
  </header>
  <section style="display: flex; align-items: center; justify-content: center; min-height: 60vh;">
    <div class="card text-center" style="max-width: 500px; width: 100%;">
        <h2 style="color: var(--success); margin-bottom: 1rem;">✅ Logged Out Successfully</h2>
        <p style="margin-bottom: 2rem;">Redirecting to Login Page in 3 seconds...</p>
        <a href="login1" class="btn">Click here if not redirected</a>
    </div>
  </section>
</body>
</html>