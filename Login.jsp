<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="Login.css">
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
    <h3>Author Login</h3>
    <form method="POST" action="Login.jsp">
        <div class="labels">
            <label for="em">Enter your email:</label>
            <label for="pass">Enter your password:</label>
        </div>
        <div class="inputs">
            <input type="email" id="em" name="em" required>
            <input type="password" id="pass" name="pass" required>
        </div>
        <div class="sub">
            <button type="submit">Login!!</button>
            <p>New Author??</p>
            <button type="button" onclick="window.location.href='Registration.jsp';">Register!!</button>
        </div>
    </form>

    <%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String email = request.getParameter("em");
        String pass = request.getParameter("pass");

        if (email == null || email.isEmpty() || pass == null || pass.isEmpty()) {
    %>
            <script>
                alert("Input fields should not be empty!!");
            </script>
    <%
        } else {
            Connection con = null;
            PreparedStatement pst = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Tanuja", "root", "shinchu");

                String query = "SELECT * FROM authors WHERE email = ? AND pass = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, email);
                pst.setString(2, pass);
                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    session.setAttribute("authorEmail",email);
    %>
                    <script>
                        alert("Login Successful");
                        window.location.href = "Submit.jsp";
                    </script>
    <%
                } else {
    %>
                    <script>
                        alert("Invalid email or password");
                    </script>
    <%
                }
            } catch (Exception e) {
    %>
                <script>
                    alert("Login Failed due to Exception: <%= e.getMessage() %>");
                </script>
    <%
            } finally {
                try {
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
    %>
                    <script>
                        alert("Error closing resources: <%= se.getMessage() %>");
                    </script>
    <%
                }
            }
        }
    }
    %>
</body>
</html>
