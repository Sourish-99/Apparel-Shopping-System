
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.Statement;
import com.connection.DatabaseConnection;

@WebServlet("/AddUser")
public class AddUser extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Retrieving values from the frontend
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String pincode = request.getParameter("pincode");

        //Creating Session
        HttpSession hs = request.getSession();

        try {

            Connection con = DatabaseConnection.getConnection();
            Statement qrst = con.createStatement();
            ResultSet resultset = qrst.executeQuery("select * from tblcustomer where email='" + email + "'");

            if (!resultset.next()) {

                try {
                    //Connecting database connection and querying in the database
                    int addCustomer = DatabaseConnection.insertUpdateFromSqlQuery("insert into tblcustomer(address,email,gender,name,password,phone,pin_code)values('" + address + "','" + email + "','" + gender + "','" + name + "','" + password + "','"
                            + mobile + "','" + pincode + "')");

                    //If customer registered successfully
                    if (addCustomer > 0) {

                        String message = "Customer register successfully.";
                        hs.setAttribute("success-message", message);
                        response.sendRedirect("user-register.jsp");
                    } else {

                        String message = "Customer registration fail";
                        hs.setAttribute("fail-message", message);
                        response.sendRedirect("user-register.jsp");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            } else {

                String message = "Account already exists with this Email id.";
                hs.setAttribute("exists-message", message);
                response.sendRedirect("user-register.jsp");

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
