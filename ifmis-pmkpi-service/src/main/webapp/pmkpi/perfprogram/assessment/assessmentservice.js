if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var is_JiangXi;
Ext.lt.pmkpi.assessmentservice = function(config, service) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var _busguid = config.busguid;//审核定义guid
    var _prolev = config["prolev"]; //项目等级123级项目
    var _saveAgency = config["saveAgency"];
    var _selectbillguid = config.selectbillguid;//调整前项目guid
    var _adjadd = config.adjadd;//是否调整
    var _pdmsave = config.pdmsave;//保存、查询类型
    var _procode = config.procode;
    var _assessmentTypes = config.assessmentTypes;//事前绩效评估类型
    var _isShowselAssessment = config.isShowselAssessment;
    var _bustype = config.bustype;//数据类型,下拉框显示时有值，不显示为空字符串
    is_JiangXi = config.is_JiangXi;//是否江西
    var _showall = config["showall"];  //项目查询标识
    var _dataprovince = config["dataprovince"]; //传递的区划参数
    var _cmp = {};
    var iframeurl = config.iframeurl;//嵌套url
    //是否显示编辑区，1不显示、2显示
    var hideIframeHtml = "";
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//"+ document.location.host +"/"+ iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }

    var _panel; //切换年度的组件.
    var isFirst = true;
    var _issave = false;

    //页面加载完成后执行
    $(function() {
        perfcommon.initDatatable();
        _cmp.init(true);
        if(_SYSTEMSTYLE_ == "grey"){//事前评估列表 新ui去掉列表组件按钮
            $("#datatable").find(".titlename").siblings().not(":last").hide();
        }
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#datatable").append(hideIframeHtml);
        }
        if (_viewtype == "query") {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
        if (_isShowselAssessment && (_bustype || _bustype == "")) {
            _cmp.laypopupbustype();//事前绩效评估类型选择框
            _cmp.setSelAssessment(_bustype);
        }
        isFirst = false;
    });

    /**
     * 页面初始化.
     */
    _cmp.init = function(isquery){
        _cmp.query();
        if (isquery) {
            parent._isQuery = true;
        }
    }

    /**
     * 项目指标保存方法
     * @param obj
     */
    _cmp.save = function(obj){
        var params = {};
        if (!_cmp.checkAll()) return false;//先校验
        var datas = datatable.getRecordSet().toArray();
        try {
            if (editform) {
                if (!editform.check()) return false;//先校验
                params.edifinfo =  editform.getEditFormValues();
            }
        } catch (e){}
        params.proguid = _proguid;
        params.datas = datas;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.pro_code = _procode;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            _cmp.query();
        }
        return rs;
    }

    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    _cmp.checkAll = function() {
        var datas = datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["isleaf"] == 1) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
        if(data.table.config.id ="datatable"){
            var cols = data.cols;
            if(!Ext.lt.isArray(cols))
                cols = [cols];
            for(var i=0; i<cols.length; i++){
                var col = cols[i];
                if (col["colcode"] == "standard" || col["colcode"] == "remarks") {
                    col.oneditstart = function(table,el,l,c,d){
                        if(d.isleaf != "1"){
                            return false;
                        }
                    }
                }
                //一二级指标不可修改
                if(col["colcode"]=="scorenum"){
                    col.oneditstart = function(table,el,l,c,d){
                        if(d.isleaf != "1"){
                            return false;
                        }
                    }
                    col.cseditfn = function (i, j, rs, style) {
                        var newstyle = 'text-align:right;padding-right:5px;';
                        if(rs.isleaf == "0"){
                            newstyle = 'text-align:right;padding-right:5px;font-weight: bold';
                        }
                        var styleresult = updateStyle(style, newstyle);
                        return styleresult;
                    }
                    col.fn = function(l,c,data,col){
                        if(data.isleaf == "0"){
                            var scorenum = 0;
                            if(data.scorenum){
                                scorenum = data.scorenum;
                            }
                            if(data.name == "评分等级"){
                                if(90 <= data.scorenum){
                                    scorenum = "优";
                                } else if (80 <= data.scorenum && data.scorenum <= 89){
                                    scorenum = "良";
                                } else if (60 <= data.scorenum && data.scorenum <= 79) {
                                    scorenum = "中";
                                } else if (data.scorenum <60) {
                                    scorenum = "差";
                                }
                                return scorenum;
                            }
                            if(data.name == "总体评估结论"){
                                if(90 <= data.scorenum){
                                    data['scorenum'] = "建议予以支持";
                                } else if (70 <= data.scorenum && data.scorenum <= 89){
                                    data['scorenum'] = "建议调整完善后予以支持";
                                } else if (data.scorenum <70) {
                                    data['scorenum'] = "建议不予支持";
                                }
                                return scorenum;
                            }
                            return Math.round(scorenum*100)/100;
                        } else {
                            return data.scorenum ? data.scorenum : 0.00;
                        }
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.scorenum && d.scorenum != "" && !checkReferencepole(d)){
                            d.scorenum = '';
                            return false;
                        }
                        gatherWeight(d.superid);
                        setTimeout(function(){
                            reflashdatas();
                        },100);
                    }
                }

                if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                    col.style = "background-color:#f2f2f2;";
                    col.oneditstart = function (table, e, l, c, d) {
                        return false;
                    }
                }
            }
        }
    });

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.isleaf == 0){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    /**
     * 项目库查询明细，构建多年度绩效查询.
     * @param curryear -- 当前年度.
     */
    _cmp.laypopupbustype = function() {
        $('.tbtitle').append("<div id = 'changbustypes' style='float:right;width:25%;margin-top:-2px;'/>");
        _cmp.finintorgSelect();
    }
    _cmp.finintorgSelect = function () {
        var div = document.getElementById("changbustypes");
        var _isedit = 1;
        if (_viewtype == "query") {
            _isedit = 0;
        }
        _panel = new Ext.lt.bus.ui.editformpanel({
            columnsize: 1,
            data: [
                {
                    guid: "bustype",
                    colcode: "BUSTYPE",
                    name: '事前绩效评估类型',
                    csid: "PERFASSESSMENTTYPE",
                    type: "tree",
                    isedit: _isedit,
                    isvisiable: 1,
                    colspannum: 0,
                    config: "{clearbtn:false,clickchoose:true,format:'#name'}",
                    datalength: "40",
                    datatype: "S",
                    defaultvalue: null,
                    editctrlmsg: null,
                    fromsource: 0,
                    bottomcontrl: 0,
                    head: null,
                    iseditctrl: null,
                    requirement: 0,
                    setvalue: 0,
                    showlevel: null,
                    status: "1",
                    textarearows: 0,
                    levelcontrol: 0
                }
            ]
        });
        _panel.attachEvent({
            bustype: {
                asyncloaddata: function (resp) {
                    resp.data = _assessmentTypes;
                }
            }
        });
        _panel.afterchange(function (param) {
            if (!isFirst) {
                if (typeof _panel.getCol('bustype') != "undefined" && _panel.getCol('bustype').ischange()) {
                    var type = param.bustype;
                    if (!!type && _bustype != type) {
                        var remark = "";
                        if (_issave) {
                            remark = "当前类型评分表已保存，选择其他类型后再次保存数据将替换！";
                        } else if (datatable.getUpdataData().length > 0) {
                            remark = "评分表未保存，选择其他类型当前类型数据将清空！"
                        }
                        if (remark) {
                            Ext.lt.ui.confirm(remark, null, function(is){
                                if(is){
                                    _cmp.query(type);
                                } else {
                                    _cmp.setSelAssessment(_bustype);
                                }
                            });
                        } else {
                            _cmp.query(type);
                        }
                    }
                }
            }
        });
        _panel.draw(div);
    }

    //查询或选择下拉查询
    _cmp.query = function (type) {
        var params = {};
        params.proguid = _proguid;
        params.selectbillguid = _selectbillguid;
        params.adjadd = _adjadd;
        params.pdmsave = _pdmsave;
        params.viewtype = _viewtype;
        params.showall = _showall;
        params.dataprovince = _dataprovince;
        if (type) {
            params.bustype = type;
            _bustype = type;
        } else {
            params.bustype = _bustype;
        }
        params.isselAssessment = _isShowselAssessment;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "getDatas", params);
        if (rs) {
            if (rs.dataList && rs.dataList.length > 0) {
                datatable.setDatas(rs.dataList);
                setTimeout(function(){
                    reflashdatas();   // 偶尔不刷新
                },100);
            } else if (type || !_isShowselAssessment) {//下拉选择无数据时，提示配置模板数据
                datatable.setDatas([]);
                Ext.lt.ui.alert("请联系管理员配置模板数据",{timeout:1},function(){});
            }
            _issave = rs.issave;
            try {
                if (editform && rs.dataInfo) {
                    editform.synchEditformByObj(rs.dataInfo);
                }
            } catch (e){}
        } else {
            Ext.lt.ui.alert("查询报错，请联系管理员！",{timeout:1},function(){});
        }
        Ext.lt.ui.loadingClose();
    }

    _cmp.setSelAssessment = function (selbustype) {
        //根据数据情况，设置选中类型
        if (!!_assessmentTypes && _assessmentTypes.length > 0) {
            for (var i = 0; i < _assessmentTypes.length; i++) {
                if (_assessmentTypes[i]["guid"] == selbustype) {
                    var bustype = _assessmentTypes[i]["guid"];
                    var name = _assessmentTypes[i]["name"];
                    _panel.synchEditform({bustype: {text: name, value: bustype}});
                    break;
                }
            }
        }
    }

    return _cmp;
}

