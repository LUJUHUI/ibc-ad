<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/18
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<%--新建素材模块--%>
<div class="modal fade bs-example-modal-sm" tabindex="-1" id="addAdMaterialModel" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addAdMaterial">新建素材</h4>
            </div>
            <div class="modal-body">
                <form id="add_materialForm">

                    <div class="form-group">
                        <label for="add_adMaterialName" class="control-label">素材名称:</label>
                        <input type="text" class="form-control" id="add_adMaterialName" name="adMaterial.adMaterialName">
                    </div>

                    <div class="form-group">
                        <label for="add_type" class="control-label">素材类型 :</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="add_type" name="adMaterial.type">
                            <option value="1">图片</option>
                            <option value="2">文字</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="add_clickHref" class="control-label">链接地址:</label>
                        <input type="text" class="form-control" id="add_clickHref" name="adMaterial.clickHref">
                    </div>

                    <div class="form-group">
                        <label for="add_status" class="control-label">状态 :</label>
                        <input type="text" class="form-control" id="add_status" name="adMaterial.status" value="待审核">
            </div>

                    <div class="form-group">
                        <label for="createTime" class="control-label">新建时间 :</label>
                        <input type="text" class="form-control" readonly="readonly" id="createTime">
                        <input type="hidden" class="form-control" id="startDate" name="adMaterial.startTime" value="">
                        <input type="hidden" class="form-control" id="endDate" name="adMaterial.endTime" value="">
                    </div>

                </form>
                <div class="modal-footer">
                    <button type="button" id="close_addAdMaterial" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" id="save_addAdMaterial" class="btn btn-primary">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

<%--修改素材模块--%>
<div class="modal fade bs-example-modal-sm" tabindex="-1" id="updateAdMaterialModel" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateMaterial">修改素材</h4>
            </div>
            <div class="modal-body">
                <form id="update_materialForm">

                    <div class="form-group">
                        <label for="update_adMaterialName" class="control-label">素材名称:</label>
                        <input type="text" class="form-control" id="update_adMaterialName" name="adMaterial.adMaterialName">
                    </div>

                    <div class="form-group">
                        <label for="update_type" class="control-label">素材类型 :</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="update_type" name="adMaterial.type">
                            <option value="1">图片</option>
                            <option value="2">文字</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="update_clickHref" class="control-label">链接地址:</label>
                        <input type="text" class="form-control" id="update_clickHref" name="adMaterial.clickHref">
                    </div>

                    <div class="form-group">
                        <label for="update_status" class="control-label">状态 :</label>
                         <input type="text" class="form-control" id="update_status" name="adMaterial.status">
                    </div>

                    <div class="form-group">
                        <label for="updateTime" class="control-label">修改时间 :</label>
                        <input type="text" class="form-control" readonly="readonly" id="updateTime">
                        <input type="hidden" class="form-control" id="st_date" name="adMaterial.startTime" value="">
                        <input type="hidden" class="form-control" id="ed_date" name="adMaterial.endTime" value="">
                    </div>

                </form>
                <div class="modal-footer">
                    <button type="button" id="close_updateAdMaterial" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" id="save_updateAdMaterial" class="btn btn-primary">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

