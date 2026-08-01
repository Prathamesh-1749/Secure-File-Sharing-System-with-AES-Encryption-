<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Secure File Sharing System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/external.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
      .login-container {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 75vh;
        padding: 2rem;
      }
      .login-card {
        max-width: 420px;
        width: 100%;
        padding: 3rem 2.5rem;
        background: var(--card);
        border: 1px solid var(--card-border);
        border-radius: 1.5rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        text-align: center;
        transition: transform 0.3s ease;
      }
      .login-card:hover {
        transform: translateY(-5px);
        border-color: rgba(255, 255, 255, 0.15);
      }
      .login-card h2 {
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
        background: linear-gradient(135deg, #fff, #a5b4fc);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .login-card p.subtitle {
        color: var(--text-muted);
        margin-bottom: 2.5rem;
        font-size: 0.95rem;
      }
      .input-wrapper {
        position: relative;
        margin-bottom: 1.5rem;
        text-align: left;
      }
      .input-wrapper i {
        position: absolute;
        top: 50%;
        left: 1.2rem;
        transform: translateY(-50%);
        color: var(--text-muted);
        font-size: 1.2rem;
        transition: color 0.3s ease;
        pointer-events: none;
      }
      .input-wrapper input {
        width: 100%;
        padding: 1rem 1rem 1rem 3.2rem;
        background: rgba(0, 0, 0, 0.25);
        border: 1px solid var(--card-border);
        border-radius: 0.8rem;
        color: var(--text);
        font-size: 1rem;
        transition: all 0.3s ease;
      }
      .input-wrapper input:focus {
        border-color: var(--accent);
        background: rgba(0, 0, 0, 0.4);
        outline: none;
        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
      }
      .input-wrapper input:focus ~ i {
        color: var(--accent);
      }
      .login-options {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
        font-size: 0.9rem;
      }
      .login-options label {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: var(--text-muted);
        cursor: pointer;
        margin: 0;
        font-weight: 400;
      }
      .login-options input[type="checkbox"] {
        width: 1rem;
        height: 1rem;
        accent-color: var(--accent);
      }
      .login-options a {
        color: var(--accent);
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
      }
      .login-options a:hover {
        color: var(--accent-hover);
        text-decoration: underline;
      }
      .btn-primary {
        width: 100%;
        padding: 1rem;
        font-size: 1.1rem;
        font-weight: 600;
        background: linear-gradient(135deg, var(--accent), var(--accent-hover));
        border-radius: 0.8rem;
        border: none;
        color: #fff;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 0.5rem;
      }
      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(99, 102, 241, 0.6);
      }
      .register-link {
        margin-top: 2rem;
        color: var(--text-muted);
        font-size: 0.95rem;
        padding-top: 1.5rem;
        border-top: 1px solid rgba(255, 255, 255, 0.05);
      }
      .register-link a {
        color: #fff;
        font-weight: 600;
        text-decoration: none;
        margin-left: 0.3rem;
        transition: color 0.3s ease;
      }
      .register-link a:hover {
        color: var(--accent);
      }
    </style>
</head>
<body>
  <header>
    <div class="nav">
      <div class="logo"><i class="fa-solid fa-shield-halved"></i> SecureShare</div>
      <nav>
        <a href="${pageContext.request.contextPath}/">Intro</a>
        <a href="login1">Login</a>
        <a href="registration">Registration</a>
      </nav>
    </div>
  </header>

  <div class="login-container">
    <div class="login-card">
      <h2>Welcome Back</h2>
      <p class="subtitle">Securely access your digital workspace</p>
      
      <form action="login" method="get">
        <div class="input-wrapper">
          <input type="text" placeholder="Username" name="uname" required autocomplete="off">
          <i class="fa fa-user-o"></i>
        </div>

        <div class="input-wrapper">
          <input type="password" placeholder="Password" name="pword" required>
          <i class="fa fa-lock"></i>
        </div>
        
        <div class="login-options">
          <label>
            <input type="checkbox" name="remember" checked="checked">
            Remember me
          </label>
          <a href="forgot">Forgot Password?</a>
        </div>

        <button type="submit" class="btn-primary">
          Sign In <i class="fa fa-arrow-right"></i>
        </button>
      </form>

      <div class="register-link">
        New to the system? <a href="registration">Create an account</a>
      </div>
    </div>
  </div>

  <footer>
    <h5><u><b>(Note:- This Project Is A Personal Project and All Work Done Is My Original Work.)</b></u></h5>
    <p>&copy; Follow Me: <a href="https://www.instagram.com/pratham_17498/" class="fa fa-instagram" target="_blank"></a></p>
  </footer>
</body>
</html>