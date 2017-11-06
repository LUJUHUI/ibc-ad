<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<%
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String status = request.getParameter("status");
    request.setAttribute("type",type);
    request.setAttribute("id", id);
    request.setAttribute("status", status);
%>

<style>
    .form-horizontal .control-label {
        text-align: right;
        margin-bottom: 0;
        padding-top: 3px;
    }
    .preview-container {
        margin-left: 30px;
        background-color: #D0D0D0;
        box-shadow: 0 0 3px #000;
        width: auto;
        height: 430px;
        display: none;
    }
    .preview-container-active {
        display: block;
    }
    .img-class {
        width: 100%;
        height: 100%;
    }
</style>

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
        <li class="">
            <span><fmt:message key="ad.ad.addMaterial"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
    <div class="nav-search">
        <button type="button" class="btn btn-danger btn-sm" id="backBtn">
            <i class="ace-icon fa fa-reply"></i><fmt:message key="button.back"/>
        </button>
    </div>
</div>

<input type="text" hidden value="${id}" id="adId"/>
<div class="page-content">
    <div class="page-header">
        <form class="form-inline" id="add_material_form">
            <label class="control-label" for="materialName">素材名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="materialName">
            
            <label class="control-label" for="type">素材类型</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="type">
                <option value="">全部</option>
                <option value="1">图片</option>
                <option value="2">文字</option>
            </select>
            
            <label class="control-label" for="status">素材状态</label>
            <select class="form-control input-sm" id="status" style="margin-left: 5px;">
                <option value="">全部</option>
                <option value="101">待审核</option>
                <option value="102">审核成功</option>
                <option value="103">审核失败</option>
                <option value="104">已删除</option>
                <option value="105">已使用</option>
                <c:forEach var="status" items="${pubStatus}">
                    <option value="${status.key}">${status.value}</option>
                </c:forEach>
            </select>
            
            <label class="control-label" for="createTime">创建时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>
            
            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="add_mater_search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
            </button>
            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="add_mater_reset">
                <i class="ace-icon fa fa-reply bigger-110"></i><fmt:message key="icon-reset"/>
            </button>
        </form>
    </div>
    <!-- /.page-header -->
    <div class="row">
        <div class="col-xs-12">
            <table id="ad-add-material-grid-table"></table>
            <div id="ad-add-material-grid-pager"></div>
        </div>
    </div>
    <!-- /.row -->


</div>


