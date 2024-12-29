<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="admin.css">
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
    
    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="admin.jsp" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="login-button">Login</button>
        </form>
    </div>

    <% 
        // Check if the form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String url = "jdbc:mysql://localhost:3306/Tanuja"; // replace with your DB URL
            String dbUser = "root"; // replace with your DB username
            String dbPassword = "shinchu"; // replace with your DB password

            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Establish connection
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // Prepare SQL query for authentication
                String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);

                // Execute the query
                rs = stmt.executeQuery();

                if (rs.next()) {
                    // If user is found, redirect to dashboard or admin page
                %>
                    <script>window.location.href='page.jsp';</script>
                <%
                } else {
                    // If user is not found, display an error message
                    out.println("<script>alert('Invalid Username or Password!');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

</body>
</html>
