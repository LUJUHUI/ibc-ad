<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<%
    String username = session.getAttribute("_sso_username") == null
            ? ""
            : session.getAttribute("_sso_username").toString();
    if (username.length() > 14) {
        username = username.substring(0, 14).concat("...");
    }

    String appname = session.getAttribute("_sso_appnames") == null
            ? ""
            : session.getAttribute("_sso_appnames").toString();
    String appurl = session.getAttribute("_sso_appurls") == null
            ? ""
            : session.getAttribute("_sso_appurls").toString();

    String[] appnames = appname.split(",");
    String[] appurls = appurl.split(",");
    String header_Url = request.getServerName() + request.getContextPath();
    String admin_url = session.getAttribute("_sso_admin_url") == null
            ? ""
            : session.getAttribute("_sso_admin_url").toString();
    String sso_server_url = admin_url.replace("-admin", "");
    String pwdStat = session.getAttribute("_pwd_status") == null
            ? ""
            : session.getAttribute("_pwd_status").toString();
    String pwdMsg = "";
    if (null != pwdStat && (pwdStat.equals("1") || pwdStat.equals("-1")))
        pwdMsg = ",<font color='red'><fmt:message key='user.password.aging' /></font>";

    //用户信息请求接口url保存到session中，便于获取
    session.setAttribute("userListInf", admin_url + "/userListInf.json");
    String[] appCss = new String[]{"btn-pink", "btn-primary", "btn-success", "btn-info"};
%>

<div id="navbar" class="navbar navbar-default ace-save-state">
    <div class="navbar-container ace-save-state" id="navbar-container">
        <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
            <span class="sr-only">Toggle sidebar</span>

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>
        </button>

        <div class="navbar-header pull-left">
            <a href="index.html" class="navbar-brand">
                <small>
                    <i class="fa fa-leaf"></i>
                    <fmt:message key="webapp.name"/>
                </small>
            </a>
        </div>

        <div class="navbar-buttons navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
                <li class="light-blue dropdown-modal">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <img class="nav-user-photo" src="assets/images/avatars/avatar2.png" alt="Jason's Photo">
                        <span class="user-info">
                                            <small><fmt:message key="user.welcome" /></small>
                                            <%=username%>
                                        </span>

                        <i class="ace-icon fa fa-caret-down"></i>
                    </a>

                    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">

                        <li>
                            <a href="http://192.168.10.144:8080/logout">
                                <i class="ace-icon fa fa-power-off"></i>
                                <fmt:message key="user.logout"/>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div><!-- /.navbar-container -->
</div>