<script type="text/javascript">

    jQuery(function($) {
        var type = "${type}";
        $("#backBtn").on("click", function () {
            $("#main_page > div:last").remove();
            $("#main_page > div:last").removeClass("main-page-div-display");
            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
        })
        
        var grid_selector = "#ad-add-material-grid-table";
        var pager_selector = "#ad-add-material-grid-pager";

        var parent_column = $(grid_selector).closest('[class*="col-"]');
        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
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
            "opens": "right",
            "drops": "down"
        }, function(start, end, label) {//时间改变后执行该方法
            //alert(label);
        });
        var startTime = $('#createTime').val().replace(/\s/g, "").split("至");
        var startDate = startTime[0];
        var endDate = startTime[1];

        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/adad_getAdMaterialByPage.do'/>",
            postData: {
                querytype:type,
                status:$("#status").val(),
                adName:$("#adName").val(),
                adId:$("#adId").val(),
                createTime: startDate +" 00:00:00",
                createTime_end: endDate+" 23:59:59"
            },
            height: 520,
            colNames:[
                '<fmt:message key="ad.material.id"/>',
                '<fmt:message key="ad.material.materialName"/>',
                '<fmt:message key="ad.material.type"/>',
                '<fmt:message key="ad.material.clickHref"/>',
                '<fmt:message key="ad.material.status"/>',
                '<fmt:message key="ad.material.createTime"/>',
                '<fmt:message key="ad.material.createPerson"/>',
                '<fmt:message key="ad.material.updateTime"/>',
                '<fmt:message key="ad.material.updatePreson"/>'
            ],
            colModel:[
                {name:'id',index:'id', width : 80,align:'center', sortable : true},
                {name: 'materialName',index: 'materialName', width : 300, align:'center', sortable : true},
                {name : 'type', index : 'type', width : 270, align:'center', sortable : true},
                {name : 'clickHref', index : 'clickHref', width : 280, align:'center', sortable : true},
                {name : 'status', index : 'status', width : 108, align:'center', sortable : false,formatter:statusFmt},
                {name : 'createTime', index : 'createTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createId', index : 'createId', width : 100, align:'center', sortable : true},
                {name : 'updateTime', index : 'updateTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'updateId', index : 'updateId', width : 100, align:'center', sortable : true},
            ],
            shrinkToFit : false,
            hidegrid : false,
            viewrecords : true,
            rowNum:15,
            rowList:[10,15,20,30],
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
                openMainPage('<c:url value="/pages/adAd/adAddMaterial.jsp"/>', {"id": rowid}, function () {
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

        if(type == "edit"){
            $("#t_ad-add-material-grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
                '<td><button type="button" id="removeAdMaterial" class="btn btn-xs btn-danger"><i class="ace-icon fa fa-trash-o bigger-120"></i>取消关联</button></td>' +
                '<td></td>' +
                '</tr></table>');
        }else if(type == "add"){
            $("#t_ad-add-material-grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
                '<td><button type="button" id="addadMaterial" class="btn btn-xs btn-success"><i class="ace-icon fa fa-plus"></i>添加关联</button></td>' +
                '<td></td>' +
                '</tr></table>');
        }
            
       

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
        
        function typeFmt(cellvalue, options, rowObject){
            var result="";
            switch (cellvalue){
                case 1:
                    result='图片';
                    break;
                case 2:
                    result = '文字';
                    break;
            }
            return result;
        }
        
        function statusFmt(cellvalue, options, rowObject){
            var result="";
            switch (cellvalue){
                case 101:
                    result='<span class="green">待审核</span>';
                    break;
                case 103:
                    result = '<span class="red">审核失败</span>';
                    break;
                case 104:
                    result = '<span class="orange">待使用</span>';
                    break;
                case 105:
                    result = '<span class="green">使用中</span>';
                    break;
                case 106:
                    result = '<span class="red">已删除</span>';
                    break;
            }
            return result;
        }

        $("#search").on("click", function () {

            if($('#startTime').val() == ""){
                startDate = "";
                endDate = "";
            } else{
                dateRange = $('#startTime').val().replace(/\s/g, "").split("至");
                startDate = dateRange[0];
                endDate = dateRange[1];
            }

            $("#ad-add-material-grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/adad_getAdMaterialByPage.do'/>",
                postData : {
                    type:type,
                    adId:$("#adId").val(),
                    status:$("#status").val(),
                    adName:$("#adName").val(),
                    createTime: startDate +" 00:00:00",
                    createTime_end: endDate+" 23:59:59"
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })
        $("#addadMaterial").on("click",function () {
            var row = $("#ad-add-material-grid-table").jqGrid('getGridParam', 'selarrrow');
            if (row.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var materailIds = [];
            $.each(row,function (index,items) {
                var rowData = $("#ad-add-material-grid-table").jqGrid('getRowData',items);
                materailIds.push(rowData.id);
            });
            $.ajax({
                url:"<c:url value='/json/adad_addAdMaterial.do'/>",
                type:"POST",
                data:{adId:$("#adId").val(),materailIds:materailIds.join(","),operType:0},
                success:function (response) {
                    if(response.success) {
                        bootbox.alert("操作成功！");
                        $("#search").click();
                        return;
                    }else{
                        bootbox.alert("操作失败！");
                        return;
                    }
                },error:function () {
                    bootbox.alert("连接服务器超时！");
                    return;
                }
            })
            
        });
        
        $("#removeAdMaterial").on("click", function () {
            var status="${status}";
            if(status == 103){
                bootbox.alert("投放中广告不能修改！");
                return;
            }
            var row = $("#ad-add-material-grid-table").jqGrid('getGridParam', 'selarrrow');
            if (row.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var materailIds = [];
            $.each(row,function (index,items) {
                var rowData = $("#ad-add-material-grid-table").jqGrid('getRowData',items);
                materailIds.push(rowData.id);
            });
            $.ajax({
                url:"<c:url value='/json/adad_addAdMaterial.do'/>",
                type:"POST",
                data:{adId:$("#adId").val(),materailIds:materailIds.join(","),operType:1},
                success:function (response) {
                    if(response.success) {
                        bootbox.alert("操作成功！");
                        $("#search").click();
                        return;
                    }else{
                        bootbox.alert("操作失败！");
                        return;
                    }
                },error:function () {
                    bootbox.alert("连接服务器超时！");
                    return;
                }
            })
        });
       
        function formatDate(str) {
            return str.substr(0, 10) + " " + str.substr(10, str.length)+":00";
        }

        $("#add_mater_reset").on("click", function () {
            $("#add_material_form")[0].reset();
        });

    });
</script>