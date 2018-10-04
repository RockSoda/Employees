<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.mysql.jdbc.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<script>
    function confirmDelete(id) {
        if (confirm('Are you sure?')) {
            window.location = "employee-controller?cmd=d&id="+id;
        }
    }
</script>
<head>
    <title>Employees</title>
</head>
<body>
<h1>Employees</h1>
<a href="employee.jsp">ADD</a>

<sql:query dataSource="jdbc/employees_partitioned_5.1" var="result">
    SELECT * FROM employees, titles
    WHERE employees.emp_no = titles.emp_no
</sql:query>


<table border="1">
    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td><c:out value="${row.name}"/></td>
            <td><c:out value="${row.description}"/></td>
            <td><c:out value="${row.price}"/></td>
            <td>
                <button onclick="window.location='employee-update.jsp/>';">UPDATE</button>
                <button onclick="confirmDelete(<c:out value="${row.id}"/>);">DELETE</button>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
