<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <header>
        <h1>User Login</h1>
    </header>

    <main>
        <section class="login-form">
            <h2>Enter Your Information</h2>
            <form action="/user/check.jsp" method="post">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="age">Age:</label>
                    <input type="number" id="age" name="age" required>
                </div>
                <div class="form-group">
                    <button type="submit">Submit</button>
		    <button type="button" onclick="history.back()">Go Back</button>
                </div>
            </form>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 My JSP Page. All rights reserved.</p>
    </footer>
</body>
</html>

