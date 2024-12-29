<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link rel='stylesheet' href='home.css'>
</head>
<body>
    <header>
        <nav>
            <ul class="navbar">
                <li><a href="Home.jsp">Home</a></li>
                <li><a href="about-us.html">About Us</a></li>
                <li><a href="Login.jsp">Author Login</a></li>
                <li><a href="admin.jsp">Admin Login</a></li>
                <li><a href="Submit.jsp">Submit</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <h1 style="margin-top: 50px;">Balle Balle Articles!!</h1>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Article Name</th>
                    <th>Author Name</th>
                    <th>Article Image</th>
                    <th>Email</th>
                    <th>Article</th>
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
                        String query = "SELECT * FROM articles WHERE status='Approved'";
                        
                        if (filter != null && !filter.equals("all")) {
                            query += " AND status = ?";
                        }
                        
                        // Prepare the statement
                        stmt = conn.prepareStatement(query);
                        int paramIndex = 1;

                        if (filter != null && !filter.equals("all")) {
                            stmt.setString(paramIndex++, filter);
                        }
                        

                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            String id = rs.getString("id");
                            String articleName = rs.getString("article_name");
                            String articleImage=rs.getString("article_img");
                            String authorName = rs.getString("author_name");
                            String authorEmail = rs.getString("author_email");
                            String articleFile = rs.getString("article_file");

                %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= articleName %></td>
                                <td><%= authorName %></td>
                                <td><img src="<%= articleImage %>" alt="Article Image" style="width:100px;height:auto;"></td>
                                <td><%= authorEmail %></td>
                                <td><button class="action-button" onclick="window.location.href='<%= articleFile %>'">Open</button></td>
                            </tr>
                            <script>
                                var articleFile = "<%= articleFile %>";
                            </script>                
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
