<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.national.computer.dto.FileInfo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Uploaded Files - Secure File Sharing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/external.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
      .repository-card {
        background: var(--card);
        border: 1px solid var(--card-border);
        border-radius: 1.5rem;
        padding: 2.5rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        grid-column: 1 / -1;
      }
      .repository-card h2 {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        font-size: 1.8rem;
        margin-bottom: 1.5rem;
      }
      .repository-card h2 i {
        color: var(--accent);
      }
      
      .alert-success {
        display: flex;
        align-items: center;
        gap: 1rem;
        background: rgba(16, 185, 129, 0.15);
        border-left: 4px solid var(--success);
        color: var(--text);
        padding: 1rem 1.5rem;
        border-radius: 0.5rem;
        margin-bottom: 2rem;
      }
      .alert-success i {
        color: var(--success);
        font-size: 1.5rem;
      }
      
      .table-wrapper {
        width: 100%;
        overflow-x: auto;
        border-radius: 1rem;
        border: 1px solid var(--card-border);
        background: rgba(0, 0, 0, 0.2);
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 0;
        border: none;
        background: transparent;
      }
      th {
        background: rgba(255, 255, 255, 0.05);
        padding: 1.2rem;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.8rem;
        letter-spacing: 0.05em;
        color: var(--text-muted);
        border-bottom: 1px solid var(--card-border);
      }
      td {
        padding: 1.2rem;
        border-bottom: 1px solid var(--card-border);
        vertical-align: middle;
      }
      tr:last-child td {
        border-bottom: none;
      }
      tr:hover td {
        background: rgba(255, 255, 255, 0.03);
      }
      
      .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: var(--text-muted);
      }
      .empty-state i {
        font-size: 4rem;
        color: rgba(255, 255, 255, 0.1);
        margin-bottom: 1rem;
      }
      
      .action-buttons {
        display: flex;
        gap: 0.5rem;
        align-items: center;
      }
      .btn-sm {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        padding: 0.5rem 0.8rem;
        font-size: 0.85rem;
        font-weight: 600;
        border-radius: 0.4rem;
        border: none;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.2s ease;
      }
      .btn-download {
        background: rgba(99, 102, 241, 0.15);
        color: var(--accent) !important;
        border: 1px solid rgba(99, 102, 241, 0.3);
      }
      .btn-download:hover {
        background: var(--accent);
        color: #fff !important;
        box-shadow: 0 4px 10px rgba(99, 102, 241, 0.3);
      }
      .btn-danger {
        background: rgba(239, 68, 68, 0.15);
        color: var(--danger) !important;
        border: 1px solid rgba(239, 68, 68, 0.3);
      }
      .btn-danger:hover {
        background: var(--danger);
        color: #fff !important;
        box-shadow: 0 4px 10px rgba(239, 68, 68, 0.3);
      }
      .btn-share {
        background: rgba(16, 185, 129, 0.15);
        color: var(--success, #10b981) !important;
        border: 1px solid rgba(16, 185, 129, 0.3);
      }
      .btn-share:hover {
        background: var(--success, #10b981);
        color: #fff !important;
        box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);
      }
    </style>
</head>
<body>
  <header>
    <div class="nav">
      <div class="logo"><i class="fa-solid fa-shield-halved"></i> SecureShare</div>
      <nav>
        <a href="#view">Repository</a>
        <a href="upload">Upload File</a>
        <a href="#out">Logout</a>      
      </nav>
    </div>
  </header>

  <div class="hero" style="padding-bottom: 2rem;">
    <h1>Encrypted Vault</h1>
    <p>Manage, download, and delete your securely stored digital media.</p>
  </div>

  <section id="view" style="padding-top: 0;">
    <div class="grid">
      <div class="repository-card">
        <h2><i class="fa fa-server"></i> Vault Repository</h2>

        <%
            String flashMsg = (String) request.getAttribute("msg");
            if (flashMsg == null) {
                Object fm = request.getAttribute("org.springframework.web.servlet.FlashMap");
                if (fm != null) {
                    try {
                        java.util.Map map = (java.util.Map) fm;
                        if (map.containsKey("msg")) flashMsg = (String) map.get("msg");
                    } catch (Exception ignore) {}
                }
            }
            if (flashMsg != null) {
        %>
            <div class="alert-success">
                <i class="fa fa-check-circle"></i>
                <div>
                  <strong>Success</strong><br>
                  <span style="font-size: 0.95rem; color: var(--text-muted);"><%= flashMsg %></span>
                </div>
            </div>
        <%
            }
        %>

        <div class="table-wrapper">
          <table>
              <tr>
                  <th><i class="fa fa-file-o"></i> Original Name</th>
                  <th><i class="fa fa-shield"></i> Stored Name</th>
                  <th><i class="fa fa-database"></i> Size (Original / Encrypted)</th>
                  <th><i class="fa fa-clock-o"></i> Upload Date</th>
                  <th>Actions</th>
              </tr>
          <%
              List<FileInfo> files = (List<FileInfo>) request.getAttribute("files");

              if (files != null && !files.isEmpty()) {
                  for (FileInfo fi : files) {
                      String original = fi.getOriginalName();
                      String stored = fi.getStoredName();
                      String uploadDate = fi.getUploadDate();
                      String encoded = stored;
                      try {
                          encoded = java.net.URLEncoder.encode(stored, "UTF-8");
                      } catch (Exception e) {}
          %>
              <tr>
                  <td style="font-weight: 500;"><%= original %></td>
                  <td style="color: var(--text-muted); font-family: monospace; font-size: 0.9rem;"><%= stored %></td>
                  <td>
                    <div style="font-size: 0.95rem; font-weight: 500;"><%= fi.getFormattedOriginalSize() %></div>
                    <% if (fi.getEncryptedSize() > 0 && fi.getEncryptedSize() < fi.getOriginalSize()) { %>
                        <div style="color: var(--success); font-size: 0.85rem;"><i class="fa fa-arrow-down"></i> Encrypted: <%= fi.getFormattedEncryptedSize() %> (<%= fi.getSizeReductionPercentage() %>% smaller)</div>
                    <% } else if (fi.getEncryptedSize() > 0) { %>
                        <div style="color: var(--text-muted); font-size: 0.85rem;"><i class="fa fa-lock"></i> Encrypted: <%= fi.getFormattedEncryptedSize() %></div>
                    <% } %>
                  </td>
                  <td style="color: var(--text-muted);"><%= uploadDate != null ? uploadDate : "N/A" %></td>
                  <td>
                      <div class="action-buttons">
                        <a href="download?name=<%= encoded %>" class="btn-sm btn-download" title="Download">
                           <i class="fa fa-download"></i> Download
                        </a>
                        <button type="button" class="btn-sm btn-share" onclick="shareFile(this, '<%= encoded %>', decodeURIComponent('<%= java.net.URLEncoder.encode(original, "UTF-8").replace("+", "%20") %>'))" title="Share">
                            <i class="fa fa-share-alt"></i> Share
                        </button>
                        <form action="delete" method="post" onsubmit="return confirm('Are you sure you want to permanently delete this file?');" style="margin:0;">
                            <input type="hidden" name="name" value="<%= stored %>" />
                            <button type="submit" class="btn-sm btn-danger" title="Delete">
                              <i class="fa fa-trash"></i> Delete
                            </button>
                        </form>
                      </div>
                  </td>
              </tr>
          <%
                  }
              } else {
          %>
              <tr>
                  <td colspan="5">
                    <div class="empty-state">
                      <i class="fa fa-folder-open-o"></i>
                      <h3>Vault is Empty</h3>
                      <p>No files have been securely uploaded yet.</p>
                      <a href="upload" class="btn" style="margin-top: 1rem;">Upload First File</a>
                    </div>
                  </td>
              </tr>
          <%
              }
          %>
          </table>
        </div>
      </div>
    </div>
  </section>

  <section id="out" style="padding-top: 0;">
    <div class="card text-center" style="max-width: 600px; margin: 0 auto; background: rgba(239, 68, 68, 0.05); border-color: rgba(239, 68, 68, 0.2);">
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
    async function shareFile(btn, fileName, originalName) {
      // 1. If the file is already prepared, trigger share immediately (synchronously)
      if (btn.fileObjToShare) {
        try {
          await navigator.share({
            title: 'Secure File Share',
            text: 'Here is the securely shared file: ' + originalName,
            files: [btn.fileObjToShare]
          });
        } catch (shareError) {
          console.error('Share API error:', shareError);
          if (shareError.name === 'NotAllowedError' || shareError.message.toLowerCase().includes('permission denied')) {
            alert('Your browser blocked sharing this specific file type (' + originalName.split('.').pop() + ') due to security restrictions. It has been downloaded to your device instead so you can attach it manually.');
            // Fallback to automatic download
            const a = document.createElement('a');
            a.href = URL.createObjectURL(btn.fileObjToShare);
            a.download = originalName;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
          } else if (shareError.name !== 'AbortError') {
            alert('Sharing failed: ' + shareError.message);
          }
        }
        return;
      }

      // 2. Otherwise, fetch and prepare the file
      const originalText = btn.innerHTML;
      btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Preparing...';
      btn.disabled = true;

      try {
        const url = 'download?name=' + fileName;
        const response = await fetch(url);
        if (!response.ok) throw new Error('Server returned ' + response.status);
        
        const blob = await response.blob();
        
        // Browsers block "application/octet-stream" from being shared. We must guess the real MIME type.
        let mimeType = blob.type;
        if (!mimeType || mimeType === 'application/octet-stream') {
            const ext = originalName.split('.').pop().toLowerCase();
            const types = {
                'pdf': 'application/pdf', 'txt': 'text/plain', 'csv': 'text/csv',
                'doc': 'application/msword', 
                'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                'xls': 'application/vnd.ms-excel',
                'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                'ppt': 'application/vnd.ms-powerpoint',
                'pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
                'png': 'image/png', 'jpg': 'image/jpeg', 'jpeg': 'image/jpeg', 'gif': 'image/gif',
                'webp': 'image/webp', 'svg': 'image/svg+xml',
                'mp3': 'audio/mpeg', 'mp4': 'video/mp4', 'wav': 'audio/wav'
            };
            mimeType = types[ext] || 'application/octet-stream';
        }

        const fileObj = new File([blob], originalName, { type: mimeType });
        
        // Check if the browser claims it can share this file
        if (navigator.canShare && navigator.canShare({ files: [fileObj] })) {
          // Store the file object on the button for the second click
          btn.fileObjToShare = fileObj;
          
          // Change the button appearance to "Share Now"
          btn.innerHTML = '<i class="fa fa-paper-plane"></i> Share Now';
          btn.style.backgroundColor = 'var(--success, #10b981)';
          btn.style.color = '#fff';
          btn.title = "Click again to open share dialog";
        } else {
          // If browser outright refuses, immediately download it as a fallback.
          alert('Your browser does not support native file sharing for this file type (' + mimeType + '). Initiating download instead.');
          const a = document.createElement('a');
          a.href = URL.createObjectURL(blob);
          a.download = originalName;
          document.body.appendChild(a);
          a.click();
          document.body.removeChild(a);
          btn.innerHTML = originalText; // Reset button
        }
      } catch (error) {
        console.error('Error preparing:', error);
        alert('Could not prepare the file: ' + error.message);
        btn.innerHTML = originalText;
      } finally {
        btn.disabled = false;
      }
    }
  </script>
</body>
</html>