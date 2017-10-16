<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />

<title><fmt:message key="webapp.name" /></title>

<meta name="description"
	content="Draggabble Widget Boxes with Persistent Position and State" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="assets/font-awesome/4.5.0/css/font-awesome.min.css" />

<!-- page specific plugin styles -->
<link rel="stylesheet" href="assets/css/jquery-ui.min.css" />
<link rel="stylesheet" href="assets/css/bootstrap-datepicker3.min.css" />
<link rel="stylesheet" href="assets/css/ui.jqgrid.min.css" />

<!-- text fonts -->
<link rel="stylesheet" href="assets/css/fonts.googleapis.com.css" />

<!-- ace styles -->
<link rel="stylesheet" href="assets/css/ace.min.css"
	class="ace-main-stylesheet" id="main-ace-style" />

<!--[if lte IE 9]>
        <link rel="stylesheet" href="assets/css/ace-part2.min.css" class="ace-main-stylesheet" />
        <![endif]-->
<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />

<!--[if lte IE 9]>
        <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
        <![endif]-->
<link rel="stylesheet" href="assets/css/daterangepicker.min.css" />

<!-- custom css file -->
<link rel="stylesheet" href="assets/css/custom.css" />

<!-- inline styles related to this page -->

<!-- ace settings handler -->
<script src="assets/js/ace-extra.min.js"></script>

<!--[if !IE]> -->
<script src="assets/js/jquery-2.1.4.min.js"></script>
<!-- <![endif]-->

</head>

<body class="no-skin">
	<script>
            var __webroot__ ='<c:url value="/"/>';
            var webroot = '<c:url value="/"/>';
        </script>

	<jsp:include page="/pages/head.jsp" />

	<div class="main-container ace-save-state" id="main-container">
		<script type="text/javascript">
                try{ace.settings.loadState('main-container')}catch(e){}
            </script>

		<!-- #section:basics/sidebar -->
		<jsp:include page="/pages/left.jsp">
			<jsp:param value="home" name="curNav" />
		</jsp:include>
		<!-- /section:basics/sidebar -->

		<!-- .main-content -->
		<div class="main-content">
			<%-- <jsp:include page="/ace/pages/settings.jsp" /> --%>
			<div class="main-content-inner" id="main_page">
                <div id="mainPage_1">
                    <c:if test="${not empty mainIndex }">
                        <jsp:include page="${mainIndex}" />
                    </c:if>
                </div>
			</div>
		</div>
		<!-- /.main-content -->
		<jsp:include page="/pages/footer.jsp" />

		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse display"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->

	<script type="text/javascript">
            if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
        </script>
	<script src="assets/js/bootstrap.min.js"></script>

	<!-- page specific plugin scripts -->
	<script src="assets/js/bootstrap-datepicker.min.js"></script>
	<script src="assets/js/jquery.jqGrid.min.js"></script>
	<script src="assets/js/grid.locale-cn.js"></script>

	<script src="assets/js/jquery.dataTables.min.js"></script>
	<script src="assets/js/jquery.dataTables.bootstrap.min.js"></script>
	<script src="assets/js/dataTables.buttons.min.js"></script>
	<script src="assets/js/buttons.flash.min.js"></script>
	<script src="assets/js/buttons.html5.min.js"></script>
	<script src="assets/js/buttons.print.min.js"></script>
	<script src="assets/js/buttons.colVis.min.js"></script>
	<script src="assets/js/dataTables.select.min.js"></script>

	<!-- bootbox.js -->
	<script src="assets/js/bootbox.js"></script>

	<!-- ace scripts -->
	<script src="assets/js/ace-elements.min.js"></script>
	<script src="assets/js/ace.min.js"></script>

	<!-- daterangepicker -->
	<script src="assets/js/moment.min.js"></script>
	<script src="assets/js/daterangepicker.js"></script>

	<script src="assets/js/main.js"></script>
	<script src="assets/js/jquery.tips.js"></script>

	<!-- inline scripts related to this page -->
	<script type="text/javascript">
            jQuery(function($) {

                $.ajaxSetup({
                    cache : false
                    //关闭AJAX相应的缓存
                });

                $('#left_menu a').each(function(n, v) {
                    var url = $(v).attr("menu-url");
                    if (url) {
                        $(v).unbind('click').click(function(e) {
                            openPage($(this).attr("menu-url"));

                            $('#left_menu .active').each(function(nn, vv) {
                                $(vv).removeClass("active");
                            });
                            $(this).parents("li").each(function(nn, vv) {
                                $(vv).addClass("active");
                            });
                        });
                    }
                });

            });

            function openPage(url) {
                try  {
                    interval(false);
                } catch (e) {
                }
                var p = $("#mainPage_1");
                if (p.length > 0) {
                    if ($("#mainPage_1 ~ div").length > 0){
                        $("#mainPage_1 ~ div").each(function () {
                            $(this).remove();
                        });
                        p.removeClass("main-page-div-display");
                    }
                    p.load(url, function(response, status, xhr) {
                        if (status != "success") {
                            //console.log("load page error.");
                            //checkSession();
                        }
                    });
                }
            }

            try {
                ace.settings.check('navbar', 'fixed');
                ace.settings.check('sidebar', 'fixed');
            } catch (e) {
            }
        </script>
</body>
</html>

