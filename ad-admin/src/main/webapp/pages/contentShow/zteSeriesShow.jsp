<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<%@page import="com.wondertek.mobilevideo.bc.BcConstants"%>
<%@ page import="com.wondertek.mobilevideo.bc.core.model.DataDict" %>

<%
    pageContext.setAttribute("pubStatus", BcConstants.DATA_DICT_CACHE.get(DataDict.ZTE_PUB_STATE_TYPE).entrySet());
%>

<div class="breadcrumbs" id="breadcrumbs">
    <script type="text/javascript">
        try {
            ace.settings.check('breadcrumbs', 'fixed')
        } catch (e) {
        }
    </script>
    <ul class="breadcrumb">
        <li><i class="ace-icon fa fa-home home-icon"></i>
            <a href=""><fmt:message key="webapp.home"/></a>
        </li>
        <li>
            <fmt:message key="content.show"/>
        </li>
        <li class="">
            <span><fmt:message key="zte.content.show"/></span>
        </li>
        <li class="active">
            <span><fmt:message key="zte.series.show"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
</div>

<style type="text/css">
    .ui-jqgrid .ui-jqgrid-bdiv {
        overflow: auto;
    }
    .ui-jqgrid .ui-userdata {
        border-left: 1px solid #D3D3D3;
        border-right: 1px solid #D3D3D3;
        height: 44px;
        overflow: hidden;
    }
    .ui-jqgrid .topnavtable td {
        font-weight: 400;
        vertical-align: middle;
        padding: 0 8px;
    }
</style>

<div class="page-content">
    <div class="page-header">
        <form class="form-inline">
            <label class="control-label" for="code">节目标识</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="code">

            <label class="control-label" for="code">节目名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="name">

            <label class="control-label" for="searchName">搜索名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="searchName">

            <label class="control-label" for="orderNumber">订购编号</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="orderNumber">

            <label class="control-label" for="action">动作</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="action">
                <option value="">全部</option>
                <option value="regist">注册</option>
                <option value="update">更新</option>
                <option value="delete">删除</option>
            </select>

            <label class="control-label" for="status">节目状态</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="status">
                <option value="">全部</option>
                <option value="0">失效</option>
                <option value="1">生效</option>
            </select>

            <label class="control-label" for="createTime">创建时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>

            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
            </button>
        </form>
    </div>
    <!-- /.page-header -->
    <div class="row">
        <div class="col-xs-12">
            <table id="grid-table"></table>
            <div id="grid-pager"></div>
        </div>
    </div>
    <!-- /.row -->
</div>

