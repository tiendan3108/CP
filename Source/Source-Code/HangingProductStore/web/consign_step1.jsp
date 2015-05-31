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
        <form  action="ConsignServlet" method="POST" >
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

                                    <div>
                                        <div class="tab-content">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-horizontal">
                                                        <div class="form-group">
                                                            <label for="txtProductName" class="col-sm-4 control-label">Product name<span class="required">*</span></label>
                                                            <div class="col-sm-8">
                                                                <input  name="txtProductName" type="text" class="form-control" maxlength="50" value="">
                                                                <p class="help-block" id="erProductName"> </p>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="txtSerial" class="col-sm-4 control-label"> Serial number </label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" name="txtSerialNumber" value="${sessionScope.SERIAL}">
                                                                <p class="help-block" id="erSerialNumber"> </p>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Purchased date<span class="required">*</span></label>
                                                            <div class="col-sm-8">
                                                                <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="0d">
                                                                    <input type="text" class="form-control" name="txtDate" readonly>
                                                                    <span class="input-group-btn">
                                                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>
                                                                <span class="help-block" id="erDate"> </span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Category<span class="required">*</span></label>
                                                            <div class="col-sm-8">
                                                                <select name="txtCategory" class="bs-select form-control" >
                                                                    <option value='' disabled selected style='display:none;'>Select...</option>
                                                                    <option value="1">Shirt</option>
                                                                    <option value="2">Pants</option>
                                                                    <option value="3">Hat</option>
                                                                    <option value="4">Shoes</option>
                                                                    <option value="5">Glasses</option>
                                                                </select>

                                                                <span class="help-block" id="erCategory">
                                                                </span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-4">Brand</label>
                                                            <div class="col-sm-8">
                                                                <input  name="txtBrand" type="text" class="form-control" maxlength="50">

                                                                <span class="help-block" id="erBrand">
                                                                </span>
                                                            </div>
                                                        </div>



                                                        <div class="form-group">
                                                            <label for="txtDescription" class="col-sm-4 control-label"> Description </label>
                                                            <div class="col-sm-8">
                                                                <textarea name="txtDescription" class="form-control" maxlength="225" rows="6" placeholder="This textarea has a limit of 225 chars."></textarea>
                                                                <span class="help-block" id="erDescription">
                                                                </span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="col-sm-6">
                                                    <div class="row">

                                                        <div class="form-group last">
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
                                                                            <span class="fileinput-new btn">
                                                                                SELECT IMAGE </span>
                                                                            <span class="fileinput-exists btn">
                                                                                Change </span>
                                                                            <input  type="file" name="txtImage">
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



</script>
