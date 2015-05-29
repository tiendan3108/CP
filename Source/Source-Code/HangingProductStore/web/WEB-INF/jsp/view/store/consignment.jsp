<template:storebasic htmlTitle="Consignment Request" bodyTitle="Consignment Request">
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
            <h4>Request List</h4>
            <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
                <thead>
                    <tr role="row" class="heading">
                        <th width="20%">
                            Product
                        </th>
                        <th>
                            Request Date
                        </th>
                        <th>
                            Consign Price
                        </th>
                        <th>
                            Transfer Date
                        </th>
                        <th>
                            Actions
                        </th>
                    </tr>
                    <tr role="row" class="filter">
                        <td>
                            <input type="text" class="form-control form-filter input-sm">
                        </td>
                        <td>
                            <div class="input-group date date-picker margin-bottom-5" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_from" placeholder="From">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                            <div class="input-group date date-picker" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_to" placeholder="To">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </td>
                        <td>
                            <div class="margin-bottom-5">
                                <input type="text" class="form-control form-filter input-sm margin-bottom-5 clearfix" name="order_quantity_from" placeholder="From" />
                            </div>
                            <input type="text" class="form-control form-filter input-sm" name="order_quantity_to" placeholder="To" />
                        </td>
                        <td>
                            <div class="input-group date date-picker margin-bottom-5" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_from" placeholder="From">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                            <div class="input-group date date-picker" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control form-filter input-sm" readonly name="order_date_to" placeholder="To">
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
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
                            Casio Watch
                        </td>
                        <td>
                            May 21, 2015
                        </td>
                        <td>
                            $12,000
                        </td>
                        <td>
                            May 25, 2015
                        </td>
                        <td>
                            <a href="./consignor?id=11" class="btn btn-primary">View</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Casio Watch Gold
                        </td>
                        <td>
                            May 11, 2015
                        </td>
                        <td>
                            $14,000
                        </td>
                        <td>
                            May 22, 2015
                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Channel Handbag
                        </td>
                        <td>
                            May 10, 2015
                        </td>
                        <td>
                            Wait for evaluation
                        </td>
                        <td>
                            today
                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Calvin Klein Belt
                        </td>
                        <td>
                            May 09, 2015
                        </td>
                        <td>
                            $13,000
                        </td>
                        <td>
                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Nike Shoes
                        </td>
                        <td>
                            May 09, 2015
                        </td>
                        <td>
                            $22,000
                        </td>
                        <td>
                        </td>
                        <td>
                            <button type="button" class="btn btn-link">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Gucci Sunglasses
                        </td>
                        <td>
                            May 09, 2015
                        </td>
                        <td>
                            Wait for evaluation
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