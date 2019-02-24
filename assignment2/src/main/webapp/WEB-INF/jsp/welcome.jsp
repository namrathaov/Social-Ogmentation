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
	<c:url value="/displayresults" var="postUrl" />
	<form:form method="POST"
			   action="${postUrl}">
		<label for="input">Select your query number here(as mentioned in the data excel file):
		</label>
		<select class="form-control" name="input">
			<c:forEach items="${input}" var="input">
				<option id=${input} value=${input}>${input}</option>
			</c:forEach>
		</select>
		<input type="submit" value="submit" />
	</form:form>
    <a href="<%=request.getContextPath()%>/search">Search custom query here!</a>
</div>
</body>
</html>