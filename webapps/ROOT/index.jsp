<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <header>
        <h1>User Information</h1>
    </header>

    <main>
        <section class="user-info">
            <h2>Show Name and Location - 뭐 어쩔건데</h2>
            <div class="info-container">
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        Context initContext = new InitialContext();
                        Context envContext = (Context) initContext.lookup("java:/comp/env");
                        DataSource ds = (DataSource) envContext.lookup("jdbc/MyDB");
                        conn = ds.getConnection();

                        ps = conn.prepareStatement("SELECT * FROM user");
                        rs = ps.executeQuery();

                        while(rs.next()) {
                            String name = rs.getString("name");
                            String age = rs.getString("age");

                            out.println("<div class='user-card'>");
                            out.println("<p><strong>Name:</strong> " + name + "</p>");
                            out.println("<p><strong>Age:</strong> " + age + "</p>");
                            out.println("</div>");
                        }
                    } catch(Exception e) {
                        out.print("<p class='error'>Error: " + e.toString() + "</p>"); // 실제 애플리케이션에서는 로그에 기록
                    } finally {
                        try {
                            if (rs != null) rs.close();
                        } catch (SQLException e) {
                            out.print("<p class='error'>Failed to close ResultSet: " + e.toString() + "</p>");
                        }
                        try {
                            if (ps != null) ps.close();
                        } catch (SQLException e) {
                            out.print("<p class='error'>Failed to close PreparedStatement: " + e.toString() + "</p>");
                        }
                        try {
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.print("<p class='error'>Failed to close Connection: " + e.toString() + "</p>");
                        }
                    }
                %>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 My JSP Page. All rights reserved.</p>
    </footer>
</body>
</html>

