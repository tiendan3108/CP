<%-- 
    Document   : consign_step1
    Created on : May 30, 2015, 9:34:04 PM
    Author     : Robingios
--%>

<template:consignbasic htmlTitle="Consign" bodyTitle="">
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


        <!-- BEGIN PAGE CONTENT-->
        <!-- BEGIN DIV STEP1 -->
        <form  action="ConsignServlet" method="POST" onsubmit="return validation()" >
            <div class="row">

                <div class="portlet box" id="form_wizard_1">

                    <div class="portlet-body form">
                        <div class="form-horizontal" id="submit_form">
                            <div class="form-wizard">
                                <div class="form-body">
                                    <ul class="nav nav-pills nav-justified steps">
                                        <li class="active">
                                            <a  class="step">
                                                <span class="number">
                                                    1 </span>
                                                <span class="desc" >
                                                    <i class="fa fa-check"></i> <b style="font-size:125%">Product's info </b></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="step">
                                                <span class="number">
                                                    2 </span>
                                                <span class="desc" style="font-size:125%">
                                                    <i class="fa fa-check"></i>  Choose store </span>
                                            </a>
                                        </li>
                                        <li >
                                            <a class="step">
                                                <span class="number">
                                                    3 </span>
                                                <span class="desc" style="font-size:125%">
                                                    <i class="fa fa-check"></i> Personal info </span>
                                            </a>
                                        </li>
                                    </ul>

                                    <hr/>

                                    <c:set var="product" value="${sessionScope.PRODUCT}" />
                                    <div>
                                        <div class="tab-content">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label for="txtProductName" class="col-sm-4 control-label">Product name<span class="required">*</span></label>
                                                            <div class="col-sm-8">
                                                                <input id="txtProductName"  name="txtProductName" type="text" class="form-control" maxlength="50" value="${product.name}"/>
                                                                <p class="help-block" id="erProductName">  </p>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="txtSerial" class="col-sm-4 control-label"> Serial number </label>
                                                            <div class="col-sm-8">
                                                                <input id="txtSerialNumber" type="text" class="form-control" name="txtSerialNumber" value="${product.serialNumber}"/>
                                                                <p class="help-block" id="erSerialNumber"> </p>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Purchased date<span class="required">*</span></label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="0d">
                                                                    <input id="txtDate" type="text" class="form-control" name="txtDate" readonly value="${product.purchasedDate}">
                                                                    <span class="input-group-btn">
                                                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>
                                                                <span class="help-block" id="erDate"> </span>
                                                            </div>
                                                        </div>

                                                        <c:set var="fCate" value="${sessionScope.FCATE}" />
                                                        <c:set var="category" value="${sessionScope.CATEGORY}" />

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Category<span class="required">*</span></label>
                                                            <div class="col-sm-8">
                                                                <select id="txtCategory" name="txtCategory" class="bs-select form-control" >
                                                                    <option value='' disabled selected style='display:none;'>Select...</option>

                                                                    <c:forEach var="father" items="${fCate}">
                                                                        <optgroup label="${father.categoryName}">
                                                                            <c:forEach var="child" items="${category}">
                                                                                <c:if test="${child.parentId == father.categoryId}">
                                                                                    <c:if test="${child.categoryId == product.categoryID}">
                                                                                        <option value="${child.categoryId}" selected>${child.categoryName}</option>
                                                                                    </c:if>
                                                                                    <c:if test="${child.categoryId != product.categoryID}">
                                                                                        <option value="${child.categoryId}">${child.categoryName}</option>
                                                                                    </c:if>



                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </optgroup>

                                                                    </c:forEach>

                                                                </select>

                                                                <span class="help-block" id="erCategory">
                                                                </span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Brand</label>
                                                            <div class="col-sm-8">
                                                                <input id="txtBrand" name="txtBrand" type="text" class="form-control" maxlength="50" value="${product.brand}"/>

                                                                <span class="help-block" id="erBrand">
                                                                </span>
                                                            </div>
                                                        </div>



                                                        <div class="form-group">
                                                            <label  class="col-sm-4 control-label"> Description </label>
                                                            <div class="col-sm-8">
                                                                <textarea id="txtDescription" name="txtDescription" class="form-control" maxlength="225" rows="6" placeholder="" value="${product.description}"/>${product.description}</textarea>
                                                                <span class="help-block" id="erDescription">
                                                                </span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">

                                                        <div class="form-group">
                                                            <label class="control-label col-md-3">Image <span class="required">* </span></label>
                                                            <div class="col-md-9">
                                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                    <div class="fileinput-new thumbnail" style="width: 250px; height: 200px;">
                                                                        <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDI0MiAyMDAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjxkZWZzLz48cmVjdCB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9IjkzIiB5PSIxMDAiIHN0eWxlPSJmaWxsOiNBQUFBQUE7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6MTFwdDtkb21pbmFudC1iYXNlbGluZTpjZW50cmFsIj4yNDJ4MjAwPC90ZXh0PjwvZz48L3N2Zz4=" alt=""/>
                                                                    </div>
                                                                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 250px; max-height: 200px;">
                                                                    </div>
                                                                    <div>
                                                                        <span class="btn btn-info btn-file">
                                                                            <span class="fileinput-new btn" >
                                                                                SELECT IMAGE </span>
                                                                            <span class="fileinput-exists btn">
                                                                                Change </span>
                                                                            <input  type="file" id="txtImage" name="txtImage" id="txtImage" value="${product.image}">
                                                                        </span>
                                                                        <a href="#" class="btn btn-lg red fileinput-exists" data-dismiss="fileinput">
                                                                            Remove </a>
                                                                    </div>
                                                                </div>
                                                                <span class="help-block" id="erImage">
                                                                </span>
                                                            </div>
                                                        </div>

                                                    </div>


                                                </div> 
                                            </div>


                                        </div>

                                    </div>
                                </div>
                                <div class="form-actions" style="
                                     padding-top: 5px;
                                     padding-bottom: 5px;
                                     padding-right: 5px;
                                     padding-left: 5px;
                                     ">
                                    <div class="row">
                                        <div class="col-sm-8"> 

                                        </div>

                                        <div class="col-sm-4">
                                            <button  name="btnAction" value="tostep2" type="submit" class="btn-block btn-lg btn btn-primary" >NEXT <i class="m-icon-big-swapright m-icon-white"></i></button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </form>
        <!-- END DIV STEP1 -->



    </jsp:body>
</template:consignbasic>
<script type="text/javascript">
    var RecaptchaOptions = {
        theme: 'custom',
        custom_theme_widget: 'recaptcha_widget'
    };


    function validation() {
        var check = true;
        if($('#txtProductName').val().trim().length < 5 || $('#txtProductName').val().trim().length > 50){
            $('#erProductName').html("<font color='red'>Required 5-50 characters</font>");
            check = false;
        }
        else{
            $('#erProductName').html("");
        }
        if($('#txtCategory').val() == null){
            $('#erCategory').html("<font color='red'>Please choose a category</font>");
            check = false;
        }else{
            $('#erCategory').html("");
        }
        
        return check;
    }

</script>
