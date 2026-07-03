if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.adjust)
    Ext.lt.pmkpi.adjust = {};
/**
 * 初始化加载.
 */
var serviceid;
var _mainguid;
var _saveAgency;
var _datatype;
var totalgoals = []; //总体目标
var yeargoals = []; //年度目标
var deltotal =[]; //删除的总体目标
var delyear = []; //删除的年度目标
var _statustype;
//绩效指标审核 --- 审核时应该是只读，目前也可改只是没有保存按钮，不合理
Ext.lt.pmkpi.adjust.goalindexservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _viewtype = config.viewtype,
        _proguid = config.proguid,//项目/部门guid
        _mainguid = config.mainguid,//主单guid
        _signs = config.signs,//计算符号
        _status = config["status"], //数据状态
        _bustype = config.bustype,//业务类型
        _prolev = config.prolev,
        _kpivals = config["kpivals"], //合肥定量其他值.
        _kpicalnotapply = config["kpicalnotapply"],//不适用
        _ismergeindex = config["ismergeindex"],//指标值是否合并单位符号
        _pmkpidatatype = config.pmkpidatatype,//数据类型
        _procode = config.procode,
        _pro_name = decodeURIComponent(config.pro_name),
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _ishebei = config.ishebei,
        _busguid = config.busguid//审核定义guid，perf_t_busauditdefine表budguid
    ;
    var _displaycols = [];
    _statustype=config.pmkpidatatype;

    var cmp = {};
    serviceid = service;
    _mainguid = config.mainguid;
    _saveAgency = config.saveAgency;
    _scrWidth = document.body.clientWidth;
    _scrHeight = document.body.clientHeight;
    _datatype = config.datatype;//数据类型
    isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
    var firstpage =  true;



    $(function () {
        common.initDatatable(maintable); //初始化加载主表
        common.initDatatable(); //初始化加载子表
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        cmp.mainquery(true);
        if (_viewtype == "query") {
            for(var i=2; i<maintable.getCols().length; i++){
                maintable.getCols()[i].edit = false;
            }
            for(var i=2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            maintable.redraw();
            datatable.redraw();
            if(_SYSTEMSTYLE_ == "grey"){
                $(".tbtitle").hide();
            }else{
                $("#add").hide();
                $("#del").hide();
            }
        }
        // cmp.resiztable();

    })


    Ext.lt.message.hook("layout", "endlayout2", function(){
        if (typeof(maintable) != "undefined" && maintable != null) {
            maintable.resize(undefined, _scrHeight*0.6);
        }
        if (typeof(datatable) != "undefined" && datatable != null) {
            datatable.resize(undefined, _scrHeight);
        }
    });

    /**
     * 主表查询.
     * goaltype -- 1 中长期， 0 年度
     */
    cmp.mainquery = function (isquery){
        if (firstpage){
            var params = {};
            params.tablesql = _defquery;
            params.orderby = _orderby;
            params.tablecode = _tablecode;
            params.mainguid = _mainguid;
            params.proguid = _proguid;
            params.bustype = _bustype;
            params.procode = _procode;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "getMainDatas", params, function(rs){
                yeargoals = rs.yeargoals;
                maintable.setDatas(yeargoals);
                maintable.clearSelected();
                datatable.setDatas([]);
                Ext.lt.ui.loadingClose();
                if (isquery) {
                    setTimeout(function(){
                        parent._isQuery = true;
                    },500);
                }
            },function(){
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('目标查询失败！',function(){
                });
            });
        } else {
            maintable.setDatas(yeargoals);
            maintable.clearSelected();
            datatable.setDatas([]);
        }
        firstpage = false;
    }

    /**
     * 主表的选中单选事件
     */
    Ext.lt.message.hook("fasp2datatable", "onRadioClick",function(d){
        //处理子表数据保存到主表上
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        cmp.query(d[4]);
    });


    /**
     * 主表的新增.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        var newdata ={};
        newdata.proguid = _proguid;
        newdata.mainguid = _mainguid;
        newdata.busguid = _busguid;
        newdata.saveAgency = _saveAgency;
        newdata.procode = _procode;
        newdata.bustype = _bustype;
        newdata.guid = newguid;
        newdata.rowtype = "add";
        newdata.status = 3;
        newdata["#indexs"] = [];
        newdata["#delindex"] = [];
        newdata["yearflag"] = "0"; //总体还是年度
        var n = maintable.getRecordset().size(); //总数+1
        newdata["goalname"] = "年度目标" +(n+1);
        //加行时状态为新增 status=3
        doMapper(_pmkpidatatype, maintable.getCol(3));
        maintable.getRecordSet().addData(newdata,999);
    });

    /**
     * 主表的删除.
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var selDatas = maintable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的目标数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择目标数据？\n【目标删除对应指标会一同删除】',{icon: "warn"},function(is){
            if(is){
                if(selDatas[0].rowtype != null && selDatas[0].rowtype == "add" || selDatas[0].status == "3"){//新增状态的目标可以直接删除
                    maintable.removeData(selDatas[0]);
                    delyear.push(selDatas[0]);
                }else{
                    //数据状态改为删除
                    selDatas[0]["status"] = 1;
                    selDatas[0]["adjustndgoal"] = '';//删除状态'调整后指标值'清空
                    selDatas[0]["obligate1"] = "撤销删除";
                    delyear.push(selDatas[0]); //年度删除
                    doMapper(_pmkpidatatype, maintable.getCol(3));
                    maintable.reflashdata();
                    //关联指标数据同步删除

                }
            }
        })
    });



    Ext.lt.pmkpi.query = function (param) {
        //cmp.query(d);
        var params = {};
        params.mainguid = param.mainguid;
        params.goalguid = param.guid;
        Ext.lt.RCP.call(serviceid, "getIndexData", params, function (rs) {
            datatable.setDatas(rs.data);
        }, function () {
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    };

    /**
     * 重新刷新表格.
     */
    cmp.resiztable = function (){
        var width = $("#maintable").width;
        if(_SYSTEMSTYLE_ == "grey"){
            maintable.resize(width-20,_scrHeight*0.45);
        }else{
            maintable.resize(width-20,_scrHeight*0.4);
        }
        datatable.resize(width-20,_scrHeight);
    }


    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    /**
     * 子表查询
     * @param d -- 选中数据.
     */
    cmp.query = function(d){
        var indexs = d["#indexs"];
        if (indexs.length > 0){
            datatable.setDatas(indexs);
        } else {
            var params = {};
            params.mainguid = d.mainguid;
            params.goalguid = d.guid;
            Ext.lt.RCP.call(serviceid , "getSubData", params, function(rs){
                datatable.setDatas(rs.data);
            },function(){
                Ext.lt.ui.alert('查询失败！',function(){
                });
            });
        }
    }


    /**
     * 行级新增操作
     */
    cmp.addbtnrow = function(obj,selguid){
        var data = [];
        if (!selguid) {
            data = cmp.getSeletdata("1");
            if(data.length != 1){
                Ext.lt.ui.alert("请选择一条二级指标！",function(){});
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid:selguid});
        }
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var indexdata = {};
        var uuid = getCreateguid(serviceid);
        var indexcols = datatable.getCols();
        for (var i = 0, len = indexcols.length; i < len; i++) {
            var col = indexcols[i];
            var colcode = col.colcode;
            indexdata[colcode] = "";
        }
        indexdata.guid = uuid;
        indexdata.saveAgency = _saveAgency; //项目单位
        indexdata.sindex = data[0].sindex;
        indexdata.findex = data[0].findex;
        indexdata.superid = data[0].sindex;
        indexdata.levelno = 3;
        indexdata.isleaf = 1;
        indexdata._isleaf = 1;
        indexdata.rowtype = "add";
        indexdata.indexstatus = 3;
        indexdata.status = 3;
        indexdata.is_add="1";
        //数据状态翻译
        indexdata.obligate = "删除";
        doMapper(_pmkpidatatype, datatable.getCol("indexstatus"));
        datatable.getRecordSet().addData(indexdata,_sortid + datatable.getRecordset().toArray().length);
        datatable.reflashdata();
    }




    /**
     * 整体的保存方法.
     * @returns {*}
     */
    cmp.save = function(){
        if (maintable.getEditor()){
            maintable.closeEdit();
        }
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        //1 表格切换之前先保存一下子表到主表行。
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        //2将主表保存到全局变量上
        yeargoals = maintable.getRecordSet().toArray();
        //3请求后端保存
        if (!cmp.nullcheck()) return false;
        if (!maintable.check()) return false;
        if (!cmp.checkAll()) return false;//先校验
        //处理指标名称、指标值字段 特殊字替换
        for (var x = 0; x < yeargoals.length; x++) {
            yeargoals[x].kpi_target = yeargoals[x].kpi_target == "" || yeargoals[x].kpi_target == undefined ? "" : convertStr(yeargoals[x].kpi_target);
            var indexlist = yeargoals[x]["#indexs"];
            var delindexlist = yeargoals[x]["#delindex"];
            var goalname = yeargoals[x]["goalname"];
            if (!common.checkSpaceValue(yeargoals[x],"绩效目标：" + goalname+"","maintable")) return;//校验空格
            for (var y = 0; y < indexlist.length; y++) {
                if(indexlist[y]["levelno"] == 3){
                    if (!common.checkSpaceValue(indexlist[y],"绩效目标：" + goalname+"-绩效指标-第" + (indexlist[y]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                    indexlist[y]["name"] = indexlist[y]["name"] == "" || indexlist[y]["name"] == undefined ? "" :convertStr(indexlist[y]["name"]);
                    indexlist[y]["indexval"] = indexlist[y]["indexval"] == "" || indexlist[y]["indexval"] == undefined ? "" :convertStr(indexlist[y]["indexval"]);
                    indexlist[y]["kpi_val"] = indexlist[y]["kpi_val"] == "" || indexlist[y]["kpi_val"] == undefined ? "" :convertStr(indexlist[y]["kpi_val"]);
                    indexlist[y]["adjustindexval"] = indexlist[y]["adjustindexval"] == "" || indexlist[y]["adjustindexval"] == undefined ? "" :convertStr(indexlist[y]["adjustindexval"]);
                }
            }
            for(var z = 0; z < delindexlist.length; z++){
                if(delindexlist[z]["levelno"] == 3){
                    delindexlist[z]["name"] = delindexlist[z]["name"] == "" || delindexlist[z]["name"] == undefined ? "" :convertStr(delindexlist[z]["name"]);
                    delindexlist[z]["indexval"] = delindexlist[z]["indexval"] == "" || delindexlist[z]["indexval"] == undefined ? "" :convertStr(delindexlist[z]["indexval"]);
                    delindexlist[z]["kpi_val"] = delindexlist[z]["kpi_val"] == "" || delindexlist[z]["kpi_val"] == undefined ? "" :convertStr(delindexlist[z]["kpi_val"]);
                    delindexlist[z]["adjustindexval"] = delindexlist[z]["adjustindexval"] == "" || delindexlist[z]["adjustindexval"] == undefined ? "" :convertStr(delindexlist[z]["adjustindexval"]);
                }
            }
        }
        var params = {};
        params.yeargoals = yeargoals;//年度
        params.delyear = delyear;//年度删除
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.mainguid = _mainguid;
        params.procode = _procode;
        params.proguid = _proguid;
        params.pro_name = _pro_name;
        params.bustype = _bustype;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            firstpage = true;
            delyear = [];
            cmp.mainquery();
        }
        return rs;
    }

    /**
     * 目标非空校验.
     */
    cmp.nullcheck = function (){
        if (yeargoals.length == 0){
            Ext.lt.ui.alert("年度目标不可为空！",function(){});
            return false;
        }
        return  true;
    }

    /**
     * 最終保存时候表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function() {
        for (var k = 0,lenk = yeargoals.length; k < lenk; k++) {
            var datas = yeargoals[k]["#indexs"];
            var cols = datatable.getCols();
            for (var i = 0,leni = datas.length; i < leni; i++) {
                for (var j = 0,lenj = cols.length; j < lenj; j++) {
                    if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                        var value = datas[i][cols[j].colcode];
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            alert("[年度目标]第"+(k+1)+"行的绩效指标第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。");
                            return false;
                        }
                    }
                }
                //处理计算符号为定性，单位不填情况
                if (datas[i]["computesign"] != "6" && (datas[i]["meterunit"] == ""||datas[i]["meterunit"] == null||datas[i]["meterunit"] == undefined) && datas[i]["levelno"] == 3 ){
                    alert("[年度目标]第"+(k+1)+"行的绩效指标第" + (datas[i]["_sortid"] + 1) + "行的单位必须有值。");
                    return false;
                }
            }
        }
        return true;
    }


    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col.colcode == "adjustweight") {
                _isadjustweight = col.display;
            }
            if (_viewtype == 'query' && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
            //目标操作列
            if (col["colcode"] == "obligate1") {
                if (_viewtype != "query") {
                    col.style = " text-align:center;color:#468ac9;cursor:pointer;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if (data.status == 1){
                            html = '<a title = "撤销删除" style="color:#468ac9;cursor:pointer;"\'>撤销删除</a>';
                        }
                        return html;
                    }
                    col.onclick = function (td, el, l, c, d) {
                        if(d.status != null && d.status ==1){
                            Ext.lt.ui.confirm("确认要撤销删除选中数据？", {icon: "warn"}, function (ret) {
                                if (ret) {
                                    var guid = d.guid;
                                    var delyearnew = [];
                                    if(delyear != null){
                                        for (var i=0; i<delyear.length; i++) {
                                            if(delyear[i].guid != guid){
                                                delyearnew.push(d);
                                            }
                                        }
                                    }
                                    delyear = delyearnew;
                                    var _sortid = d._sortid;
                                    //撤销删除 状态清空
                                    d.status = "";
                                    d.obligate1 = "";
                                    d.adjustndgoal = "";
                                    $.extend(d, d); //合并值集刷新
                                    maintable.reflash(_sortid);
                                }
                            })
                        }
                    };
                }
            }
            //指标操作列
            if(col["colcode"]=="obligate"){
                if (_viewtype != "query"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if (data.levelno == "2"){
                            //html += '<a title = "新增" style="color:#468ac9;cursor:pointer;">新增</a>';
                        } else if(data.levelno == "3" && data.status != "1"){
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'","'+data._locationposition+'","'+data.sindex+'")\'>删除</a>';
                        } else if(data.status == "1" || data.indexstatus == "1"){
                            html = '<a title = "撤销删除" style="color:#468ac9;cursor:pointer;"\'>撤销删除</a>';
                        }
                        return html;
                    }
                    col.onclick = function(td, el, l, c, d) {
                        var levelno = d.levelno;
                        if (levelno == "2"){
                            cmp.addbtnrow("",d.guid);
                        }
                        //撤销删除
                        if(levelno == "3" && d.status != null && d.status =="1"){
                            Ext.lt.ui.confirm("确认要撤销删除选中数据？", {icon: "warn"}, function (ret) {
                                if (ret) {
                                    var guid = d.guid;
                                    var delyearnew = [];
                                    if(delyear != null){
                                        for (var i=0; i<delyear.length; i++) {
                                            if(delyear[i].guid != guid){
                                                delyearnew.push(d);
                                            }
                                        }
                                    }
                                    delyear = delyearnew;
                                    var _sortid = d._sortid;
                                    //撤销删除 状态清空
                                    d.status = "";
                                    d.indexstatus = "";
                                    d.obligate = "";
                                    d.adjustindexval = "";
                                    $.extend(d, d); //合并值集刷新
                                    datatable.reflash(_sortid);


                                    var _sortid = d._sortid;
                                    d.status = "";
                                    d.indexstatus = "";
                                    d.obligate = "";
                                    d.adjustindexval = "";
                                    $.extend(d, d); //合并值集刷新
                                    datatable.reflash(_sortid);
                                    datatable.reflashdata();
                                    // mainsel[0]["#delindex"].remove(d);
                                }
                            })
                        }
                    };
                }
            }
            //目标数据状态
            if (col["colcode"] == "status") {
                col.oneditstart = function (table, el, l, c, d) {
                    var status = "";
                    if(d.status != null){
                        for (var i = 0; i < _status.size(); i++) {
                            if (d.status == _status[i].guid) {
                                status = _status[i].name;
                            }
                        }
                    }
                    return status;
                }
            }
            //年度绩效目标(调整前)
            if (col["colcode"] == "kpi_target") {
                col.oneditstart = function (table, el, l, c, d) {
                    //除新增状态外 调整前绩效指标都不可修改
                    if(d.status !=3){
                        return false;
                    }
                }
            }
            //年度绩效目标(调整后)
            if (col["colcode"] == "adjustndgoal") {
                col.oneditstart = function (table, el, l, c, d) {
                    //新增状态‘调整后目标’不可修改
                    if(d.status ==3){
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    //新增的目标状态不变  年初指标状态根据‘调整后’有没有值来判断
                    if(d.status != 3 && d.status != 1){
                        if(d.adjustndgoal != null && d.adjustndgoal != ""){
                            //’年度绩效目标(调整后)‘ 有值 则状态改为修改
                            d.status = 2;
                            doMapper(_pmkpidatatype, table.getCol("status"));
                        }else{
                            //’年度绩效目标(调整后)‘ 无值 则状态改为空
                            d.status = "";
                        }
                    }
                    /*if(d.adjustndgoal != null && d.adjustndgoal != "" && d.rowtype != "add"){
                        d.status = 2;
                        doMapper(_pmkpidatatype, table.getCol(3));
                    }
                    if((d.adjustndgoal == null || d.adjustndgoal == "") && d.rowtype != "add"){
                        d.status = "";
                    }*/
                }
            }
            if (col["colcode"] == "indexstatus") {//指标状态
                col.fn = function (l, c, data, col) {
                    var indexstatus = "";
                    if(data.status != null && data.status != ""){
                        for (var i = 0; i < _status.size(); i++) {
                            if (data.status == _status[i].guid) {
                                indexstatus = _status[i].name;
                            }
                        }
                    }
                    return indexstatus;
                }
            }
            //指标值
            if (col["colcode"] == "indexval") {
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1") {
                        var indexvalue = !data.indexval ? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                    } else {
                        var computesignstr = "";
                        for (var i = 0; i < _signs.size(); i++) {
                            if (data.computesign == _signs[i].guid) {
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if (data["meterunit"]) {
                            unit = data.meterunit;
                        }
                        var returnstr = !data.indexval ? computesignstr + unit : computesignstr + data.indexval + unit;
                        return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.status != "3") {
                        return false;
                    }
                    if(d.levelno == "3" && (d.status == null || d.status == "" || d.status == "2")){//申报数据/修改状态数据
                        return false;
                    }

                    if (d.computesign == "9") { //合肥添加定量其他
                        doMapper(_kpivals, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.indexval != undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                    //河北的固化指标不可修改
                    if(_ishebei = '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                        return false;
                    }
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10') {
                        if (!checkReferencepole(d.indexval)) {
                            d.indexval = '';
                            return false;
                        }
                    }
                    if (d.indexval != '') {
                        var computesign = d.computesign;
                        if (!d.computesign) {
                            Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
                            d.indexval = '';
                            return false;
                        }
                    }
                    if (d.computesign == "9") {
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }
            //调整后指标值
            if (col["colcode"] == "adjustindexval") {
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10"  || _ismergeindex != "1") {
                        var indexvalue = !data.adjustindexval ? "" : data.adjustindexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                    } else {
                        var computesignstr = "";
                        for (var i = 0; i < _signs.size(); i++) {
                            if (data.computesign == _signs[i].guid) {
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if (data["meterunit"]) {
                            unit = data.meterunit;
                        }
                        var returnstr = !data.adjustindexval ? computesignstr + unit : computesignstr + data.adjustindexval + unit;
                        return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //新增状态‘调整后目标’不可修改
                    if(d.status ==3){
                        return false;
                    }
                    if (d.levelno != "3" || d.status == "1") {
                        return false;
                    }
                    if (d.computesign == "9") { //合肥添加定量其他
                        doMapper(_kpivals, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.adjustindexval != undefined ? d.adjustindexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    var computesign = d.computesign;
                    if (computesign && computesign != '6' && computesign != '9' && computesign != '10') {
                        if (!checkReferencepole(d.adjustindexval)) {
                            d.adjustindexval = '';
                            return false;
                        }
                    }
                    if (d.adjustindexval != '') {
                        if (!computesign) {
                            Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
                            d.adjustindexval = '';
                            return false;
                        }
                    }
                    if (computesign == "9") {
                        d["kpivalsource"] = d["adjustindexval"];
                    }
                    //新增的目标状态不变  年初指标状态根据‘调整后’有没有值来判断
                    if(d.status != 3 && d.status != 1){
                        if(d.adjustindexval != null && d.adjustindexval != ""){
                            //’年度绩效目标(调整后)‘ 有值 则状态改为修改
                            d.status = 2;
                            d.indexstatus = 2;
                            doMapper(_pmkpidatatype, table.getCol("indexstatus"));
                        }else{
                            //’年度绩效目标(调整后)‘ 无值 则状态改为空
                            d.status = "";
                            d.indexstatus = "";
                        }
                    }
                }
            }
            //一二级指标不可修改
            if (col["colcode"] == "isstandpush" || col["colcode"] == "computetype" || col["colcode"] == "indexstandards" || col["colcode"] == "snindexval"
                || col["colcode"] == "qnindexval" || col["colcode"] == "explain" || col["colcode"] == "name" || col["colcode"] == "weight"|| col["colcode"] == "meterunit"
                || col["colcode"] == "computesign"|| col["colcode"] == "kpi_content"|| col["colcode"] == "kpi_evalstd"|| col["colcode"] == "kpi_remark"
                || col["colcode"] == "opinion_remark"|| col["colcode"] == "value_remark") {
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.status == "1") {
                        return false;
                    }
                    if(d.levelno == "3" && (d.status == null || d.status == "" || d.status == "2")){//申报数据/修改状态数据
                        return false;
                    }
                }
            }

            if (col["colcode"] == "computesign") {
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10") {
                        if (!checkReferencepole(d.indexval)) {
                            d.indexval = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "9") {
                        var istrue = false;
                        for (var i = 0; i < _kpivals.length; i++) {
                            if (d.indexval == _kpivals[i].guid) {
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "10") {
                        var istrue = false;
                        for (var i=0; i<_kpicalnotapply.length; i++) {
                            if (d.indexval == _kpicalnotapply[i].guid){
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            return false;
                        }
                    }
                }
            }

            if (col["colcode"] == "adjustweight") {
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeight(d.superid);
                }
            }
        }
    });

    Ext.lt.pmkpi.addrow = function (data) {
        datatable.getRecordSet().addData(data, 999);
    }

    /**
     * 指标推荐方法.
     */
    cmp.recom = function () {
        var url = '/pmkpi/program/prjindex/recomindex.page';
        var params = {};
        params.proguid = _proguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        params.isadjust = "true";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "指标推荐");
    }

    /**
     * 新增
     */
    cmp.add = function (obj, selguid) {
        var data = [];
        if (!selguid) {
            data = cmp.getSeletdata("1");
            if (data.length != 1) {
                Ext.lt.ui.alert("请选择一条二级指标！", function () {
                });
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid: selguid});
        }
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var url = "";
        if (_bustype != null && ("dept" == _bustype || "depttrace" == _bustype)) {
            url = "/pmkpi/adjust/report/deptedit/editindex.page";
        } else if (_bustype != null && ("program" == _bustype || "protrace" == _bustype)) {
            url = "/pmkpi/adjust/report/proedit/editindex.page";
        }
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "新增指标");
    }
    /**
     * 修改
     */
    cmp.mod = function () {
        var data = cmp.getSeletdata("2");
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择一个三级指标修改！", function () {
            });
            return;
        } else if (data.length == 1 && (!data[0].levelno || data[0].levelno != 3)) {
            Ext.lt.ui.alert("请选择三级指标修改！", function () {
            });
            return;
        } else if (data.length == 1 && data[0].status != 3) {
            Ext.lt.ui.alert("请选择新增状态三级指标修改！", function () {
            });
            return;
        }
        var url = "";
        if (_bustype != null && ("dept" == _bustype || "depttrace" == _bustype)) {
            url = "/pmkpi/adjust/report/deptedit/editindex.page";
        } else if (_bustype != null && ("program" == _bustype || "protrace" == _bustype)) {
            url = "/pmkpi/adjust/report/proedit/editindex.page";
        }
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.modguid = data[0].guid;
        params.type = "mod";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "修改指标");
    }

    cmp.del = function (obj, selguid) {
        var data = [];
        if (!selguid) {
            data = datatable.getSelected();
            if (data.length == 0) {
                Ext.lt.ui.alert("请选择需要删除的指标！", function () {
                });
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid: selguid});
        }
        Ext.lt.ui.confirm("确认要删除选中指标？", {icon: "warn"}, function (ret) {
            if (ret) {
                var tempArray = maintable.getSelected();
                var goalguid = tempArray[0]["guid"];
                var mainsel = maintable.getRecordset().query({guid: goalguid});
                var datas = datatable.getSelected();
                if (datas != null && datas.length > 0) {
                    for (var i = 0; i < datas.length; i++) {
                        var selectDatas = datas[i];
                            if (selectDatas.levelno == 3) {
                                if (selectDatas.indexstatus == 3 || selectDatas.status == 3) {
                                    datatable.removeData(selectDatas);
                                    mainsel[0]["#delindex"].push(selectDatas);
                                } else {
                                    var _sortid = selectDatas._sortid;
                                    selectDatas.status = 1;
                                    selectDatas.indexstatus = 1;
                                    selectDatas.obligate = "撤销删除";
                                    doMapper(_statustype, datatable.getCol("indexstatus"));
                                    $.extend(selectDatas, selectDatas); //合并值集刷新
                                    datatable.reflash(_sortid);
                                    datatable.reflashdata();
                                }
                            }
                    }
                }
            }
        })
    }

    /**
     * 表格的选择行.
     * @param type 1:包含二级，2 只有末级
     */
    cmp.getSeletdata = function (type) {
        var _datas = datatable.getRecordSet().toArray();
        var seldata = [];
        var len = _datas.length;
        for (var i = 0; i < len; i++) {
            if ("1" == type) {
                if (_datas[i]["check"] == 1 && _datas[i]["levelno"] != 1) {
                    seldata.push(_datas[i]);
                }
            } else if ("2" == type) {
                if (_datas[i]["check"] == 1 && _datas[i]["levelno"] == 3) {
                    seldata.push(_datas[i]);
                }
            } else {
                seldata.push(_datas[i]);
            }
        }
        return seldata;
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "obligate1") {
                _displaycols.push(col); //隐藏前暂存至sfagency;
                col.display = false; //display置为false，隐藏
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    return cmp;
}

