<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
        pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://db:3306/";
String dbName = "cert_tracker";
String userId = "root";
String password = "root";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>

<head>
    <title>Certificate Tracker</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        h3 span {
            font-size: 22px;
        }
        h3 input.search-input {
            width: 300px;
            margin-left: auto;
            float: right
        }
        .mt32 {
            margin-top: 32px;
        }
    </style>
</head>
<body class="mt32">
    <div class="container">
        <h1>
            <span><center>Certificate Tracker</center></span></h1>
        <h3>
            <input type="search" placeholder="Search..." class="form-control search-input" data-table="customers-list"/>
            <a href="/prodcert/upload.jsp">Click To Upload Certs</a>
                <br>
                </br>
        </h3>
        <table class="table table-striped mt32 customers-list">
            <thead>
                <tr>

        <th><span>Certificate Name</span></th>
        <th><span>Expiry Date </br> (YYYY-MM-DD)</span></th>
        <th><span>Remaining Days</span></th>
        <th><span>Status</span></th>
      </tr>
    </thead>
    <tbody>
<%
try {
connection = DriverManager.getConnection(
connectionUrl + dbName, userId, password);
statement = connection.createStatement();
String sql = "SELECT * FROM certificate ORDER BY Expiry_Date";

resultSet = statement.executeQuery(sql);
while (resultSet.next()) {
%>

<td><%=resultSet.getString("Cert_Name")%></td>
<td><%=resultSet.getString("Expiry_Date")%></td>
<td><%=resultSet.getString("Remaining_Days")%></td>
<td><%=resultSet.getString("Status")%></td>

</tr>

<%
}

} catch (Exception e) {
e.printStackTrace();
}
%>

    </tbody>
  </table>
 </div>
<script>
        (function(document) {
            'use strict';

            var TableFilter = (function(myArray) {
                var search_input;

                function _onInputSearch(e) {
                    search_input = e.target;
                    var tables = document.getElementsByClassName(search_input.getAttribute('data-table'));
                    myArray.forEach.call(tables, function(table) {
                        myArray.forEach.call(table.tBodies, function(tbody) {
                            myArray.forEach.call(tbody.rows, function(row) {
                                var text_content = row.textContent.toLowerCase();
                                var search_val = search_input.value.toLowerCase();
                                row.style.display = text_content.indexOf(search_val) > -1 ? '' : 'none';
                            });
                        });
                    });
                }

                return {
                    init: function() {
                        var inputs = document.getElementsByClassName('search-input');
                        myArray.forEach.call(inputs, function(input) {
                            input.oninput = _onInputSearch;
                        });
                    }
                };
            })(Array.prototype);

            document.addEventListener('readystatechange', function() {
                if (document.readyState === 'complete') {
                    TableFilter.init();
                }
            });

        })(document);
    </script>


</body>
</html>
</br>
</br>

<p align="right"> Developed by: Soumith Vokkerla</p>
