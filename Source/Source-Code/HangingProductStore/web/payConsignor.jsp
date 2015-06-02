<%-- 
    Document   : manageProductStatus
    Created on : May 31, 2015, 11:37:43 AM
    Author     : Tien Dan
--%>

<template:shopbasic htmlTitle="Pay Consignor" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
        <!-- Nơi để khai báo page level javascript -->
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <li id="nofi">
            <a href="#">
                <i class="icon-bell"></i>
                <span class="badge badge-default">3</span>           
            </a>
            <ul class="fallback">
                <li style="margin-left: -40px"><a href="#">notification 1</a></li>
                <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                <li style="margin-left: -40px"><a href="#">notification 4</a></li>
            </ul>
        </li>
    </jsp:attribute>
    <jsp:body>
        <div class="tab-content">
            <form action="ProcessServlet" method="POST">
                <div class="row">
                    <c:set var="consignee" value="${requestScope.consignor}"/>
                    <div class="col-sm-6">
                        Store onwer's information
                        <div class="form-horizontal">
                            <div class="form-group">
                                Name : <input type="text" readonly="readonly" class="text-muted" value="${consignee.fullName}"> </br>
                                Credit Card Number : <input type="text" readonly="readonly" class="text-muted" value="${consignee.creditCardNumber}"> </br>
                                Credit Card Owner : <input type="text" readonly="readonly" class="text-muted" value="${consignee.creditCardOwner}"> 
                            </div>
                        </div>
                    </div>
                    <c:set var="consignor" value="${requestScope.consignee}"/>
                    <div class="col-sm-6">
                        Consignor's information
                        <div class="form-horizontal">
                            <div class="form-group">
                                Name : <input type="text" readonly="readonly" class="text-muted" value="${consignor.fullName}"></br>
                                Credit Card Number : <input type="text" readonly="readonly" class="text-muted" value="${consignor.creditCardNumber}"> </br>
                                Credit Card Owner : <input type="text" readonly="readonly" class="text-muted" value="${consignor.creditCardOwner}"> 
                            </div>
                        </div>
                    </div>
                    <div>
                        <c:set var="amount" value="${requestScope.amount}"/>
                        Payment information </br>
                        Amount: <input type="text" readonly="readonly" class="text-muted" value="${amount} USD"></br>
                        Context: <input type="text">
                    </div>
                        <button name="action" class="btn btn-default" type="button">Next</button>
                        <button class="btn btn-default" type="button">Cancel</button>
                </div>
            </form>
        </jsp:body>
    </template:shopbasic>
