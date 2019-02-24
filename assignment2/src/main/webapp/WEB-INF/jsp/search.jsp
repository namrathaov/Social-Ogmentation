<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="t"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE>
<html>
<head>

    <style>
        .list-group {
            padding-left: 0;
            margin-bottom: 20px;
        }
        .list-group-item {
            position: relative;
            display: block;
            padding: 10px 15px;
            margin-bottom: -1px;
            background-color: #fff;
            border: 1px solid #ddd;
        }
    </style>
</head>


<body>
<h1>Welcome!</h1>

<div style="padding-bottom: 20px;">
    <c:url value="/searchresults" var="postUrl" />
    <form:form method="POST"
               action="${postUrl}">
        <label for="input">
        </label>
        Enter your query here: <input type="text" name="input" />
        <input type="submit" value="submit" />
    </form:form>
</div>
</body>
</html>