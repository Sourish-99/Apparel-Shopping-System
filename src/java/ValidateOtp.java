
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ValidateOtp")
public class ValidateOtp extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int value = Integer.parseInt(request.getParameter("otp"));
        HttpSession hs = request.getSession();

        if (hs.getAttribute("otp-sys") != null) {

            int otp = (int) hs.getAttribute("otp-sys");

            if (value == otp) {

                hs.setAttribute("otp-stat", "success");
                hs.removeAttribute("otp-sys");
                response.sendRedirect("new-password.jsp");

            } else {

                String message = "Your OTP is not valid";
                hs.setAttribute("cred-otp", message);
                response.sendRedirect("validate-otp.jsp");
            }
        } else {
            response.sendRedirect("forgot-password.jsp");
        }
    }
}
