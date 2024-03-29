<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Happy Store API</title>
</head>
<body>

<h1>API sample links</h1>

<ul>
    <li><a href="transaction?countryCode=FRA&amp;productId=1234&amp;storeId=1234">/transaction?<b>countryCode</b>=FRA&amp;<b>productId</b>=1234&amp;<b>storeId</b>=1234</a></li>
    <li><a href="transaction?countryCode=FRA&amp;productId=1234&amp;storeId=1234&amp;txId=1">/transaction?<b>countryCode</b>=FRA&amp;<b>productId</b>=1234&amp;<b>storeId</b>=1234&amp;<b>txId</b>=1</a></li>
    <li><a href="total?txId=1">/total?<b>txId</b>=1</a></li>
    <li><a href="inventory?storeId=1234">/inventory?<b>storeId</b>=1234</a></li>
    <li><a href="turnover?groupId=1">/turnover?<b>groupId</b>=1</a></li>
</ul>

<p>
    To connect to the in-memory database use the <a href="http://localhost:8080/happystore/console">H2 Console</a> with <i>jdbc:h2:mem:rundb</i> with the user <b>sa</b> and no password.
</p>
<p>
    You can look into the internal state using MBeans in the <i>bean</i> folder.
</p>
</body>
</html>
