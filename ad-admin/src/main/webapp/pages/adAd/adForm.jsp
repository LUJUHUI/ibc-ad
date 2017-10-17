<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

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
            <fmt:message key="ad.ad"/>
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
            <label class="control-label" for="code">内容标识</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="code">

            <label class="control-label" for="attr">节目类型</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="attr">
                <option value="">全部</option>
                <option value="1">单片</option>
                <option value="2">剧集</option>
            </select>

            <label class="control-label" for="title">标题</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="title">

            <label class="control-label" for="searchName">搜索名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="searchName">

            <label class="control-label" for="status">节目状态</label>
            <select class="form-control input-sm" id="status" style="margin-left: 5px;">
                <option value="">全部</option>
                <c:forEach var="status" items="${pubStatus}">
                    <option value="${status.key}">${status.value}</option>
                </c:forEach>
            </select>

            <label class="control-label" for="pcId">一级栏目</label>
            <select class="form-control input-sm" id="pcId" style="margin-left: 5px;">
                <option value="">全部</option>
                <c:forEach var="pcId" items="${pcIds}">
                    <option value="${pcId.key}">${pcId.value.name}</option>
                </c:forEach>
            </select>

            <label class="control-label" for="status">二级栏目</label>
            <select class="form-control input-sm" id="cId" style="margin-left: 5px;min-width: 80px;" disabled>
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
            url: "<c:url value='/json/adad_getAd.do'/>",
            postData: {
                code: $("#code").val(),
                attr: $("#attr").val(),
                title: $("#title").val(),
                searchName: $("#searchName").val(),
                status: $("#status").val(),
                pcId: $("#pcId").val(),
                cId: $("#cId").val(),
                beginDate: startDate,
                endDate: endDate
            },
            height: 560,
            colNames:[
                '<fmt:message key="ad.ad.id"/>',
                '<fmt:message key="ad.ad.name"/>',
                '<fmt:message key="ad.ad.status"/>',
                '<fmt:message key="ad.ad.remark"/>',
                '<fmt:message key="ad.ad.startTime"/>',
                '<fmt:message key="ad.ad.endTime"/>',
                '<fmt:message key="ad.ad.createTime"/>',
                '<fmt:message key="ad.ad.createId"/>',
                '<fmt:message key="ad.ad.updateTime"/>',
                '<fmt:message key="ad.ad.updateId"/>'
            ],
            colModel:[
                {name:'id',index:'id', width : 80,align:'center', sortable : true},
                {name: 'adName',index: 'adName', width : 200, align:'center', sortable : true},
                {name : 'status', index : 'status', width : 80, align:'center', sortable : false,formatter:statusFmt},
                {name : 'remark', index : 'remark', width : 280, align:'center', sortable : true},
                {name : 'startTime', index : 'startTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'endTime', index : 'endTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createTime', index : 'createTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createId', index : 'createId', width : 100, align:'center', sortable : true},
                {name : 'updateTime', index : 'updateTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'updateId', index : 'updateId', width : 100, align:'center', sortable : true},
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
            caption: '<fmt:message key="ad.ad.list" />',
            <cas:havePerm url="/bestvContent_loadDetailPage.do">
                ondblClickRow : function (rowid, iRow, iCol, e) {
                    openMainPage('<c:url value="/pages/contentShow/bestvContentDetail.jsp"/>', {"id": rowid}, function () {
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

        function statusFmt(cellvalue, options, rowObject){
            var result="";
            switch (cellvalue){
                case 101:
                    result='草稿';
                case 102:
                    result = '待投放';
                case 103:
                    result = '投放中';
                case 104:
                    result = '投放完成';
                case 105:
                    result = '已删除';
            }
            return result;
        }

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
                url : "<c:url value='/json/bestvContent_beanList.do'/>",
                postData : {
                    code: $("#code").val(),
                    attr: $("#attr").val(),
                    title: $("#title").val(),
                    searchName: $("#searchName").val(),
                    status: $("#status").val(),
                    pcId: $("#pcId").val(),
                    cId: $("#cId").val(),
                    beginDate: startDate,
                    endDate: endDate
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })
        
        $("#pcId").on("change", function () {
            if ($("#pcId").val() == ""){
                $("#cId").html('').attr("disabled", true);
            }else {
                $.get('<c:url value="/json/bestvContent_cascade.do"/>', {"pcId": $("#pcId").val()}, function (data) {
                    var optionHtml = '<option value="">全部</option>';
                    for (var i in data.result){
                        optionHtml = optionHtml + '<option value="'+ i +'">' + data.result[i] + '</option>';
                    }
                    $("#cId").html(optionHtml).removeAttr("disabled");
                })
            }
        })

        $("#online, #offline").on("click", onOrOffLine);

        function onOrOffLine(){
            var actionType = $(this).attr("id") == 'online' ? '1' : '2';//上线为1，下线为2
            var status1;//上线为102，下线为105
            var status2;//上线为200，下线为107
            if (actionType == '1'){
                status1 = '102';
                status2 = '105';
            }else {
                status1 = '200';
                status2 = '107';
            }
            var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var codes = [];
            for (var index in ids){
                var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
                if (rowData.status == status1 || rowData.status == status2)
                    continue;
                codes.push(rowData.code);
            }
            if (codes.length < 1){
                bootbox.alert("没有选择有效记录！");
                return;
            }
            var codeStr = '';
            for (var index in codes){
                codeStr =codeStr + codes[index] + ',';
            }
            $.post('<c:url value="/json/bestvContent_onOrOffLine.do"/>', {"codes": codeStr.substring(0, codeStr.length-1), "actionType": actionType}, function (result) {
                bootbox.alert("操作成功！");
                $("#search").trigger('click');
            });
        }
    });
</script>