<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
    String id = request.getParameter("id");
    String status = request.getParameter("status");
    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        // Database connection details
        String url = "jdbc:mysql://localhost:3306/Tanuja"; // replace with your database URL
        String user = "root"; // replace with your database username
        String password = "shinchu"; // replace with your database password

        // Establish the connection
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
        conn = DriverManager.getConnection(url, user, password);

        if ("rejected".equals(status)) {
            String deleteQuery = "DELETE FROM articles WHERE id = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setString(1, id);
            stmt.executeUpdate();
        } else {
            String updateQuery = "UPDATE articles SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, status);
            stmt.setString(2, id);
            stmt.executeUpdate();
        }
        %>
        <script>window.location.href="page.jsp"</script>
        <%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
