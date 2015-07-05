<%-- 
    Document   : manageAccount
    Created on : Jul 3, 2015, 9:52:15 AM
    Author     : HoangNHSE61007
--%>

<template:shopbasic htmlTitle="Home" bodyTitle="">
    <jsp:attribute name="extraHeadContent">
        <!-- Nơi để khai báo page level css, theme, style -->
    </jsp:attribute>        
    <jsp:attribute name="extraBottomContent">
    </jsp:attribute>
    <jsp:attribute name="extraNavigationContent">
        <c:set var="acc" value="${sessionScope.ACCOUNT}"/>
        <c:if test="${not empty acc}">
            <c:if test="${acc.role == 'member'}">
                <li id="nofi">
                    <a href="#">
                        <i class="icon-bell"></i>
                        <span class="badge badge-default">3</span>           
                    </a>
                    <ul class="fallback">
                        <li style="margin-left: -40px"><a href="ProcessServlet?action=manage">Manage Product Status</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 2</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 3</a></li>
                        <li style="margin-left: -40px"><a href="#">notification 4</a></li>
                    </ul>
                </li>
            </c:if>
        </c:if>
    </jsp:attribute>
    <jsp:body>  
        <div id="wrapper_manage">
            <!-- BEGIN SIDEBAR & CONTENT -->
            <div class="row margin-bottom-40" style="background-color: white;padding: 10px">
                <h2>Quản lí Tài Khoản</h2>
                <a data-toggle="modal" data-target="#addAccountModel"  style="margin-bottom: 20px;float: right" class="btn btn-primary">Thêm tài khoản</a>
                <c:set var="accounts" value="${requestScope.DATA}"/>                
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr style="background-color: #e1f5fe ">
                            <th>STT</th>
                            <th>Tên đăng nhập</th>
                            <th>Status</th>
                            <th>Tên</th>
                            <th>Địa chỉ</th>
                            <th>Điện thoại</th>
                            <th>Email</th>
                            <th>Tài khoản Paypal</th>
                            <th>Role</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty accounts}">
                            <c:forEach var="account" items="${accounts}" varStatus="counter">
                                <tr style="background-color: white">
                                    <td>${counter.count}</td>
                                    <td>${account.accountID}</td> 
                                    <td>${account.status}</td>
                                    <td>${account.fullName}</td>
                                    <td>${account.address}</td>
                                    <td>${account.phone}</td>
                                    <td>${account.email}</td>
                                    <td>${account.paypalAccount}</td>
                                    <td>${account.role}</td>    
                                    <td><a data-account ="${account.accountID}" data-email="${account.email}" data-paypal ="${account.paypalAccount}" data-phone ="${account.phone}" data-address ="${account.address}" data-name ="${account.fullName}" data-toggle="modal" data-target="#EditAccountModel" class="btn btn-info editAccount">Sửa</a></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="addAccountModel" class="modal face bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h1 class="text-center">Thêm Tài Khoản</h1>
                    </div>
                    <div style="margin-bottom: 50px" class="modal-body">
                        <div class="row">
                            <form class="form-horizontal form-without-legend" action="AddAccountServlet" method="GET">                       
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-lg-2"> Tên đăng nhập:<span class="require">*</span> </label>
                                    <div class="col-md-3 col-lg-3">
                                        <input class="form-control" required="true" name="accountID" type="text">
                                    </div>
                                    <label class="control-label col-md-2 col-lg-2"> Mật Khẩu: <span class="require">*</span></label>
                                    <div class="col-md-3 col-lg-3">
                                        <input class="form-control" required="true" name="password" type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-lg-2"> Điện thoại: </label>
                                    <div class="col-md-3 col-lg-3">
                                        <input class="form-control" name="phone" type="text">
                                    </div>
                                    <label class="control-label col-md-2 col-lg-2"> Email: </label>
                                    <div class="col-md-4 col-lg-4">
                                        <input class="form-control" name="email" type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-lg-2"> Tên: </label>
                                    <div class="col-md-3 col-lg-3">
                                        <input class="form-control" name="fullName" type="text">
                                    </div>
                                    <label class="control-label col-md-2 col-lg-2"> Địa chỉ: </label>
                                    <div class="col-lg-4 col-md-4">
                                        <textarea  rows="3" name="address" type="text" class="form-control"></textarea>
                                    </div>
                                </div>   
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-lg-2"> Tài khoản PayPal: </label>
                                    <div class="col-md-3 col-lg-3">
                                        <input class="form-control" name="paypalAccount" type="text">
                                    </div>
                                    <label class="control-label col-md-2 col-lg-2"> Role:  <span class="require">*</span></label>
                                    <div class="col-md-4 col-lg-4">
                                        <select required="true" name="role" class="form-control">
                                            <option value="storeOwner">storeOwner</option>
                                            <option value="member">member</option>
                                        </select>
                                    </div>
                                </div>
                                <button style="float: right;margin-right: 50px;margin-top: 20px" class="btn btn-primary" type="submit">Thêm</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="EditAccountModel" class="modal face bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h1 class="text-center">Sửa Tài Khoản</h1>
                    </div>
                    <div style="margin-bottom: 50px" class="modal-body">
                        <div class="row">
                            <form class="form-horizontal form-without-legend" action="EditAccountServlet" method="POST">                       
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-lg-2"> Điện thoại: </label>
                                    <div class="col-md-3 col-lg-3">
                                        <input name="accountID" id="aAccount" type="hidden"/>
                                        <input id="aPhone" class="form-control" name="phone" type="text">
                                    </div>
                                    <label class="control-label col-md-2 col-lg-2"> Email: </label>
                                    <div class="col-md-4 col-lg-4">
                                        <input id="aEmail" class="form-control" name="email" type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-lg-2"> Tên: </label>
                                    <div class="col-md-3 col-lg-3">
                                        <input id="aName" class="form-control" name="fullName" type="text">
                                    </div>
                                    <label class="control-label col-md-2 col-lg-2"> Địa chỉ: </label>
                                    <div class="col-lg-4 col-md-4">
                                        <textarea id="aAddress"  rows="3" name="address" type="text" class="form-control"></textarea>
                                    </div>
                                </div>   
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-lg-2"> Tài khoản PayPal: </label>
                                    <div class="col-md-3 col-lg-3">
                                        <input id="aPaypal" class="form-control" name="paypalAccount" type="text">
                                    </div>
                                </div>
                                <button style="float: right;margin-right: 50px;margin-top: 20px" class="btn btn-primary" type="submit">Sửa</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</template:shopbasic>
<script>
    $(document).on("click", ".editAccount", function () {
        $('#aPhone').val($(this).data('phone'));
        $('#aEmail').val($(this).data('email'));
        $('#aName').val($(this).data('name'));
        $('#aAddress').val($(this).data('address'));
        $('#aPaypal').val($(this).data('paypal'));
        $('#aAccount').val($(this).data('account'));
    });
</script>
