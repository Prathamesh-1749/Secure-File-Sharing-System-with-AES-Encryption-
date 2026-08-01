package com.national.computer.servlets;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegistrationServlet extends HttpServlet {
	Connection con;

	public void init() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		try {
			String s = req.getParameter("id");
			String s1 = req.getParameter("fname");
			String s2 = req.getParameter("lname");
			String s3 = req.getParameter("uname");
			String s4 = req.getParameter("pword");
			String s5 = req.getParameter("email");
			PreparedStatement pstmt = con.prepareStatement("insert into info2 values(?,?,?,?,?,?)");
			pstmt.setString(1, s);
			pstmt.setString(2, s1);
			pstmt.setString(3, s2);
			pstmt.setString(4, s3);
			pstmt.setString(5, s4);
			pstmt.setString(6, s5);
			pstmt.executeUpdate();
			PrintWriter pw = res.getWriter();
			String contextPath = req.getContextPath();

			pw.println("<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n"
					+ "    <meta charset=\"UTF-8\">\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
					+ "    <title>Registration Status - Secure File Sharing System</title>\n"
					+ "    <link rel=\"stylesheet\" href=\"" + contextPath + "/resources/css/external.css\">\n"
					+ "    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n"
					+ "</head>\n<body>\n");

			pw.println("  <header>\n"
					+ "    <div class=\"nav\">\n"
					+ "      <div class=\"logo\"><i class=\"fa-solid fa-shield-halved\"></i> SecureShare</div>\n"
					+ "      <nav>\n"
					+ "        <a href=\"index.jsp#intro\">Intro</a>\n"
					+ "        <a href=\"login.jsp\">Login</a>\n"
					+ "      </nav>\n"
					+ "    </div>\n"
					+ "  </header>\n");

			pw.println("  <div class=\"hero\">\n"
					+ "    <h1 style=\"color: var(--success);\">Registration Successful!</h1>\n"
					+ "    <p>Welcome, " + s1 + "! Your account has been securely created.</p>\n"
					+ "  </div>\n");

			pw.println("  <section>\n"
					+ "    <div class=\"grid\">\n"
					+ "      <div class=\"card text-center\" style=\"max-width: 500px; margin: 0 auto;\">\n"
					+ "        <i class=\"fa fa-check-circle\" style=\"font-size: 4rem; color: var(--success); margin-bottom: 1.5rem; text-shadow: 0 0 20px rgba(16, 185, 129, 0.4);\"></i>\n"
					+ "        <h2>Ready to Login</h2>\n"
					+ "        <p>You can now access your encrypted vault using your registered username and password.</p>\n"
					+ "        <a href=\"login1\" class=\"btn\" style=\"margin-top: 1rem;\">Sign In Now</a>\n"
					+ "      </div>\n"
					+ "    </div>\n"
					+ "  </section>\n");

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