package com.wondertek.mobilevideo.bc.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wondertek.mobilevideo.bc.core.service.GenericManager;
import com.wondertek.mobilevideo.bc.core.utils.PageList;
import com.wondertek.mobilevideo.core.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.mail.SimpleMailMessage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.*;

/**
 * Implementation of <strong>ActionSupport</strong> that contains convenience
 * methods for subclasses. For example, getting the current user and saving
 * messages/errors. This class is intended to be a base class for all Action
 * classes.
 *
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
public class BaseAction extends ActionSupport {
	private static final long serialVersionUID = 3525445612504421307L;

	public Map<String, Object> resultMap = new HashMap<String, Object>();

	/**
	 * Constant for cancel result String
	 */
	public static final String CANCEL = "cancel";

	/**
	 * Transient log to prevent session synchronization issues - children can
	 * use instance for logging.
	 */
	protected final transient Log log = LogFactory.getLog(getClass());

	/**
	 * The UserManager
	 */
	// protected UserManager userManager;

	/**
	 * The RoleManager
	 */
	// protected RoleManager roleManager;

	/**
	 * Indicator if the user clicked cancel
	 */
	protected String cancel;

	/**
	 * Indicator for the page the user came from.
	 */
	protected String from;

	/**
	 * Set to "delete" when a "delete" request parameter is passed in
	 */
	protected String delete;

	/**
	 * Set to "save" when a "save" request parameter is passed in
	 */
	protected String save;

	/**
	 * MailEngine for sending e-mail
	 */
	// protected MailEngine mailEngine;

	/**
	 * A message pre-populated with default data
	 */
	protected SimpleMailMessage mailMessage;

	/**
	 * Velocity template to use for e-mailing
	 */
	protected String templateName;

	/**
	 * Simple method that returns "cancel" result
	 *
	 * @return "cancel"
	 */
	public String cancel() {
		return CANCEL;
	}

	/**
	 * Save the message in the session, appending if messages already exist
	 *
	 * @param msg
	 *            the message to put in the session
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected void saveMessage(String msg) {
		List messages = (List) getRequest().getSession().getAttribute("messages");
		if (messages == null) {
			messages = new ArrayList();
		}
		messages.add(msg);
		getRequest().getSession().setAttribute("messages", messages);
	}

	public String getUserId() {
		if (this.getSession().getAttribute("_sso_userid") != null)
			return this.getSession().getAttribute("_sso_userid").toString();
		return "";
	}

	public String getUsername() {
		HttpSession session = getSession();
		String username = null;
		if (session.getAttribute("_sso_username") != null) {
			username = (String) session.getAttribute("_sso_username");
		}
		return username;
	}

	protected String createFile(String fileName, String tempDir) {
		String filePath = this.getSession().getServletContext().getRealPath(tempDir + fileName);
		File file = new File(filePath);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		return filePath;
	}

	/**
	 * Convenience method to get the request
	 *
	 * @return current request
	 */
	protected HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * Convenience method to get the response
	 *
	 * @return current response
	 */
	protected HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	/**
	 * Convenience method to get the session. This will create a session if one
	 * doesn't exist.
	 *
	 * @return the session from the request (request.getSession()).
	 */
	protected HttpSession getSession() {
		return getRequest().getSession();
	}

	/*
	 * protected void sendUserMessage(User user, String msg, String url) { if
	 * (log.isDebugEnabled()) { log.debug("sending e-mail to user [" +
	 * user.getEmail() + "]..."); }
	 *
	 * mailMessage.setTo(user.getFullName() + "<" + user.getEmail() + ">");
	 *
	 * Map<String, Object> model = new HashMap<String, Object>();
	 * model.put("user", user); // TODO: figure out how to get bundle specified
	 * in struts.xml // model.put("bundle", getTexts()); model.put("message",
	 * msg); model.put("applicationURL", url);
	 * mailEngine.sendMessage(mailMessage, templateName, model); }
	 */

	protected void writeResponse(String msg) {
		try {
			if (msg != null) {
				getResponse().getWriter().write(msg);
				getResponse().getWriter().flush();
			}
		} catch (IOException e) {
			log.error(e.getCause());
			e.printStackTrace();
		}
	}

	protected void writeTextResponse(String msg) {
		getResponse().setContentType("text/plain");
		writeResponse(msg);
	}

	public void setMailMessage(SimpleMailMessage mailMessage) {
		this.mailMessage = mailMessage;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	/**
	 * Convenience method for setting a "from" parameter to indicate the
	 * previous page.
	 *
	 * @param from
	 *            indicator for the originating page
	 */
	public void setFrom(String from) {
		this.from = from;
	}

	public void setDelete(String delete) {
		this.delete = delete;
	}

	public void setSave(String save) {
		this.save = save;
	}

	public Map<String, Object> getResultMap() {
		return resultMap;
	}

	public void setResultMap(Map<String, Object> resultMap) {
		this.resultMap = resultMap;
	}

	public String convertFileSize(long size) {
		float kb = 1024;
		float mb = kb * 1024;
		float gb = mb * 1024;
		float tb = gb * 1024;
		float pb = tb * 1024;

		if (size >= pb) {
			return String.format("%.2f PB", (float) size / pb);
		}
		if (size >= tb) {
			return String.format("%.2f TB", (float) size / tb);
		}
		if (size >= gb) {
			return String.format("%.2f GB", (float) size / gb);
		} else if (size >= mb) {
			float f = (float) size / mb;
			return String.format(f > 100 ? "%.2f MB" : "%.2f MB", f);
		} else if (size >= kb) {
			float f = (float) size / kb;
			return String.format(f > 100 ? "%.2f KB" : "%.2f KB", f);
		} else
			return String.format("%d B", size);
	}

	public int getPageNo() {
		try {
			int pageNo = Integer.valueOf(getRequest().getParameter("page"));
			if (pageNo == 0) {
				return 1;
			}
			return Integer.valueOf(getRequest().getParameter("page"));
		} catch (Exception e) {
		}
		return 1;
	}

	public int getPageSize() {
		try {
			return Integer.valueOf(getRequest().getParameter("rows"));
		} catch (Exception e) {
		}
		return 10;
	}

	public String getOrder() {
		String order = getRequest().getParameter("order");
		if (StringUtils.isBlank(order)) {
			order = getRequest().getParameter("sord");
		}
		return order;
	}

	public String getSort() {
		String sort = getRequest().getParameter("sort");
		if (StringUtils.isBlank(sort)) {
			sort = getRequest().getParameter("sidx");
		}
		return sort;
	}

	public String getParameter(String key) {
		String param = this.getRequest().getParameter(key);
		 if (StringUtils.isBlank(param)) {
			 return null;
		 }
		 return param.replace("\\", "\\\\").replace("%", "\\%");
	}

	public Object getParameter(String key, String type) {
		String param = getParameter(key);
		if (param == null)
			return null;
		if (null != type)
			switch (type) {
			case "int":
			case "Integer":
				return getIntParameter(key);
			case "long":
			case "Long":
				return getLongParameter(key);
			case "Date":
				return getDateParameter(key);
			case "String":
			default:
				break;
			}
		return getParameter(key);
	}
	
	public Date getDateParameter(String key){
		return getDateParameter(key, new Date());
	}
	
	public Date getDateParameter(String key, Date def) {
		try {
			return DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN, getParameter(key));
		} catch (Exception e) {
			return def;
		}
	}
	
	public Long getLongParameter(String key, Long def){
		try {
			return Long.parseLong(getParameter(key));
		} catch (Exception e) {
			return def;
		}
		
	}
	public Long getLongParameter(String key) {
		return getLongParameter(key, 0L);
	}

	public Integer getIntParameter(String key, Integer def) {
		try {
			return Integer.parseInt(getParameter(key));
		} catch (Exception e) {
			return def;
		}
	}
	
	public Integer getIntParameter(String key) {
		return getIntParameter(key, 0);
	}

	public Map<String, Object> prepareParams(List<String[]> paramNameArrs) {
		Map<String, Object> params = new HashMap<String, Object>();
		for (String[] paramArr : paramNameArrs) {
			Object ob = getParameter(paramArr[0], paramArr[1]);
			if (ob == null)
				continue;
			params.put(paramArr[0], ob);
		}
		return params;
	}

	public Map<String, Object> prepareParams(Class<?> clazz) {
		return prepareParams(createParameterList(clazz));
	}
	
	public List<String[]> createParameterList(Class<?> clazz){
		List<String[]> paramNameArrs = new ArrayList<String[]>();
		Field[] fs = clazz.getDeclaredFields();
		for (Field f : fs) {
			f.setAccessible(true); // 设置些属性是可以访问的
			String modifierStr = Modifier.toString(f.getModifiers());
			if ((modifierStr.indexOf("static") != -1) || (modifierStr.indexOf("final") != -1))
				continue;
			String[] typeArr = f.getType().toString().split("\\.");
			String type = typeArr[typeArr.length-1];
			if (type.endsWith("Date")) {
				paramNameArrs.add(new String[] { f.getName()+"_beginTime", type });
				paramNameArrs.add(new String[] { f.getName()+"_endTime", type });
			} else {
				paramNameArrs.add(new String[] { f.getName(), type });
			}
		}
		return paramNameArrs;
	}

	public void getPageList(GenericManager<?, ?> genericManager, Class<?> clazz) throws Exception {
		Map<String, Object> params = prepareParams(clazz);
		PageList list = new PageList();
		list = genericManager.getPageList(params, getPageNo(), getPageSize(), getSort(), getOrder());
		resultMap.put("rows", list.getList());
		resultMap.put("records", list.getRecordCount());
		resultMap.put("pageCount", list.getPageCount());
	}
	
	public void setAttribute(String str, Object ob){
		getRequest().setAttribute(str, ob);
	}
}
