<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Result - Secure File Sharing System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/external.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
      .result-container {
        display: flex;
        flex-direction: column;
        gap: 2rem;
        max-width: 800px;
        margin: 0 auto;
        padding-bottom: 2rem;
      }
      .result-card {
        background: var(--card);
        border: 1px solid var(--card-border);
        border-radius: 1.5rem;
        padding: 3rem 2rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        text-align: center;
        position: relative;
        overflow: hidden;
      }
      .result-card::before {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0; height: 5px;
        background: linear-gradient(90deg, var(--success), #34d399);
      }
      .success-icon {
        font-size: 4.5rem;
        color: var(--success);
        margin-bottom: 1.5rem;
        text-shadow: 0 0 20px rgba(16, 185, 129, 0.4);
      }
      .result-card h2 {
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 1rem;
        background: linear-gradient(135deg, #fff, #a5b4fc);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .file-details-box {
        background: rgba(0, 0, 0, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 1rem;
        padding: 1.5rem;
        margin: 2rem auto;
        max-width: 400px;
      }
      .file-details-box p {
        margin: 0;
        color: var(--text);
        font-size: 1.1rem;
        word-break: break-all;
      }
      .file-details-box i {
        color: var(--accent);
        margin-right: 0.5rem;
      }
      .btn-primary {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        padding: 1rem 2rem;
        font-size: 1.1rem;
        font-weight: 600;
        background: linear-gradient(135deg, var(--accent), var(--accent-hover));
        border-radius: 0.8rem;
        border: none;
        color: #fff;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        text-decoration: none;
      }
      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(99, 102, 241, 0.6);
        color: #fff;
      }
      .action-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
      }
      .action-card {
        background: rgba(21, 26, 42, 0.4);
        border: 1px solid var(--card-border);
        border-radius: 1rem;
        padding: 2rem;
        text-align: center;
        transition: all 0.3s ease;
      }
      .action-card:hover {
        background: rgba(21, 26, 42, 0.8);
        border-color: rgba(255, 255, 255, 0.15);
        transform: translateY(-3px);
      }
      .action-card i {
        font-size: 2.5rem;
        color: var(--accent);
        margin-bottom: 1rem;
      }
      .action-card h3 {
        margin-bottom: 0.5rem;
        font-size: 1.2rem;
        color: #fff;
      }
      .action-card p {
        color: var(--text-muted);
        font-size: 0.9rem;
        margin-bottom: 1.5rem;
      }
    </style>
</head>
<body>
  <header>
    <div class="nav">
      <div class="logo"><i class="fa-solid fa-shield-halved"></i> SecureShare</div>
      <nav>
        <a href="#result">Result</a>
        <a href="#ext">Extensions</a>
        <a href="#out">Logout</a>
      </nav>
    </div>
  </header>

  <div class="hero" style="padding-bottom: 2rem;">
    <h1>Transaction Complete</h1>
    <p>Your action was securely processed by the server vault.</p>
  </div>

  <section id="result" style="padding-top: 0;">
    <div class="result-container">
      
      <div class="result-card">
        <i class="fa fa-check-circle success-icon"></i>
        <h2>Action Successful</h2>
        
        <% if (request.getAttribute("msg") != null) { %>
            <p style="color: var(--text-muted); font-size: 1.1rem;">${msg}</p>
        <% } %>

        <%
            String fileName = (String) request.getAttribute("fileName");
            if (fileName == null) {
                Object fm = request.getAttribute("org.springframework.web.servlet.FlashMap");
                if (fm != null) {
                    try {
                        java.util.Map map = (java.util.Map) fm;
                        if (map.containsKey("fileName")) fileName = (String) map.get("fileName");
                    } catch (Exception ignore) {}
                }
            }
            if (fileName != null && !fileName.trim().isEmpty()) {
        %>
            <div class="file-details-box">
                <p><i class="fa fa-file-text-o"></i> <strong>File Name:</strong> <%= fileName %></p>
            </div>
            
            <a href="download?name=<%= fileName %>" class="btn-primary">
               Download File <i class="fa fa-download"></i>
            </a>
        <%
            } else {
        %>
            <p style="color: var(--text-muted); margin-top: 1rem;">No file attached to this transaction.</p>
        <%
            }
        %>
      </div>

      <div class="action-cards">
        <div class="action-card">
          <i class="fa fa-cloud-upload"></i>
          <h3>Upload More</h3>
          <p>Need to securely store additional documents?</p>
          <a href="upload" class="btn" style="width: 100%;">Go to Upload</a>
        </div>
        
        <div class="action-card">
          <i class="fa fa-server"></i>
          <h3>Vault Repository</h3>
          <p>View, manage, or retrieve your stored digital media.</p>
          <a href="files" class="btn" style="width: 100%;">View All Files</a>
        </div>
      </div>

    </div>
  </section>

  <section id="out" style="padding-top: 0;">
    <div class="card text-center" style="max-width: 800px; margin: 0 auto; background: rgba(239, 68, 68, 0.05); border-color: rgba(239, 68, 68, 0.2);">
      <h2 style="color: var(--danger);">End Session</h2>
      <p style="margin-bottom: 1.5rem;">Securely close your connection and clear session data.</p>
      <a href="logout1" class="btn" style="background: transparent; border: 1px solid var(--danger); color: var(--danger) !important; box-shadow: none;">Secure Logout</a>
    </div>
  </section>

  <footer>
    <h5><u><b>(Note:- This Project Is A Personal Project and All Work Done Is My Original Work.)</b></u></h5>
    <p>&copy; Follow Me: <a href="https://www.instagram.com/pratham_17498/" class="fa fa-instagram" target="_blank"></a></p>
  </footer>
</body>
</html>