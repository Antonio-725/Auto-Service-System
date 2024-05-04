<%-- 
    Document   : Payments
    Created on : Apr 1, 2024, 12:03:44 PM
    Author     : antonio
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Confirm Payment</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 600px;
        margin: 100px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    h1 {
        text-align: center;
        color: #333;
    }

    .amount {
        text-align: center;
        font-size: 2em;
        margin-top: 20px;
        margin-bottom: 40px;
        color: #007bff;
    }

    .container {
    max-width: 600px;
    margin: 100px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    align-items: center;
}

.btn {
    padding: 10px 20px;
    margin-top: 20px;
    background-color: #007bff;
    color: #fff;
    text-align: center;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #0056b3;
}

</style>
</head>
<body>
    <div class="container">
        <form  action="<%=request.getContextPath()%>/PaymentServlet" method="post">
        <h1>Payable Amount</h1>
        <p class="amount" name ="amount">Amount: <%= (int)(Math.random() * 49000) + 1000 %> KES</p>
        <p>Click the button below to confirm your payment.</p>
        
        <button type="submit" class="btn">Confirm Payment</button>
        </form>
    </div>
</body>
</html>
