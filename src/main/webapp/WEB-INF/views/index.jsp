<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.io.File" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure File Sharing System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/external.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
  <header>
    <div class="nav">
      <div class="logo"><i class="fa-solid fa-shield-halved"></i> SecureShare</div>
      <nav>
        <a href="#intro">Home</a>
        <a href="#features">Features</a>
        <a href="#tech">Technologies</a>
        <a href="#login">Access</a>
        <a href="${pageContext.request.contextPath}/admin/extensions">Admin</a>
      </nav>
    </div>
  </header>

  <div class="hero" id="intro">
    <h1>Next-Generation File Sharing</h1>
    <p>Experience seamless, encrypted, and lightning-fast file sharing. Secure your digital assets with state-of-the-art encryption and manage access effortlessly.</p>
    <div style="display: flex; gap: 1rem; justify-content: center; margin-top: 2rem;">
        <a href="#login" class="btn"><i class="fa-solid fa-right-to-bracket" style="margin-right: 8px;"></i> Get Started</a>
        <a href="#features" class="btn" style="background: transparent; border: 1px solid var(--text-muted); color: var(--text) !important;"><i class="fa-solid fa-compass" style="margin-right: 8px;"></i> Explore Features</a>
    </div>
  </div>

  <section id="features">
    <h2>Why Choose SecureShare?</h2>
    <div class="grid">
      <div class="card text-center">
        <div style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"><i class="fa-solid fa-lock"></i></div>
        <h3>AES Encryption</h3>
        <p>All files are encrypted before saving to ensure maximum security against unauthorized access.</p>
      </div>
      <div class="card text-center">
        <div style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"><i class="fa-solid fa-user-shield"></i></div>
        <h3>Safe Authorization</h3>
        <p>Robust role-based access control guarantees that only authenticated users interact with their data.</p>
      </div>
      <div class="card text-center">
        <div style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"><i class="fa-solid fa-bolt"></i></div>
        <h3>High Performance</h3>
        <p>Built on Spring MVC to deliver minimal overhead and blazing fast file uploads and downloads.</p>
      </div>
    </div>
  </section>

  <section id="tech">
    <h2>Powered by Modern Tech</h2>
    <div class="grid">
      <div class="card">
        <h3><i class="fa-brands fa-java" style="margin-right: 10px; color: #f89820;"></i>Core Technologies</h3>
        <ul>
          <li>Java Web Technologies</li>
          <li>JSP & Servlets</li>
          <li>JDBC</li>
        </ul>
      </div>
      <div class="card">
        <h3><i class="fa-solid fa-leaf" style="margin-right: 10px; color: #6db33f;"></i>Spring Framework</h3>
        <ul>
          <li>Spring Core (IOC)</li>
          <li>Spring MVC</li>
        </ul>
      </div>
      <div class="card">
        <h3><i class="fa-solid fa-database" style="margin-right: 10px; color: #f29111;"></i>Database & Tools</h3>
        <ul>
          <li>Oracle SQL</li>
          <li>Apache Tomcat Server</li>
          <li>Eclipse IDE</li>
        </ul>
      </div>
    </div>
  </section>

  <section id="login">
    <h2>Access Your Account</h2>
    <div class="grid">
      <div class="card text-center">
        <div style="font-size: 2.5rem; color: var(--text-muted); margin-bottom: 1rem;"><i class="fa-solid fa-user-check"></i></div>
        <h3>Existing User</h3>
        <p>Welcome back! Access your securely stored files.</p>
        <a href="login1" class="btn" style="margin-top: auto; display: inline-flex;"><i class="fa-solid fa-sign-in-alt" style="margin-right: 8px;"></i> Login to Account</a> 
      </div>
      <div class="card text-center">
        <div style="font-size: 2.5rem; color: var(--text-muted); margin-bottom: 1rem;"><i class="fa-solid fa-user-plus"></i></div>
        <h3>New User</h3>
        <p>Join us today to start securing and sharing your files.</p>
        <a href="registration" class="btn" style="margin-top: auto; display: inline-flex;"><i class="fa-solid fa-user-plus" style="margin-right: 8px;"></i> Create Account</a> 
      </div>
    </div>
  </section>

  <section id="contact">
    <h2>Information & Contact</h2>
    <div class="grid">
      <details>
        <summary><i class="fa-solid fa-code" style="margin-right: 10px; font-size: 1.2rem;"></i> About The Project</summary>
        <p>SecureShare is a robust Java-based web application demonstrating secure file handling, MVC architecture, and modern UI design.</p>
      </details>
      <details>
        <summary><i class="fa-solid fa-laptop-code" style="margin-right: 10px; font-size: 1.2rem;"></i> Developer</summary>
        <p>Developed with passion by:</p>
        <p><strong style="color: var(--accent); font-size: 1.1rem;">Prathamesh Kumawat</strong></p>
      </details>
      <details>
        <summary><i class="fa-solid fa-hashtag" style="margin-right: 10px; font-size: 1.2rem;"></i> Let's Connect</summary>
        <p>Find me on social media:</p>
        <a href="https://www.instagram.com/pratham_17498/" class="fa-brands fa-instagram" target="_blank" style="font-size: 2rem; margin-top: 10px; display: inline-block;"></a>
      </details>
    </div>
  </section>

  <footer>
    <h5 style="margin-bottom: 1rem; color: var(--text-muted); font-weight: 500;">This is a personal project showcasing Java web development skills.</h5>
    <p>&copy; 2026 SecureShare. Connect: <a href="https://www.instagram.com/pratham_17498/" class="fa-brands fa-instagram" target="_blank"></a></p>
  </footer>
</body>
</html>