function indexcheck(guid) {
    var url = "/pmkpi/deptperformance/report/indexcheck.page";
    var params = {};
    params.sindex = guid;
    params.saveAgency = _saveAgency;
    params.mainguid = _mainguid;
    url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "选择指标");
}

/**
 * 子表行级删除.
 * @param guid
 * @param _locationposition
 * @param sindex
 */
function indexdel(guid,_locationposition,sindex) {
    Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
        if(ret){
            var tempArray = maintable.getSelected();
            var goalguid = tempArray[0]["guid"];
            var mainsel = maintable.getRecordset().query({guid:goalguid});
            var datas = datatable.getRecordSet().toArray();
            if(datas!=null && datas.length > 0) {
                for (var i = 0; i < datas.length; i++) {
                    var selectDatas = datas[i];
                    if (guid == selectDatas.guid) {

                        if (selectDatas.levelno == 3) {
                            if (selectDatas.indexstatus == 3 ||selectDatas.status == 3) {
                                datatable.removeData(selectDatas);
                                mainsel[0]["#delindex"].push(selectDatas);
                            } else {
                                var _sortid = selectDatas._sortid;
                                selectDatas.status = 1;
                                selectDatas.indexstatus = 1;
                                selectDatas.obligate = "撤销删除";
                                doMapper(_statustype, datatable.getCol("indexstatus"));
                                $.extend(selectDatas, selectDatas); //合并值集刷新
                                datatable.reflash(_sortid);
                                datatable.reflashdata();
                            }
                        }
                        /*if (mainsel.length > 0 && selectDatas["rowtype"] !="add"){
                            mainsel[0]["#delindex"].push(selectDatas);
                        }*/
                    }
                }
            }
        }
    });
}


