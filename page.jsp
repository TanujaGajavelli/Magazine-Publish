<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Review Articles</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <nav>
                <ul class="navbar">
                    <li><a href="Home.jsp">Home</a></li>
                    <li><a href="/About-us">About Us</a></li>
                    <li><a href="Login.jsp">Author Login</a></li>
                    <li><a href="admin.jsp">Admin Login</a></li>
                    <li><a href="Submit.jsp">Submit</a></li>
                </ul>
            </nav>
        </header>
        <h1 style="margin-top: 5%;">Review Articles</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Article Name</th>
                    <th>Author Name</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String url = "jdbc:mysql://localhost:3306/Tanuja"; // replace with your database URL
                    String user = "root"; // replace with your database username
                    String password = "shinchu"; // replace with your database password
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        // Establish the connection
                        Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
                        conn = DriverManager.getConnection(url, user, password);

                        // Get the filter and search parameters
                        String filter = request.getParameter("filter");
                        String search = request.getParameter("search");
                        String query = "SELECT * FROM articles WHERE 1=1";
                        
                        if (filter != null && !filter.equals("all")) {
                            query += " AND status = ?";
                        }
                        
                        if (search != null && !search.isEmpty()) {
                            query += " AND article_name LIKE ?";
                        }

                        // Prepare the statement
                        stmt = conn.prepareStatement(query);
                        int paramIndex = 1;

                        if (filter != null && !filter.equals("all")) {
                            stmt.setString(paramIndex++, filter);
                        }
                        
                        if (search != null && !search.isEmpty()) {
                            stmt.setString(paramIndex++, "%" + search + "%");
                        }

                        // Execute the query
                        rs = stmt.executeQuery();

                        // Loop through the result set and display the data
                        while (rs.next()) {
                            String id = rs.getString("id");
                            String articleName = rs.getString("article_name");
                            String authorName = rs.getString("author_name");
                            String authorEmail = rs.getString("author_email");
                            String status = rs.getString("status");
                %>
                            <tr class="data">
                                <td><%= id %></td>
                                <td><%= articleName %></td>
                                <td><%= authorName %></td>
                                <td><%= authorEmail %></td>
                                <td class="<%= status %>">
                                    <%= status.substring(0, 1).toUpperCase() + status.substring(1) %>
                                    <form action="update_status.jsp" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= id %>">
                                        <button type="submit" name="status" value="approved" class="approve-btn">Approve</button>
                                        <button type="submit" name="status" value="rejected" class="reject-btn">Reject</button>
                                    </form>
                                </td>                                
                                <td><button class="action-button">Open</button></td>
                            </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close the database resources
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
