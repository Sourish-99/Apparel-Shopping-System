
import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import com.connection.DatabaseConnection;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String email = request.getParameter("email");

            HttpSession hs = request.getSession();

            Connection con = DatabaseConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet resultset = st.executeQuery("select * from tblcustomer where email='" + email + "'");

            //If all the details are correct
            if (resultset.next()) {

                Random rand = new Random();
                int otpvalue = Integer.parseInt(String.format("%06d", rand.nextInt(999999)));

                // Get the session object
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                Session session = Session.getInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("ragsntags0@gmail.com", "----------");
                    }
                });

                // compose message
                try {
                    MimeMessage message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(email));
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                    message.setSubject("Password Reset Request");
                    message.setContent("<body style='font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;'> <table role='presentation' style='width: 100%; border-collapse: collapse; border: 0px none; border-spacing: 0px; font-family: Arial, Helvetica, sans-serif; background-color: rgb(239, 239, 239);'> <tbody> <tr> <td style='padding: 1rem 2rem; vertical-align: top; width: 100%;' align='center'> <table role='presentation' style='max-width: 600px; border-collapse: collapse; border: 0px none; border-spacing: 0px; text-align: left;'> <tbody> <tr> <td style='padding: 40px 0px 0px;'> <div style='text-align: center;'> <div style='padding-bottom: 5px;'><img src='https://i.gyazo.com/4ea8b72c135d1984825f1fff12b26f43.png' style='width: 400px;'></div></div> <div style='padding: 20px; background-color: rgb(255, 255, 255);'> <div style='color: rgb(0, 0, 0); text-align: left;'> <h1 style='margin: 1rem 0'>Verification code</h1> <p style='padding-bottom: 16px'>Please use the OTP below to validate.</p> <p style='padding-bottom: 16px; text-align: center;'><strong style='font-size: 130%'>" + otpvalue + "</strong></p> <p style='padding-bottom: 16px'>If you didn't request this, you can ignore this email.</p> <p style='padding-bottom: 16px'>Thanks,<br>Rags and Tags team</p> </div> </div> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table></body>", "text/html");
                    Transport.send(message);
                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }

                String message = "OTP has been sent to " + email + ". Check your email.";
                hs.setAttribute("pass-sent", message);
                hs.setAttribute("otp-sys", otpvalue);
                hs.setAttribute("email-fr", email);
                response.sendRedirect("validate-otp.jsp");

            } else {
                String message = "You are not registered with us. Kindly register in our portal.";
                hs.setAttribute("credeforg", message);
                response.sendRedirect("forgot-password.jsp");

            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
