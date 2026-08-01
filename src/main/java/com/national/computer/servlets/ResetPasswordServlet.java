package com.national.computer.servlets;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ResetPasswordServlet extends HttpServlet {
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
			String uname = req.getParameter("uname");
			String email = req.getParameter("email");
			String newPword = req.getParameter("new_pword");
			
			PreparedStatement pstmt = con.prepareStatement("update info2 set pword=? where uname=? and email=?");
			pstmt.setString(1, newPword);
			pstmt.setString(2, uname);
			pstmt.setString(3, email);
			
			int rowsUpdated = pstmt.executeUpdate();
			
			PrintWriter pw = res.getWriter();
			String contextPath = req.getContextPath();

			pw.println("<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n"
					+ "    <meta charset=\"UTF-8\">\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
					+ "    <title>Password Reset Status</title>\n"
					+ "    <link rel=\"stylesheet\" href=\"" + contextPath + "/resources/css/external.css\">\n"
					+ "    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n"
					+ "</head>\n<body>\n");

			pw.println("  <header>\n"
					+ "    <div class=\"nav\">\n"
					+ "      <div class=\"logo\"><i class=\"fa-solid fa-shield-halved\"></i> SecureShare</div>\n"
					+ "      <nav>\n"
					+ "        <a href=\"index.jsp#intro\">Intro</a>\n"
					+ "        <a href=\"login1\">Login</a>\n"
					+ "      </nav>\n"
					+ "    </div>\n"
					+ "  </header>\n");

			if (rowsUpdated > 0) {
				pw.println("  <div class=\"hero\">\n"
						+ "    <h1 style=\"color: var(--success);\">Password Reset Successful!</h1>\n"
						+ "    <p>Your password has been securely updated.</p>\n"
						+ "  </div>\n");

				pw.println("  <section>\n"
						+ "    <div class=\"grid\">\n"
						+ "      <div class=\"card text-center\" style=\"max-width: 500px; margin: 0 auto;\">\n"
						+ "        <i class=\"fa fa-check-circle\" style=\"font-size: 4rem; color: var(--success); margin-bottom: 1.5rem; text-shadow: 0 0 20px rgba(16, 185, 129, 0.4);\"></i>\n"
						+ "        <h2>Ready to Login</h2>\n"
						+ "        <p>You can now access your encrypted vault using your new password.</p>\n"
						+ "        <a href=\"login1\" class=\"btn\" style=\"margin-top: 1rem;\">Sign In Now</a>\n"
						+ "      </div>\n"
						+ "    </div>\n"
						+ "  </section>\n");
			} else {
				pw.println("  <div class=\"hero\">\n"
						+ "    <h1 style=\"color: var(--danger);\">Reset Failed</h1>\n"
						+ "    <p>We could not find an account matching that username and email address.</p>\n"
						+ "  </div>\n");

				pw.println("  <section>\n"
						+ "    <div class=\"grid\">\n"
						+ "      <div class=\"card text-center\" style=\"max-width: 500px; margin: 0 auto;\">\n"
						+ "        <i class=\"fa fa-times-circle\" style=\"font-size: 4rem; color: var(--danger); margin-bottom: 1.5rem;\"></i>\n"
						+ "        <h2>Try Again</h2>\n"
						+ "        <p>Please double-check your credentials and try again.</p>\n"
						+ "        <a href=\"forgot\" class=\"btn\" style=\"margin-top: 1rem;\">Back to Reset</a>\n"
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