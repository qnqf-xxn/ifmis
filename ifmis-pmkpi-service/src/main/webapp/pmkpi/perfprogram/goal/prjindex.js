if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _proguid;
var _prolev;
var _saveAgency;
Ext.lt.pmkpi.prjindexservice = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    _saveAgency = config["saveAgency"]; //项目单位
    /*if (_saveAgency == "" || _saveAgency == null) {//嵌套页面获取父及页面的单位
        if (parent.editform) {
            if (parent.editform.getCol("agency_code")) {
                _saveAgency = parent.editform.getCol("agency_code").getvalue();
            }
        }
    }*/
    var _busguid = config.busguid;//审核定义guid
    _prolev = config["prolev"]; //项目等级123级项目
    var _cmp = {};
    var tabcomps = {};
    var iframeurl = config.iframeurl;//嵌套url
    var editinfo = config.editinfo;
    var hideIframeHtml = "";
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//" + document.location.host + "/" + iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    //页面加载完成后执行
    $(function () {
        if (hideIframeHtml != null && hideIframeHtml != "") {
            $("#editform").append(hideIframeHtml);
        }
        if (editinfo && editinfo.length > 0){
            editform.synchEditformByObj(editinfo[0]);
        }
        if (_viewtype == "query") {
            //document.getElementById("toolbutton").style.display = "none";
            editform.setdisabled({zqgoal:true,kpi_target:true});
        }
    });

    /**
     * 项目指标保存方法
     * @param obj
     */
    _cmp.save = function (obj) {
        if (!editform.check()) {
            return false;
        }
        if (!editform.haschange() && editinfo && editinfo.length != 0){ //数据没有变化,不进行后台保存
            var obj = {};
            obj.success = true;
        	return obj;
		}
        var editinfo = editform.getEditFormValues();
        if (!perfcommon.checkSpaceValue(editinfo,null,"editform")) return;//校验空格
        editinfo.zqgoal = convertStr(editinfo.zqgoal);
        editinfo.kpi_target = convertStr(editinfo.kpi_target);
        var params = {};
        params.editinfo = editinfo;
        params.projguid = _proguid;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        var _procode = "";
        if (parent.editform) {
            if (parent.editform.getCol("pro_code")) {
                _procode = parent.editform.getCol("pro_code").getvalue();
            }
        }
        params.procode = _procode; //项目编码
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "savePrjIndex", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            //_cmp.init();
        }
        return rs;
    }
    return _cmp;
}