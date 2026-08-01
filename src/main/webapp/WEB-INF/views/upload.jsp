<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload File - Secure File Sharing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/external.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
      .upload-container {
        display: flex;
        flex-direction: column;
        gap: 2rem;
        max-width: 900px;
        margin: 0 auto;
      }
      .dropzone-card {
        background: var(--card);
        border: 1px solid var(--card-border);
        border-radius: 1.5rem;
        padding: 3rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        text-align: center;
        transition: transform 0.3s ease;
      }
      .dropzone-card:hover {
        transform: translateY(-5px);
        border-color: rgba(255, 255, 255, 0.15);
      }
      .dropzone-card h2 {
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
        background: linear-gradient(135deg, #fff, #a5b4fc);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .dropzone-card p.subtitle {
        color: var(--text-muted);
        margin-bottom: 2rem;
        font-size: 0.95rem;
      }
      
      .file-upload-wrapper {
        position: relative;
        width: 100%;
        height: 200px;
        border: 2px dashed var(--accent);
        border-radius: 1rem;
        background: rgba(99, 102, 241, 0.05);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-bottom: 1.5rem;
      }
      .file-upload-wrapper:hover {
        background: rgba(99, 102, 241, 0.15);
        border-color: var(--accent-hover);
      }
      .file-upload-wrapper input[type="file"] {
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        opacity: 0;
        cursor: pointer;
      }
      .file-upload-icon {
        font-size: 3.5rem;
        color: var(--accent);
        margin-bottom: 1rem;
        transition: transform 0.3s ease;
      }
      .file-upload-wrapper:hover .file-upload-icon {
        transform: scale(1.1);
      }
      .file-upload-text {
        color: var(--text);
        font-weight: 500;
        font-size: 1.1rem;
      }
      .file-upload-subtext {
        color: var(--text-muted);
        font-size: 0.85rem;
        margin-top: 0.5rem;
      }
      .btn-primary {
        width: 100%;
        max-width: 300px;
        margin: 0 auto;
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
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
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
      
      /* Optional: JS visual feedback for file selection */
      .file-selected {
        border-style: solid;
        border-color: var(--success);
        background: rgba(16, 185, 129, 0.05);
      }
      .file-selected .file-upload-icon {
        color: var(--success);
      }
    </style>
</head>
<body>
  <header>
    <div class="nav">
      <div class="logo"><i class="fa-solid fa-shield-halved"></i> SecureShare</div>
      <nav>
        <a href="#upload">Upload Files</a>
        <a href="#ext">Extensions</a>
        <a href="#out">Logout</a>
      </nav>
    </div>
  </header>

  <div class="hero" style="padding-bottom: 2rem;">
    <h1>Secure Document Storage</h1>
    <p>Upload your files to the encrypted vault. Your data is protected using AES encryption.</p>
  </div>

  <section id="upload" style="padding-top: 0;">
    <div class="upload-container">
      
      <div class="dropzone-card">
        <h2>Upload a New File</h2>
        <p class="subtitle">Securely transfer documents from your device to the server vault.</p>
        
        <form action="uploadFile" method="post" enctype="multipart/form-data">
          
          <div class="file-upload-wrapper" id="fileWrapper">
            <i class="fa fa-cloud-upload file-upload-icon" id="fileIcon"></i>
            <span class="file-upload-text" id="fileText">Click to browse or drag file here</span>
            <span class="file-upload-subtext">Maximum upload size: 5MB</span>
            <input type="file" name="file" id="fileInput" required/>
          </div>
          
          <button type="submit" class="btn-primary">
            Upload to Vault <i class="fa fa-upload"></i>
          </button>
        </form>
      </div>

      <div class="action-cards">
        <div class="action-card">
          <i class="fa fa-folder-open-o"></i>
          <h3>View Repository</h3>
          <p>Access, download, or delete your previously uploaded files securely.</p>
          <a href="files" class="btn" style="width: 100%;">View Uploaded Files</a>
        </div>
        
        <div class="action-card" id="ext">
          <i class="fa fa-file-text-o"></i>
          <h3>Allowed Formats</h3>
          <p>We support standard document and image formats for upload.</p>
          <div style="display: flex; flex-wrap: wrap; gap: 0.5rem; justify-content: center;">
            <span style="background: rgba(255,255,255,0.1); padding: 0.2rem 0.6rem; border-radius: 1rem; font-size: 0.8rem; color: #fff;">.pdf</span>
            <span style="background: rgba(255,255,255,0.1); padding: 0.2rem 0.6rem; border-radius: 1rem; font-size: 0.8rem; color: #fff;">.jpg</span>
            <span style="background: rgba(255,255,255,0.1); padding: 0.2rem 0.6rem; border-radius: 1rem; font-size: 0.8rem; color: #fff;">.png</span>
            <span style="background: rgba(255,255,255,0.1); padding: 0.2rem 0.6rem; border-radius: 1rem; font-size: 0.8rem; color: #fff;">.jpeg</span>
            <span style="background: rgba(255,255,255,0.1); padding: 0.2rem 0.6rem; border-radius: 1rem; font-size: 0.8rem; color: #fff;">.txt</span>
            <span style="background: rgba(255,255,255,0.1); padding: 0.2rem 0.6rem; border-radius: 1rem; font-size: 0.8rem; color: #fff;">.docx</span>
          </div>
        </div>
      </div>

    </div>
  </section>

  <section id="out" style="padding-top: 0;">
    <div class="card text-center" style="max-width: 900px; margin: 0 auto; background: rgba(239, 68, 68, 0.05); border-color: rgba(239, 68, 68, 0.2);">
      <h2 style="color: var(--danger);">End Session</h2>
      <p style="margin-bottom: 1.5rem;">Securely close your connection and clear session data.</p>
      <a href="logout1" class="btn" style="background: transparent; border: 1px solid var(--danger); color: var(--danger) !important; box-shadow: none;">Secure Logout</a>
    </div>
  </section>

  <footer>
    <h5><u><b>(Note:- This Project Is A Personal Project and All Work Done Is My Original Work.)</b></u></h5>
    <p>&copy; Follow Me: <a href="https://www.instagram.com/pratham_17498/" class="fa fa-instagram" target="_blank"></a></p>
  </footer>

  <script>
    // Simple script to update UI when a file is selected
    const fileInput = document.getElementById('fileInput');
    const fileWrapper = document.getElementById('fileWrapper');
    const fileText = document.getElementById('fileText');
    const fileIcon = document.getElementById('fileIcon');

    fileInput.addEventListener('change', function() {
      if (this.files && this.files.length > 0) {
        const fileName = this.files[0].name;
        fileText.textContent = "Selected: " + fileName;
        fileWrapper.classList.add('file-selected');
        fileIcon.className = "fa fa-check-circle file-upload-icon";
      } else {
        fileText.textContent = "Click to browse or drag file here";
        fileWrapper.classList.remove('file-selected');
        fileIcon.className = "fa fa-cloud-upload file-upload-icon";
      }
    });
  </script>
</body>
</html>