<%--删除素材模块--%>
<div class="modal fade bs-example-modal-sm" tabindex="-1" id="deleteadMaterialModel" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteMaterial">删除素材</h4>
            </div>
            <div class="modal-body">
                <form id="delete_material_Form">
                    <div class="form-group">
                        <label for="delete_status" class="control-label">审核状态 :</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="delete_status" name="adMaterial.status">
                            <option value="101">待审核</option>
                            <option value="103">审核失败</option>
                        </select>
                    </div>

                </form>
                <div class="modal-footer">
                    <button type="button" id="close_deleteAdMaterial" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" id="save_deleteAdMaterial" class="btn btn-primary">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

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
            <fmt:message key="ad.material"/>
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
            <label class="control-label" for="materialName">素材名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="materialName">

            <label class="control-label" for="type">素材类型</label>
            <select class="form-control input-sm" readonly="readonly"  style="margin-left: 5px;" id="type">
                <option value="">全部</option>
                <option value="1">图片</option>
                <option value="2">文字</option>
            </select>

            <label class="control-label" for="status">素材状态</label>
            <select class="form-control input-sm" readonly="readonly" id="status" style="margin-left: 5px;">
                <option value="">全部</option>
                <option value="101">待审核</option>
                <option value="102">审核通过</option>
                <option value="103">审核失败</option>
                <option value="104">待使用</option>
                <option value="105">使用中</option>
                <option value="106">已删除</option>
                <c:forEach var="status" items="${pubStatus}">
                    <option value="${status.key}">${status.value}</option>
                </c:forEach>
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
            url: "<c:url value='/json/adMaterial_getAdMaterial.do'/>",
            postData: {
                materialName: $("#materialName").val(),
                type: $("#type").val(),
                status: $("#status").val(),
                beginDate: startDate,
                endDate: endDate
            },
            height: 560,
            colNames:[
                '<fmt:message key="ad.material.id"/>',
                '<fmt:message key="ad.material.materialName"/>',
                '<fmt:message key="ad.material.type"/>',
                '<fmt:message key="ad.material.clickHref"/>',
                '<fmt:message key="ad.material.status"/>',
                '<fmt:message key="ad.material.createTime"/>',
                '<fmt:message key="ad.material.createId"/>',
                '<fmt:message key="ad.material.updateTime"/>',
                '<fmt:message key="ad.material.updateId"/>'
            ],
            colModel:[
                {name:'id',index:'id', width : 80,align:'center', sortable : true,hidden:true},
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
            caption: '<fmt:message key="ad.material" />',
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
            '<td><button type="button" id="adm_create" class="btn btn-xs btn-success"><i class="ace-icon fa fa-paper-plane-o"></i>创建</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="adm_update" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-wrench"></i>修改</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="adm_delete" class="btn btn-xs btn-danger"><i class="ace-icon  glyphicon glyphicon-remove"></i>删除</button></td>' +
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
                    result='待审核';
                    break;
                case 102:
                    result = '审核通过';
                    break;
                case 103:
                    result = '审核失败';
                    break;
                case 104:
                    result = '待使用';
                    break;
                case 105:
                    result = '使用中';
                    break;
                case 106:
                    result = '已删除';
                    break;
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
                url : "<c:url value='/json/adMaterial_getAdMaterial.do'/>",
                postData : {
                    materialName: $("#materialName").val(),
                    type: $("#type").val(),
                    status: $("#status").val(),
                    beginDate: startDate,
                    endDate: endDate
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })

        $("#adm_update").on("click",function () {
            $('#update_adMaterialName').val("");
            $('#update_type').val("");
            $('#update_clickHref').val("");
            $('#update_status').val("");
            $('#updateTime').val("");
            $("#updateAdMaterialModel").modal();
        });

        /* -------新建素材(start)--------------*/
        $("#adm_create").on("click",function () {
            $("#addAdMaterialModel").modal();/*this id should match above id whlich equaled 'addAdMaterialModel'*/
        });

        $("#save_addAdMaterial").on("click",function () {
            if($("#add_adMaterialName").val() == ""){
                $("#add_adMaterialName").tips({side:2,msg:'此项必填 ',time:3});
                return false;
            }
            if($("#add_type").val() == ""){
                $("#add_type").tips({side:2,msg:'此项必填 ',time:3});
                return false;
            }
            if($("#add_clickHref").val() == ""){
                $("#add_type").tips({side:2,msg:'此项必填 ',time:3});
                return false;
            }
            if($("#add_status").val() == ""){
                $("#add_status").tips({side:2,msg:'此项必填 ',time:3});
                return false;
            }
            $.ajax({
                url:"<c:url value='/json/adMaterial_addAdMaterial.do'/>",
                data:$("#add_materialForm").serialize(),
                type:"post",
                success:function(data){
                    $("#addAdMaterialModel").modal('hide')
                    $("#search").click();
                    alert("添加成功!");
                },error:function(){
                    alert("添加失败，无法连接服务器!");
                }
            });
        })
        /* -------新建素材(end)--------------*/

        /* -------修改素材(start)------------*/
            $("#adm_update").on("click",update);
                function update() {
                    var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
                    if (ids.length == 0){
                        bootbox.alert("请选择要操作的记录！");
                        return;
                    }
                    var codes = [];
                    for (var index in ids){
                        var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
                        if(rowData.status == 104){
                            bootbox.alert("没有选择有效记录！");
                            return;
                        }else{
                            codes.push(rowData.id);
                        }
                    }
                    for (var index in ids){
                        var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
                        $("#update_adMaterialName").val(rowData.adMaterialName);
                        $("#update_type").val(rowData.type);
                        $("#update_clickHref").val(rowData.clickHref);
                        $("#update_status").val(statusFmt(rowData.status));
                        $("#updateTime").val(rowData.updateTime);

                        switch (rowData.status){
                            case "待审核":
                                $("#update_status option[value='101']").attr("selected","selected")
                                break;
                        }
                    }
/*                    if (codes.length > 0){
                        //js调试
                        //alert(data)   console.log(data)
                        //ajax
                        //请求数据
                        //放到模态框中
                        //$("#maName").val();
                    }*/

                $("#updateAdMaterialModel").modal();/*this id should match above id whlich equaled 'updateAdMaterialModel'*/
            };
        /*this id:'save_updateAdMaterial' should match above id which button named 'save'*/
        $("#save_updateAdMaterial").on("click",function() {
                if ($("#update_adMaterialName").val() == "") {
                    $("#update_adMaterialName").tips({side: 2, msg: '此项必填 ', time: 3});
                    return false;
                }
                if ($("#update_type").val() == "") {
                    $("#update_type").tips({side: 2, msg: '此项必填 ', time: 3});
                    return false;
                }
                if ($("#update_clickHref").val() == "") {
                    $("#update_type").tips({side: 2, msg: '此项必填 ', time: 3});
                    return false;
                }
                if ($("#update_status").val() == "") {
                    $("#update_status").tips({side: 2, msg: '此项必填 ', time: 3});
                    return false;
                }
                $.ajax({
                    url: "<c:url value='/json/adMaterial_updateAdMaterial.do'/>",
                    data: $("#update_materialForm").serialize(),
                    type: "post",
                    success: function (data) {
                        $("#updateAdMaterialModel").modal('hide')
                        $("#search").click();
                        alert("修改成功!");
                    }, error: function () {
                        alert("修改失败，无法连接服务器!");
                    }
                });
            }
        /* -------修改素材(end)------------*/

        /* -------删除素材(start)----------*/
        $("#adm_delete").on("click",deleteAdMaterial);
        function deleteAdMaterial() {
            var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var codes = [];
            for (var index in ids){
                var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
                codes.push(rowData.id);
            }
            if (codes.length < 1){
                bootbox.alert("没有选择有效记录！");
                return;
            }
            var codeStr = '';
            for (var index in codes){
                codeStr =codeStr + codes[index] + ',';
            }
            $.post('<c:url value="/json/adMaterial_delateAdMaterial.do"/>', {"materialIds": codeStr.substring(0, codeStr.length-1)}, function (result) {
                bootbox.alert("操作成功！");
                $("#search").trigger('click');
            });
        }
        /* -------删除素材(end)----------*/
    });
</script>

