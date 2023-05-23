<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Checkout</title>
        <!-- Importing all ui libs -->
        <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <link href="assets/css/style.css" rel="stylesheet" />
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script src="js/simpleCart.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <link href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,900,900italic,700italic' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <script src="js/jquery.easing.min.js"></script>
        <script src="jquery-3.2.1.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </head>
    <body>
        <%
            //Checking whether customer in session or not
            if (session.getAttribute("name") != null && session.getAttribute("name") != "") {
        %>
    <body>
        <div class="ban-top">
            <div class="container">
                <div class="top_nav_left">
                    <nav class="navbar navbar-default">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle collapsed"
                                        data-toggle="collapse"
                                        data-target="#bs-example-navbar-collapse-1"
                                        aria-expanded="false">
                                    <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="collapse navbar-collapse menu--shylock" id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav menu__list">
                                    <li class="menu__item"><a class="menu__link" href="index.jsp">Home</a></li>
                                    <li class="menu__item"><a class="menu__link" href="products.jsp">Products</a></li>
                                        <%
                                            if ((String) session.getAttribute("name") != null) {
                                        %>
                                    <li class="menu__item"><a class="menu__link" href="my-orders.jsp">My Orders</a></li>
                                    <li class="menu__item"><a class="menu__link" href="logout.jsp">Logout</a></li>
                                        <%
                                        } else {
                                        %>
                                    <li class="menu__item"><a class="menu__link" href="user-login.jsp">User Login</a></li>
                                    <li class="menu__item"><a class="menu__link" href="user-register.jsp">User Register</a></li>
                                    <li class="menu__item"><a class="menu__link" href="admin-login.jsp">Admin Login</a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </div>
                <div class="top_nav_right">
                    <div class="cart box_1">
                        <a href="checkout.jsp"> 
                            <%
                                //Getting all cart details of the customer
                                ResultSet resultCount = DatabaseConnection.getResultFromSqlQuery("select count(*) from tblcart where customer_id='" + session.getAttribute("id") + "'");
                                resultCount.next();
                                int count = resultCount.getInt(1);
                            %>
                            <h3>
                                <div class="total">
                                    <i class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></i>
                                    [
                                    <%=count%>
                                    ] Cart
                                </div>
                            </h3>
                        </a>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

        <div class="page-head"></div>

        <div class="checkout">
            <div class="container">
                <h3>My Shopping Cart</h3>
                <%
                    int index = 0;
                    int paymentId = 101;
                    ResultSet rsCountCheck = DatabaseConnection.getResultFromSqlQuery("select count(*) from tblcart where customer_id='" + session.getAttribute("id") + "'");
                    rsCountCheck.next();
                    int cartItem = rsCountCheck.getInt(1);
                    System.out.println("cartItem  " + cartItem);
                    if (cartItem > 0) {
                %>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>SR.No</th>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>MRP (Rs)</th>
                                <th>Selling Price (Rs)</th>
                                <th>Total Price (Rs)</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <%
                            ResultSet totalProduct = DatabaseConnection.getResultFromSqlQuery("select tblproduct.image_name,tblproduct.name,tblcart.quantity,tblcart.mrp_price,tblcart.discount_price,tblcart.total_price,tblcart.product_id from tblproduct,tblcart where tblproduct.id=tblcart.product_id and customer_id='"
                                    + session.getAttribute("id") + "' ");
                            while (totalProduct.next()) {
                                index++;
                        %>
                        <tr class="rem1">
                            <td class="invert"><%=index%></td>
                            <td class="invert"><img
                                    src="uploads/<%=totalProduct.getString(1)%>" alt=""
                                    class="pro-image-front" style="width: 100px; height: auto; display: block; margin-left: auto; margin-right: auto;"><br><center><b><%=totalProduct.getString(2)%></b></center></td>
                        <td class="invert">
                            <div class="quantity">
                                <div class="quantity-select">
                                    <form action="UpdateProductQuantity" method="post">
                                        <input type="hidden" value="<%=totalProduct.getInt(7)%>"
                                               name="productId"> <input type="number"
                                               name="quantity" value="<%=totalProduct.getInt(3)%>"
                                               style="width: 50px; height: 35px;">&nbsp;<input
                                               type="submit" class="btn btn-danger" value="Change" >
                                    </form>
                                </div>
                            </div>
                        </td>
                        <td class="invert"><del>Rs. <%=totalProduct.getString(4)%>&nbsp;</del></td>
                        <td class="invert">Rs. <%=totalProduct.getString(5)%>&nbsp;</td>
                        <td class="invert">Rs. <%=totalProduct.getString(6)%>&nbsp;</td>
                        <td class="invert"><a
                                href="removeProductFromCart.jsp?productId=<%=totalProduct.getInt(7)%>"
                                onclick="return confirm('Are you sure you want to remove this item from cart?');"><i
                                    class="fa fa-trash"></i></a></td>
                        </tr>
                        <%
                            }
                        %>
                        <%
                            double finalBill = 0.0;
                            ResultSet totolAmount = DatabaseConnection.getResultFromSqlQuery("select sum(total_price), sum(mrp_price) from tblcart where customer_id='" + session.getAttribute("id") + "' ");
                            if (totolAmount.next()) {
                                finalBill = totolAmount.getInt(1);
                            }
                        %>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td colspan="2"><strong><center>
                                        Total Amount.:&nbsp;&nbsp;Rs. <%=finalBill%>
                                    </center></strong>
                            </td>
                        </tr>
                        <script>
                            $('.value-plus').on('click', function () {
                                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) + 1;
                                divUpd.text(newVal);
                            });

                            $('.value-minus').on('click', function () {
                                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) - 1;
                                if (newVal >= 1)
                                    divUpd.text(newVal);
                            });
                        </script>
                    </table>
                </div>
                <div>
                    <br> <br> <br>
                </div>
                <form action="GetProductsOrder" method="post">
                    <h4>
                        <font color="blue"><strong>Billing Address</strong></font>
                    </h4>
                    <br>
                    <%
                        ResultSet userInfoResult = DatabaseConnection.getResultFromSqlQuery("select * from tblcustomer where id='" + session.getAttribute("id") + "' and name='" + session.getAttribute("name") + "'");
                        if (userInfoResult.next()) {
                    %>
                    <div>
                        <div class="form-group">
                            <label>Your Name</label> <input type="text" name="name"
                                                            value="<%=userInfoResult.getString("name")%>" placeholder=""
                                                            required="" style="width: 1135px; height: 40px;"
                                                            class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label> <input type="text" name="phone"
                                                               value="<%=userInfoResult.getString("phone")%>" placeholder=""
                                                               required="" style="width: 1135px; height: 40px;"
                                                               class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label>Email Id</label> <input type="text" name="email"
                                                           value="<%=userInfoResult.getString("email")%>" placeholder=""
                                                           required="" style="width: 1135px; height: 40px;"
                                                           class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label>Address</label> <input type="text" name="address"
                                                          value="<%=userInfoResult.getString("address")%>" placeholder=""
                                                          required="" style="width: 1135px; height: 100px;"
                                                          class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label>Pin Code</label> <input type="text" name="pincode"
                                                           value="<%=userInfoResult.getString("pin_code")%>" placeholder=""
                                                           required="" style="width: 1135px; height: 40px;"
                                                           class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label>Select Address Type</label> <select name="addressType"
                                                                       value="" style="width: 1135px; height: 40px;"
                                                                       class="form-control">
                                <option>Home</option>
                                <option>Office</option>
                                <option>Commercial</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Select Payment Mode</label> <select name="payment"
                                                                       style="width: 1135px; height: 40px;" class="form-control">
                                <option>UPI</option>
                                <option>Credit Card</option>
                                <option>Debit Card</option>
                                <option>Cash On Delivery</option>
                            </select>
                        </div>
                        <div>
                            <%
                                ResultSet rsPaymentId = DatabaseConnection.getResultFromSqlQuery("select max(payment_id) from tblorders");
                                if (rsPaymentId.next()) {
                                    paymentId = rsPaymentId.getInt("max(payment_id)");
                                    paymentId++;
                                }
                            %>
                            <input type="text" name="payment_id" value="<%=paymentId%>" hidden>
                            <input type="submit" value="Buy Products" class="btn btn-success" onclick="return confirm('Are you sure Do you want to buy this order?');">
                        </div>
                    </div>
                </form>
                <%
                    }
                %>

                <%
                } else {
                %>
                <center>
                    <strong>Your Order has been placed</strong>
                </center>
                <%
                    if (index == 0) {
                %>
                <center>
                    <strong>Your Cart is empty</strong>
                </center>
                <%
                    }
                %>
                <%
                    }
                %>
                <div class="checkout-left">
                    <div class="checkout-right-basket animated wow slideInRight" data-wow-delay=".5s">
                        <a href="index.jsp"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Back To Shopping</a>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
        <%
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
    </body>
</html>