/**
 * 只能输入数字校验
 * @param referencepole
 * @returns {boolean}
 */
function checkReferencepole (str){
    var re = /^\d*\.{0,1}\d{0,2}$/;
    var scorenum = str.scorenum;
    var weight = str.weight;
    if(!re.test(scorenum)){
        Ext.lt.ui.alert("只能填数字！",{timeout:1},function(){});
        return false;
    }else if(scorenum > weight){
        Ext.lt.ui.alert("评估得分大于权重，请输入合理的数字！",{timeout:1},function(){});
        return false;
    }else{
        return true;
    }
}

function gatherWeight(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                if(datas[i].name == "总得分" || datas[i].name == "评分等级" || datas[i].name == "合计" || datas[i].name == "总体评估结论"){
                    datas[i].tguid = "00";
                }
                var selectDatas = datas[i];
                if(superid == selectDatas.tguid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.tguid;
                }
                if(selectDatas.superid == superid && selectDatas.scorenum && !isNaN(selectDatas.scorenum)){
                    result += parseFloat(selectDatas.scorenum);
                }
            }
            datas.each(function(data,i){
                if(data.tguid == guid){
                    datas[i]['scorenum'] = result == 0 ? "" : result.toFixed(2);
                }
            });
            gatherWeight(supguid);
        }
    }
    datatable.reflash();
}

function reflashdatas(){
    var datas = datatable.getRecordSet().toArray();
    if(datas!=null && datas.length > 0){
        var scorenum = 0;
        datas.each(function(data,i){
            if(data.name == "总得分" || data.name == "合计"){
                scorenum = datas[i]['scorenum'];
            }
        });
        datas.each(function(data,i){
            if(data.name == "评分等级"){
                if(90 <= scorenum){
                    data['scorenum'] = "优";
                } else if (80 <= scorenum && scorenum <= 89){
                    data['scorenum'] = "良";
                } else if (60 <= scorenum && scorenum <= 79) {
                    data['scorenum'] = "中";
                } else if (scorenum <60) {
                    data['scorenum'] = "差";
                }
            }
            if(data.name == "总体评估结论"){
                if(90 <= scorenum){
                    data['scorenum'] = "建议予以支持";
                } else if (70 <= scorenum && scorenum <= 89){
                    data['scorenum'] = "建议调整完善后予以支持";
                } else if (scorenum <70) {
                    data['scorenum'] = "建议不予支持";
                }
            }
        });
        datatable.reflash();
    }
}