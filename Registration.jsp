<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <link rel="stylesheet" href="Registration.css">
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
    <h3 style="margin-left: 37%;">Welcome to Balle Balle Articles..!</h3>
    <h2>Registration Page</h2>
    <form method="POST" action="Registration.jsp">
        <div class="labels">
            <label for="name">Enter your name:</label>
            <label for="age">Enter your age:</label>
            <label for="em">Enter your email:</label>
            <label for="pass">Enter your password:</label>
        </div>
        <div class="inputs">
            <input type="text" id="name" name="name">
            <input type="number" id="age" name="age">
            <input type="email" id="em" name="em">
            <input type="password" id="pass" name="pass">
        </div>
        <div class="sub">
            <button type="submit">Register!!</button>
            <p>Already Registered??</p>
            <button type="button" onclick="window.location.href='Login.jsp';">Login!!</button>
        </div>
    </form>
    <%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String name = request.getParameter("name");
        String ages = request.getParameter("age");
        String email = request.getParameter("em");
        String pass = request.getParameter("pass");
        if (name == null || name.isEmpty() || ages == null || ages.isEmpty() || email == null || email.isEmpty() || pass == null || pass.isEmpty()) {
        %>
            <script>
                alert("Input fields should not be empty!!");
            </script>
        <%
        }
        Connection con = null;
        PreparedStatement pst = null;
        int i = 0;
        try {
            int age=Integer.parseInt(ages);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Tanuja", "root", "shinchu");
            pst = con.prepareStatement("INSERT INTO authors (name,age, email,pass) VALUES (?,?, ?, ?)");
            pst.setString(1, name);
            pst.setInt(2, age);
            pst.setString(3, email);
            pst.setString(4, pass);
            i = pst.executeUpdate();
            if (i > 0) {
        %>
        <script>
            alert("Registered Successfully");
        </script>
    <%
        } else {
    %>
        <script>
            alert("Registration Failed due to Data");
        </script>
    <%
        }
    } catch (Exception e) {
    %>
        <script>
            alert("Registration Failed due to Exception: <%= e.getMessage() %>");
        </script>
    <%
    } finally {
        // Close resources
        try {
            if (pst != null) pst.close();
            if (con != null) con.close();
        } catch (SQLException se) {
            out.println("Error closing resources: " + se.getMessage());
        }
    }

    }
    %>
</body>
</html>