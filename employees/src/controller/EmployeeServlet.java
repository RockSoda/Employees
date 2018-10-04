package controller;// Import required java libraries

import javax.naming.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

// Extend HttpServlet class
public class EmployeeServlet extends HttpServlet {

    public void init() throws ServletException {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Deletion
        String emp_no = request.getParameter("emp_no");
        String cmd = request.getParameter("cmd");

        // Insertion
        String birth_date = request.getParameter("birth_date");
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String gender_id = request.getParameter("gender_id");
        String hire_date = request.getParameter("hire_date");


        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


        // Insertion
        out.println(birth_date+"<br/>");
        out.println(first_name+"<br/>");
        out.println(last_name+"<br/>");
        out.println(gender_id+"<br/>");
        out.println(hire_date+"<br/>");

        Context envContext = null;
        try {
            envContext = new InitialContext();
            out.println(envContext+"<br>");
//            NamingEnumeration<NameClassPair> list = envContext.list("java:comp/env");
//            while (list.hasMore()) {
//                NameClassPair nc = (NameClassPair)list.next();
//                out.println(nc);
//            }
//            Context initContext  = (Context)envContext.lookup("java:/comp/env");
            Context initContext = envContext;
//            DataSource ds = (DataSource)initContext.lookup("jdbc/affableBean");
            DataSource ds = (DataSource)envContext.lookup("java:/comp/env/jdbc/employees_partitioned_5.1");
            Connection con = ds.getConnection();


            String sql = "";
            if (cmd != null && cmd.equals("d")) {
                // Delete a product
                sql = "DELETE FROM employees WHERE emp_no = ?";
                PreparedStatement stmt = con.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(emp_no));
                stmt.execute();
            } else if (cmd != null && cmd.equals("u")) {
                // Update a product
                sql = "UPDATE employees SET birth_date = ?, first_name = ?, last_name = ?, gender_id = ?, hire_date = ? WHERE emp_no = ?";
                PreparedStatement stmt=con.prepareStatement(sql);
                stmt.setString(1,birth_date);
                stmt.setString(2,first_name);
                stmt.setString(3,last_name);
                stmt.setInt(4,Integer.parseInt(gender_id));
                stmt.setInt(5,Integer.parseInt(emp_no));
                stmt.execute();

            } else {
                // Insert a new product
                sql = "insert into product (birth_date, first name, last_name, gender_id, hire_date)  values (?,?,?,?,?)";
                PreparedStatement stmt=con.prepareStatement(sql);
                stmt.setString(1,birth_date);
                stmt.setString(2,first_name);
                stmt.setString(3,last_name);
                stmt.setInt(4,Integer.parseInt(gender_id));
                stmt.setString(5,hire_date);
                stmt.execute();
            }
//            out.println("Row affect "+r+"<br>");
            response.sendRedirect("employees.jsp");

        }  catch (SQLException | NamingException e) {
            e.printStackTrace();
            out.print(e);
        }
    }

    public void destroy() {
        // do nothing.
    }
}