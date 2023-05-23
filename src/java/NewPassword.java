
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.DatabaseConnection;

@WebServlet("/NewPassword")
public class NewPassword extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession hs = request.getSession();

        String email = (String) hs.getAttribute("email-fr");
        String otstat = (String) hs.getAttribute("otp-stat");
        String password = request.getParameter("password");

        if (otstat != null) {

            try {

                int updPass = DatabaseConnection.insertUpdateFromSqlQuery("update tblcustomer set password='" + password + "'where email='" + email + "'");

                if (updPass > 0) {
                    String message = "Password for " + email + " has been updated.";
                    hs.setAttribute("password-success", message);
                    hs.removeAttribute("email-fr");
                    hs.removeAttribute("otp-stat");
                    response.sendRedirect("user-login.jsp");
                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } else {
            String message = "Kindly use forget password first.";
            hs.setAttribute("password-fail", message);
            response.sendRedirect("new-password.jsp");
        }
    }
}
