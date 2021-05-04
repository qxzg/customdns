<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache" />
<meta HTTP-EQUIV="Expires" CONTENT="-1" />
<link rel="shortcut icon" href="images/favicon.png" />
<link rel="icon" href="images/favicon.png" />
<title>软件中心 - 系统工具</title>
<link rel="stylesheet" type="text/css" href="index_style.css" />
<link rel="stylesheet" type="text/css" href="form_style.css" />
<link rel="stylesheet" type="text/css" href="usp_style.css" />
<link rel="stylesheet" type="text/css" href="ParentalControl.css">
<link rel="stylesheet" type="text/css" href="css/icon.css">
<link rel="stylesheet" type="text/css" href="css/element.css">
<link rel="stylesheet" type="text/css" href="res/softcenter.css">
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<script language="JavaScript" type="text/javascript" src="/client_function.js"></script>
<script type="text/javascript" src="/res/softcenter.js"></script>
<script>
var db_customdns = {}
	
function init() {
	show_menu(menu_hook);
	get_dbus_data();
}

function get_dbus_data() {
	$.ajax({
		type: "GET",
		url: "/_api/customdns",
		dataType: "json",
		async: false,
		success: function(data) {
			db_customdns = data.result[0];
			E("customdns_enable").checked = db_customdns["customdns_enable"] == "1";
		}
	});
}

function save() {
	showLoading(3);
	refreshpage(3);
	// collect data from checkbox
	db_customdns["customdns_enable"] = E("customdns_enable").checked ? '1' : '0';
	// post data
	var id = parseInt(Math.random() * 100000000);
	var postData = {"id": id, "method": "customdns_config.sh", "params": [1], "fields": db_customdns };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData)
	});
}

function reload_Soft_Center(){
	location.href = "/Module_Softcenter.asp";
}

function menu_hook(title, tab) {
	tabtitle[tabtitle.length -1] = new Array("", "customdns");
	tablink[tablink.length -1] = new Array("", "Module_customdns.asp");
}
</script>
</head>
<body onload="init();">
	<div id="TopBanner"></div>
	<div id="Loading" class="popup_bg"></div>
	<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
		<input type="hidden" name="current_page" value="Module_customdns.asp" />
		<input type="hidden" name="next_page" value="Module_customdns.asp" />
		<input type="hidden" name="group_id" value="" />
		<input type="hidden" name="modified" value="0" />
		<input type="hidden" name="action_mode" value="" />
		<input type="hidden" name="action_script" value="" />
		<input type="hidden" name="action_wait" value="5" />
		<input type="hidden" name="first_time" value="" />
		<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get(" preferred_lang "); %>"/>
		<input type="hidden" name="firmver" value="<% nvram_get(" firmver "); %>"/>
		<table class="content" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td width="17">&nbsp;</td>
				<td valign="top" width="202">
					<div id="mainMenu"></div>
					<div id="subMenu"></div>
				</td>
				<td valign="top">
					<div id="tabMenu" class="submenuBlock"></div>
					<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
						<tr>
							<td align="left" valign="top">
								<table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
									<tr>
										<td bgcolor="#4D595D" colspan="3" valign="top">
											<div>&nbsp;</div>
											<div style="float:left;" class="formfonttitle">自定义DNS</div>
											<div style="float:right; width:15px; height:25px;margin-top:10px">
												<img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img>
											</div>
											<div style="margin:30px 0 10px 5px;" class="splitLine"></div>
											<div class="formfontdesc" id="cmdDesc">该工具用于添加自定义的DNSmsql配置文件。</div>
											<div class="formfontdesc" id="cmdDesc"></div>
											<table style="margin:10px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="Module_customdns_table">
												<thead>
													<tr>
														<td colspan="2">自定义dnsmasq</td>
													</tr>
												</thead>
												<tr>
													<th>开启自定义dnsmasq</th>
													<td colspan="2">
														<div class="switch_field" style="display:table-cell;float: left;">
															<label for="customdns_enable">
																<input id="customdns_enable" class="switch" type="checkbox" style="display: none;">
																<div class="switch_container">
																	<div class="switch_bar"></div>
																	<div class="switch_circle transition_style">
																		<div></div>
																	</div>
																</div>
															</label>
														</div>
													</td>
												</tr>
											</table>
											<div class="apply_gen">
                                        		<span><input class="button_gen" id="cmdBtn" onclick="save();" type="button" value="提交"/></span>
											</div> 
											<div id="NoteBox">
												<h2>使用说明：</h2>
												<p>填入自定义的dnsmasq设置，一行一个，格式如下：</p>
												<p>#例如hosts设置：</p>
												<p>address=/koolshare.cn/2.2.2.2</p>
												<p>#防DNS劫持设置</p>
												<p>#bogus-nxdomain=220.250.64.18</p>
												<p>#指定config设置</p>
												<p>conf-file=/jffs/mydnsmasq.conf</p>
												<h3>如果填入了错误的格式，可能导致dnsmasq启动失败！</h3>
												<h3>如果填入的信息里带有英文逗号的，也会导致dnsmasq启动失败！</h3>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<td width="10" align="center" valign="top"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
	<div id="footer"></div>
</body>
</html>