<script type="text/javascript">

    jQuery(function($) {
        var grid_selector = "#grid-table";
        var pager_selector = "#grid-pager";

        var parent_column = $(grid_selector).closest('[class*="col-"]');
        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function() {
                    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
                }, 20);
            }
        })

        $('#createTime').daterangepicker({
            "ableToNull": true,
            "showDropdowns":true,
            "showCustomRangeLabel":false,
            "alwaysShowCalendars": true,
            "startDate": moment().subtract('days', 30),
            "endDate": moment().subtract('days', 0),
            "opens": "left",
            "drops": "down"
        }, function(start, end, label) {//时间改变后执行该方法
            //alert(label);
        });

        var dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
        var startDate = dateRange[0];
        var endDate = dateRange[1];

        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/zteSeries_list.do'/>",
            postData: {
                code: $("#code").val(),
                name: $("#name").val(),
                orderNumber: $("#orderNumber").val(),
                searchName: $("#searchName").val(),
                action: $("#action").val(),
                status: $("#status").val(),
                beginDate: startDate,
                endDate: endDate
            },
            height: 560,
            colNames:['ID',
                '<fmt:message key="zte.content.code"/>',
                '<fmt:message key="zte.content.action"/>',
                '<fmt:message key="zte.content.name"/>',
                '<fmt:message key="zte.content.originalName"/>',
                '<fmt:message key="zte.content.orderNumber"/>',
                '<fmt:message key="zte.content.type"/>',
                '<fmt:message key="zte.content.volumnCount"/>',
                '<fmt:message key="zte.content.keyWords"/>',
                '<fmt:message key="zte.content.status"/>',
                '<fmt:message key="zte.content.price"/>',
                '<fmt:message key="zte.content.macrovision"/>',
                '<fmt:message key="zte.content.orgAirDate"/>',
                '<fmt:message key="zte.content.categoryName"/>',
                '<fmt:message key="zte.content.bcStatus"/>',
                '<fmt:message key="zte.content.createTime"/>',
                '<fmt:message key="zte.content.updateTime"/>'
            ],
            colModel:[
                {name:'series.id',index:'id', width : 100, hidden:true},
                {name : 'series.code', index : 'code_', width : 120, align:'center', sortable : false},
                {name : 'series.action', index : 'action_', width : 120, align:'center', sortable : false},
                {name : 'series.name', index : 'name_', width : 250, align:'center', sortable : false},
                {name : 'series.originalName', index : 'original_name', width : 250, align:'center', sortable : false},
                {name : 'series.orderNumber', index : 'order_number', width : 120, align:'center', sortable : false},
                {name : 'series.type', index : 'type_', width : 200, align:'center', sortable : false},
                {name : 'series.volumnCount', index : 'volumn_count', width : 150, align:'center', sortable : false},
                {name : 'series.keyWords', index : 'key_words', width : 100, align:'center', sortable : false},
                {name : 'series.statusStr', index : 'status_', width : 100, align:'center', sortable : false},
                {name : 'series.price', index : 'price_', width : 100, align:'center', sortable : false},
                {name : 'series.macrovisionStr', index : 'macrovision_', width : 120, align:'center', sortable : false},
                {name : 'series.orgAirDate', index : 'org_air_date', width : 200, align:'center', sortable : false},
                {name : 'category.categoryName', index : 'category_name', width : 100, align:'center', sortable : false},
                {name : 'series.bestvStatusStr', index : 'bestv_status', width : 100, align:'center', sortable : false},
                {name : 'series.createTime', index : 'create_time', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'series.updateTime', index : 'update_time', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}}
            ],
            shrinkToFit : false,
            hidegrid : false,
            viewrecords : true,
            rowNum:20,
            rowList:[10,20,30],
            pager : pager_selector,
            altRows : true,
            multiselect: true,
            multiboxonly: true,
            jsonReader : {
                total : 'pageCount',
                records : 'records',
                root : 'rows',
                repeatitems : true
            },
            caption: '<fmt:message key="zte.series.list" />',
            <cas:havePerm url="/pages/contentShow/zteMovieDetail.jsp">
            ondblClickRow : function (rowid, iRow, iCol, e) {
                var code = $(grid_selector).getRowData(rowid)["series.code"];
                openMainPage("/pages/contentShow/zteSeriesDetail.jsp", {"code": code}, function () {
                });
            },
            </cas:havePerm>
            toolbar: [true,'top'],
            loadComplete : function(data) {
                var table = this;
                setTimeout(function(){
                    styleCheckbox(table);

                    updateActionIcons(table);
                    updatePagerIcons(table);
                    enableTooltips(table);
                }, 0);
            }

        });

        $("#t_grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
            '<td><button type="button" id="online" class="btn btn-xs btn-success"><i class="ace-icon fa fa-cloud-upload"></i>上线</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="offline" class="btn btn-xs btn-danger"><i class="ace-icon fa fa-cloud-download"></i>下线</button></td>' +
            '</tr></table>');

        $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        //navButtons
        jQuery(grid_selector).jqGrid('navGrid',pager_selector,
            { 	//navbar options
                edit: false,
                editicon : 'ace-icon fa fa-pencil blue',
                add: false,
                addicon : 'ace-icon fa fa-plus-circle purple',
                del: false,
                delicon : 'ace-icon fa fa-trash-o red',
                search: false,
                searchicon : 'ace-icon fa fa-search orange',
                refresh: true,
                refreshicon : 'ace-icon fa fa-refresh green',
                view: false,
                viewicon : 'ace-icon fa fa-search-plus grey',
            }
        )

        function styleCheckbox(table) {
        }

        function updateActionIcons(table) {
        }

        //replace icons with FontAwesome icons like above
        function updatePagerIcons(table) {
            var replacement =
                {
                    'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
                    'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
                    'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
                    'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
                };
            $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
                var icon = $(this);
                var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

                if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
            })
        }

        function enableTooltips(table) {
            $('.navtable .ui-pg-button').tooltip({container:'body'});
            $(table).find('.ui-pg-div').tooltip({container:'body'});
        }

        $(document).one('ajaxloadstart.page', function(e) {
            $.jgrid.gridDestroy(grid_selector);
            $('.ui-jqdialog').remove();
        });

        $("#search").on("click", function () {

            if($('#createTime').val() == ""){
                startDate = "";
                endDate = "";
            } else{
                dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
                startDate = dateRange[0];
                endDate = dateRange[1];
            }

            $("#grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/zteSeries_list.do'/>",
                postData : {
                    code: $("#code").val(),
                    name: $("#name").val(),
                    orderNumber: $("#orderNumber").val(),
                    searchName: $("#searchName").val(),
                    action: $("#action").val(),
                    status: $("#status").val(),
                    beginDate: startDate,
                    endDate: endDate
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })

        $("#online, #offline").on("click", onOrOffLine);

        function onOrOffLine(){
            var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }

            var actionType = $(this).attr("id") == 'online' ? "1" : "2";//上线为1，下线为2
            var codes = [];

            for (var index in ids){
                var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
                codes.push(rowData["series.code"]);
            }

            var codeStr = '';
            for (var index in codes){
                codeStr =codeStr + codes[index] + ',';
            }
            $.post('<c:url value="/json/zteSeries_onOrOffLine.do"/>', {"codes": codeStr.substring(0, codeStr.length-1), "actionType": actionType}, function (result) {
                bootbox.alert("操作成功！");
                $("#search").trigger('click');
            });
        }
    });
</script>
