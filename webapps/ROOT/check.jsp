<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Check User Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <header>
        <h1>User Information Confirmation</h1>
    </header>

    <main>
        <section class="user-info">
            <h2>Submitted Information</h2>
            <div class="info-container">
                <%
                    String name = request.getParameter("name");
                    String age = request.getParameter("age");

		    out.println("<p>Debug: name = " + name + "</p>");
                    out.println("<p>Debug: age = " + age + "</p>");

                    if (name != null && age != null && !name.isEmpty() && !age.isEmpty()) {
                        Connection conn = null;
                        PreparedStatement ps = null;

                    try {
                        Context initContext = new InitialContext();
                        Context envContext = (Context) initContext.lookup("java:/comp/env");
                        DataSource ds = (DataSource) envContext.lookup("jdbc/MyDB");
                        conn = ds.getConnection();

                        ps = conn.prepareStatement("INSERT INTO user (name, age) VALUES (?, ?)");
                        ps.setString(1, name);
                        ps.setString(2, age);
                        ps.executeUpdate();

                        out.println("<div class='user-card'>");
                        out.println("<p><strong>Name:</strong> " + name + "</p>");
                        out.println("<p><strong>Age:</strong> " + age + "</p>");
                        out.println("</div>");
                    } catch(Exception e) {
                        out.print("<p class='error'>Error: " + e.toString() + "</p>"); // 실제 애플리케이션에서는 로그에 기록
                    } finally {
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
		    } else {
                        out.print("<p class='error'>Error: Name and Age cannot be empty</p>");
                    }
                %>
            </div>
	    <div class="form-group">
                <button type="button" onclick="location.href='/user'">View All Users</button>
		<button type="button" onclick="location.href='/'">Go to Main</button>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 My JSP Page. All rights reserved.</p>
    </footer>
</body>
</html>

