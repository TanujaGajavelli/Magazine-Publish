<%@ page import="java.io.*, java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Article</title>
    <link rel="stylesheet" href="Submit.css">
</head>
<body>
    <%
    String loggedInEmail = (String) session.getAttribute("authorEmail");
    if (loggedInEmail == null) {
    %>
        <script>
            alert("Please log in first!");
            window.location.href = "Login.jsp";
        </script>
    <%
    } else {
    %>
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

    
    <form method="POST" action="Submit.jsp">
        <h2>Enter the details of your article:</h2>
        <div class="labels">
            <label for="author_name">Enter your name:</label>
            <label for="author_email">Enter your email:</label>
            <label for="article_name">Enter your article name:</label>
            <label for="article_file">Enter your file:</label>
            <label for="article_img">Enter your image:</label>
        </div>
        <div class="inputs">
            <input type="text" id="author_name" name="author_name" required>
            <input type="email" id="author_email" name="author_email" required>
            <input type="text" id="article_name" name="article_name" required>
            <input type="text" id="article_file" name="article_file">
            <input type="text" id="article_img" name="article_img">
        </div>
        <button type="submit">Submit!!</button>
    </form>

    <%
    String authorName = request.getParameter("author_name");
    String authorEmail = request.getParameter("author_email");
    String articleName = request.getParameter("article_name");
    String articleFile = request.getParameter("article_file");
    String articleImg = request.getParameter("article_img");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (authorName == null || authorName.isEmpty() ||
            authorEmail == null || authorEmail.isEmpty() ||
            articleName == null || articleName.isEmpty()) {
    %>
            <script>
                alert("Please fill in all required fields.");
            </script>
    <%
        } else {
            String dbURL = "jdbc:mysql://localhost:3306/Tanuja";
            String dbUser = "root";
            String dbPass = "shinchu";
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                String sql = "INSERT INTO articles (author_name, author_email, article_name, article_file, article_img) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, authorName);
                pstmt.setString(2, authorEmail);
                pstmt.setString(3, articleName);
                pstmt.setString(4, articleFile); // Assuming file paths are submitted as text
                pstmt.setString(5, articleImg);  // Assuming image paths are submitted as text

                int row = pstmt.executeUpdate();

                if (row > 0) {
    %>
                    <script>
                        alert("Article submitted successfully.");
                        window.location.href = "Home.jsp";
                    </script>
    <%
                } else {
    %>
                    <script>
                        alert("Article submission failed.");
                    </script>
    <%
                }
            } catch (Exception e) {
    %>
                <script>
                    alert("An error occurred: <%= e.getMessage() %>");
                </script>
    <%
            } finally {
                if (pstmt != null) {
                    try { pstmt.close(); } catch (SQLException se) { /* Ignore */ }
                }
                if (conn != null) {
                    try { conn.close(); } catch (SQLException se) { /* Ignore */ }
                }
            }
        }
    }
}
    %>
</body>
</html>