function gatherWeight(superid) {
    var datas = datatable.getRecordSet().toArray();
    if (superid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var result = 0.00;
            var ajdresult = 0.00;
            var guid = '';
            for (var i = 0; i < datas.length; i++) {
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas.adjustweight && !isNaN(selectDatas.adjustweight) && selectDatas.status !="1") {
                    if (selectDatas.weight) {
                        result += parseFloat(selectDatas.weight);
                    }
                    ajdresult += parseFloat(selectDatas.adjustweight);
                } else if (selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)) {
                    result += parseFloat(selectDatas.weight);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['weight'] = result == 0.00 ? "" : result.toFixed(2);
                    datas[i]['adjustweight'] = ajdresult == 0.00 ? "" : ajdresult.toFixed(2);
                }
            });
            gatherWeight(supguid);
            amtTotal(datatable);
        }
    }
    datatable.reflash();
}

function amtTotal(table) {
    if (table.getSumobj()) {
        var totalrow = table.getRecordset();
        var sumamt = 0.00;
        var adjsumamt = 0.00;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for (var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3" && rowarr[i].status !="1") {
                var adjustweight = rowarr[i]["adjustweight"] ? rowarr[i]["adjustweight"] : 0.00;
                adjsumamt += parseFloat(adjustweight);
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                var adjustweight = rowarr[i]["adjustweight"] ? rowarr[i]["adjustweight"] : 0.00;
                sumamt += parseFloat(weight);
                adjsumamt += parseFloat(adjustweight);
            }
        }
        var totalrs = {};
        totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
        totalrs["adjustweight"] = adjsumamt == 0 ? "" : adjsumamt.toFixed(2);
        totalrs.datatable_do_sum = true;
        _adjustweightTotal = totalrs["adjustweight"];
        table.getClockRowSet().setData(totalrs, 0);
        if ((totalrow.size && totalrow.size() > 0) || (totalrow.length && totalrow.length > 0)) {
            table.reflashdata();
        }
    }
}

function getdataSource() {
    var datatype_source = [];
    for (var i = 0; i < _datatype.length; i++) {
        var temparr = [];
        temparr.push(_datatype[i]["guid"]);
        temparr.push(_datatype[i]["code"]);
        temparr.push(_datatype[i]["name"]);
        datatype_source.push(temparr);
    }
    datatable.addMapperDatas("status", datatype_source);
}

/**
 * 动态改变列的属性.
 * @param rs
 * @param col
 */
function doMapper(rs, col) {
    var mapping = [];
    var columns = [];
    for (var i = 0; i < rs.size(); i++) {
        var arr = [];
        arr.push(rs[i].guid);
        arr.push(rs[i].code);
        arr.push(rs[i].name);
        columns.push(arr);
        mapping[rs[i].code] = arr;
    }
    col.mapping = mapping;
    col.mapper = {};
    col.mapper.columns = ['guid', 'code', 'name', 'supcode', 'pinyin'];
    col.mapper.datas = columns;
    col.mapper.regs = ['#guid', '#code', '#name', '#supcode', '#pinyin'];
    col.mapper.default_column = 'code';
    col.format = '#name';
}