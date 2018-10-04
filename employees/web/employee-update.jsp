<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.mysql.jdbc.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<sql:query dataSource="jdbc/employees_partitioned_5.1" var="result">
    SELECT * FROM employees
</sql:query>

<sql:query dataSource="jdbc/employees_partitioned_5.1" var="employees">
    SELECT * FROM product WHERE emp_no = ?
    <sql:param value="${param.id}" />
</sql:query>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee</title>
</head>
<body>
<h1>Employee <c:out value="${param.id}"/></h1>
<c:forEach var="p" items="${employees.rows}">
<form action="employee-controller">
    <input type="hidden" name="cmd" value="u"/>
    <input type="hidden" name="emp_no" value='<c:out value="${p.id}"/>'/>
    <table>
        <tr>
            <td>Birth Date</td>
            <td><input type="text" name="birth_date" value='<c:out value="${p.birth_date}"/>'></td>
        </tr>
        <tr>
            <td>First Name</td>
            <td><input type="text" name="first_name" value='<c:out value="${p.first_name}"/>'></td>
        </tr>
        <tr>
            <td>Last Name</td>
            <td><input type="text" name="last_name" value='<c:out value="${p.last_name}"/>'></td>
        </tr>
        <tr>
            <td>Gender</td>
            <td>
                <select name="gender_id">
                    <c:forEach var="row" items="${result.rows}">
                        <option value='<c:out value="${row.id}"/>'
                        <c:if test = "${row.id} == ${p.gender_id}">
                            SELECTED
                        </c:if>
                        >
                        <c:out value="${row.name}"/>
                            <c:out value="${row.id}"/>
                            <c:out value="${p.category_id}"/>
                            <c:if test = "${row.id} == ${p.gender_id}">
                                SELECTED
                            </c:if>
                        </option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td>Hire Date</td>
            <td><input type="text" name="hire_date" value='<c:out value="${p.hire_date}"/>'></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Update">
            </td>
        </tr>
    </table>
</form>
</c:forEach>

</body>
</html>