package com.national.computer.servlets;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 6608138740458922575L;
	Connection con;

	public void init() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public void service(HttpServletRequest req, HttpServletResponse res) {
		try {
			String s1 = req.getParameter("uname");
			String s2 = req.getParameter("pword");
			PreparedStatement pstmt = con.prepareStatement("select * from info2 where uname=? and pword=?");
			pstmt.setString(1, s1);
			pstmt.setString(2, s2);
			ResultSet rs = pstmt.executeQuery();
			PrintWriter pw = res.getWriter();
			String contextPath = req.getContextPath();

			pw.println("<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n"
					+ "    <meta charset=\"UTF-8\">\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
					+ "    <title>Login Status - Secure File Sharing</title>\n"
					+ "    <link rel=\"stylesheet\" href=\"" + contextPath + "/resources/css/external.css\">\n"
					+ "    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n"
					+ "</head>\n<body>\n");

			if (rs.next()) {
				String s = req.getParameter("uname");
				pw.println("  <header>\n"
						+ "    <div class=\"nav\">\n"
						+ "      <div class=\"logo\"><i class=\"fa-solid fa-shield-halved\"></i> SecureShare</div>\n"
						+ "      <nav>\n"
						+ "        <a href=\"#intro\">Intro</a>\n"
						+ "        <a href=\"upload\">Upload/Download</a>\n"
						+ "        <a href=\"logout1\">Logout</a>\n"
						+ "      </nav>\n"
						+ "    </div>\n"
						+ "  </header>\n");

				pw.println("  <div class=\"hero\">\n"
						+ "    <h1>Welcome Back, " + s + "!</h1>\n"
						+ "    <p>You have successfully logged in to the Secure File Sharing System.</p>\n"
						+ "  </div>\n");

				pw.println("  <section>\n"
						+ "    <div class=\"grid\">\n"
						+ "      <div class=\"card text-center\">\n"
						+ "        <i class=\"fa fa-cloud-upload\" style=\"font-size: 3rem; color: var(--accent); margin-bottom: 1rem;\"></i>\n"
						+ "        <h2>File Uploading</h2>\n"
						+ "        <p>Transfer new documents to the secure vault.</p>\n"
						+ "        <a href=\"upload\" class=\"btn\">Upload File</a>\n"
						+ "      </div>\n"
						+ "      <div class=\"card text-center\">\n"
						+ "        <i class=\"fa fa-server\" style=\"font-size: 3rem; color: var(--accent); margin-bottom: 1rem;\"></i>\n"
						+ "        <h2>Vault Repository</h2>\n"
						+ "        <p>View, manage, or retrieve your stored digital media.</p>\n"
						+ "        <a href=\"files\" class=\"btn\">View Uploaded Files</a>\n"
						+ "      </div>\n"
						+ "    </div>\n"
						+ "  </section>\n");

			} else {
				pw.println("  <header>\n"
						+ "    <div class=\"nav\">\n"
						+ "      <div class=\"logo\"><i class=\"fa-solid fa-shield-halved\"></i> SecureShare</div>\n"
						+ "      <nav>\n"
						+ "        <a href=\"login1\">Login</a>\n"
						+ "        <a href=\"registration\">Registration</a>\n"
						+ "      </nav>\n"
						+ "    </div>\n"
						+ "  </header>\n");

				pw.println("  <div class=\"hero\">\n"
						+ "    <h1 style=\"color: var(--danger);\">Login Failed</h1>\n"
						+ "    <p>Incorrect username or password. Please try again.</p>\n"
						+ "  </div>\n");

				pw.println("  <section>\n"
						+ "    <div class=\"grid\">\n"
						+ "      <div class=\"card text-center\">\n"
						+ "        <i class=\"fa fa-sign-in\" style=\"font-size: 3rem; color: var(--accent); margin-bottom: 1rem;\"></i>\n"
						+ "        <h2>Try Again</h2>\n"
						+ "        <p>Return to the login page to enter your credentials.</p>\n"
						+ "        <a href=\"login1\" class=\"btn\">Go to Login</a>\n"
						+ "      </div>\n"
						+ "      <div class=\"card text-center\">\n"
						+ "        <i class=\"fa fa-user-plus\" style=\"font-size: 3rem; color: var(--accent); margin-bottom: 1rem;\"></i>\n"
						+ "        <h2>Need an Account?</h2>\n"
						+ "        <p>If you don't have an account, register here.</p>\n"
						+ "        <a href=\"registration\" class=\"btn\">Register</a>\n"
						+ "      </div>\n"
						+ "    </div>\n"
						+ "  </section>\n");
			}

			pw.println("  <footer>\n"
					+ "    <h5><u><b>(Note:- This Project Is A Personal Project and All Work Done Is My Original Work.)</b></u></h5>\n"
					+ "    <p>&copy; Follow Me: <a href=\"https://www.instagram.com/pratham_17498/\" class=\"fa fa-instagram\" target=\"_blank\"></a></p>\n"
					+ "  </footer>\n"
					+ "</body>\n</html>");
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}