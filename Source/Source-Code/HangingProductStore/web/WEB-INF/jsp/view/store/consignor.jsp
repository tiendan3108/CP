<template:storebasic htmlTitle="Consignor List" bodyTitle="Consignor List">
    <!-- BEGIN SIDEBAR & CONTENT -->
    <div class="row margin-bottom-40 ">
        <!-- BEGIN SIDEBAR -->
        <div class="sidebar col-md-3 col-sm-4">
            <ul class="list-group margin-bottom-25 sidebar-menu">
                <li class="list-group-item clearfix">
                    <a href="./consignment?search"><i class="fa fa-angle-right"></i> Advance Search</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignment"><i class="fa fa-angle-right"></i> Request List</a>
                </li>
                <li class="list-group-item clearfix">
                    <a href="./consignor"><i class="fa fa-angle-right"></i> Consignor List</a>
                </li>
            </ul>
        </div>
        <!-- END SIDEBAR -->
        <div class="col-md-9">
            <h4>Consignor List</h4>
            <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
                <thead>
                    <tr role="row" class="heading">
                        <th width="20%">
                            Name
                        </th>
                        <th>
                            Address
                        </th>
                        <th>
                            Phone
                        </th>
                        <th>
                            Email
                        </th>
                        <th>
                            Request List
                        </th>
                    </tr>
                    <tr role="row" class="filter">
                        <td>
                            <input type="text" class="form-control form-filter input-sm" name="order_customer_name">
                        </td>
                        <td>
                            <input type="text" class="form-control form-filter input-sm">
                        </td>
                        <td>
                            <input type="text" class="form-control form-filter input-sm">
                        </td>
                        <td>
                            <input type="text" class="form-control form-filter input-sm">
                        </td>
                        <td>
                            <div class="margin-bottom-5">
                                <button class="btn btn-sm yellow filter-submit margin-bottom"><i class="fa fa-search"></i> Search</button>
                            </div>
                            <button class="btn btn-sm red filter-cancel"><i class="fa fa-times"></i> Reset</button>
                        </td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            Yến
                        </td>
                        <td>
                            130 Trần Quang Khải, P. Tân Định, Quận 1, TPHCM
                        </td>
                        <td>
                            0903409192
                        </td>
                        <td>

                        </td>
                        <td>
                            <a href="./store_owner_consignment_detail.html" class="btn btn-primary">View</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Lê Thị Minh Luân
                        </td>
                        <td>
                            424 Hùng Vương, Hội An
                        </td>
                        <td>
                            0905223659
                        </td>
                        <td>

                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Hùng
                        </td>
                        <td>
                            TP.HCM
                        </td>
                        <td>
                            08123456
                        </td>
                        <td>

                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Quang Thong
                        </td>
                        <td>

                        </td>
                        <td>
                            0933678686
                        </td>
                        <td>
                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Hương
                        </td>
                        <td>

                        </td>
                        <td>
                            12395222
                        </td>
                        <td>
                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            An
                        </td>
                        <td>

                        </td>
                        <td>
                            098445334
                        </td>
                        <td>
                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->
</template:storebasic>