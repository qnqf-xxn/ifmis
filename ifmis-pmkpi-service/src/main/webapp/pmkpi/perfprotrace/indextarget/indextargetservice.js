if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.protrace){
    Ext.lt.pmkpi.protrace = {};
}
var _mainguid;
Ext.lt.pmkpi.protrace.indextarget = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    _mainguid = config.mainguid;//
    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _taskguid = config.taskguid,//任务guid
        _qualtype = config.qualtype, //定性指标类型：1-下拉框（默认）；2-手动输入；
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _busguid = config.busguid,//审核定义guid
        _viewtype = config.viewtype, //区分是否查询:query是查询，其他可修改
        _signs = config.signs,//计算符号
        _bustype = config.bustype,//任务类型
        _procode = config.procode,//项目编码
        _istianjin = config.isTianjin, //是否天津模式
        _ismergeindex = config.ismergeindex,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _isSx = config.isSX,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _isdisplay, //[序时进度预警]列是否显示,不显示时,[偏差原因分析],不校验规则
        _indexvaldatas = config.indexvaldatas,
        _impguid,
        _taskstage = config.taskstage,
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    var _ishebei = config.ishebei,
        _indexdevstandard = config.indexdevstandard;
    var isfirst = true;
    var _isGX = config.isGX;
    var _isNX = config.isNX;
    var _ismarkpro = config.ismarkpro;

    Ext.lt.message.hook("layout", "endlayout2",function(){
        if (isfirst) {
            isfirst = false;
            /**
             * 添加预警规则查看
             */
            if(_isSx == 1){//是山西环境 添加预警规则提示
                $('.tbtitle').append("<button title='预警规则' onclick=\"warnrules();\" type=\"button\" style=\"float:right;margin:0 10px 0 15px;background-color:red\" class=\"layui-btn btn-black\">预警规则</button>");
            }
        }
    });

    $(function () {
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        Ext.lt.pmkpi.query(true);
    });

    Ext.lt.pmkpi.query = function (isquery){
        var params = {};
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        params.tablecode = _tablecode;
        params.procode = _procode;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        params.ismarkpro = _ismarkpro;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service, "getData", params, function(data) {
            setMidSaveHidButtons(data);
            datatable.setDatas(data["#index"]);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                    if((_ismarkpro && _ismarkpro =="1") || _isNX){
                        var quantityubdex = datatable.getRecordset().query({sindex:"11"});
                        for(var i=0;i<quantityubdex.length;i++){
                            var d = quantityubdex[i];
                            if(!d.warn && d.indexval != undefined && d.indexval != ""){
                                Ext.lt.pmkpi.warn(d);
                            }
                        }
                    }
                },500);
            }
        })
    }

    /**
     * 获取最新的绩效指标、目标数据
     */
    cmp.getindexAndGoal = function () {
        Ext.lt.ui.confirm('系统将自动清除页面已填报目标和指标数据，监控预警信息重新计算(如有该信息需重新保存)，请确认？',{icon: "warn"},function(is){
            if(is){
                var params = {};
                params.mainguid = _mainguid;
                params.bustype = _bustype;
                params.tablecode = _tablecode;
                params.procode = _procode;
                params.proguid = _proguid;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service, "getindexAndGoal", params, function(rs) {
                    setMidSaveHidButtons(rs);
                    datatable.setDatas(rs["#index"]);
                    Ext.lt.ui.loadingClose();
                })
            }
        })
    }

    cmp.checkall = function (){
        var cols = datatable.getCols(); //获取列表所有列
        var datas = datatable.getRecordSet().toArray();
        for (var j = 0,lenj = cols.length; j < lenj; j++) {
                for (var i = 0,leni = datas.length; i < leni; i++) {
                    //山西：如果年初指标有值，调整后指标（年度指标值）无值的情况整行不应该填写，也不应该提示让必录
                    if (_isSx == "1" && datas[i]["levelno"] == 3){
                        if (datas[i]["ncindexval"] != null && (datas[i]["targetvalue"] == null || datas[i]["targetvalue"] == "")){

                        }else{
                            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                                    var value = datas[i][cols[j].colcode];
                                    if (value == 0) {
                                        value = value + "";
                                    }
                                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                                        return false;
                                    }
                                }
                            }
                        }
                    }else{
                        for (var j = 0,lenj = cols.length; j < lenj; j++) {
                            if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                                var value = datas[i][cols[j].colcode];
                                if (value == 0) {
                                    value = value + "";
                                }
                                if (!value || value == null || value == "" || ("" + value).trim().length == 0) {
                                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                                    return false;
                                }
                            }
                        }
                    }
                    if (_istianjin){  //是天津模式，加上此判断
                        if((datas[i]["completeanalysis"] != "" && datas[i]["completeanalysis"] == "completeanalysis2" ||datas[i]["completeanalysis"] == "completeanalysis3")
                            && (datas[i]["completeanalyscon"] == null || datas[i]["completeanalyscon"] == "")){
                            var str = "第"+(datas[i]["_sortid"] + 1) + "行的全年预计完成情况为必录项，必须有值！";
                            Ext.lt.ui.alert(str,function(){
                            });
                            return false;
                        }
                        if((datas[i]["completeanalysis"] != "" && datas[i]["completeanalysis"] == "completeanalysis2" ||datas[i]["completeanalysis"] == "completeanalysis3")
                            && (datas[i]["deviationanalysis"] == null || datas[i]["deviationanalysis"] == "")){
                            var str = "第" + (datas[i]["_sortid"] + 1) + "行的偏差原因为必录项，必须有值！";
                            Ext.lt.ui.alert(str,function(){
                            });
                            return false;
                        }
                        if((datas[i]["deviationanalysis"] != "" && datas[i]["deviationanalysis"] != null) && (datas[i]["otherreasons"] == null || datas[i]["otherreasons"] == "")){
                            var str = "第"+(datas[i]["_sortid"] + 1) + "行的原因说明为必录项，必须有值！";
                            Ext.lt.ui.alert(str,function(){
                            });
                            return false;
                        }
                        // if((datas[i]["completeanalysis"] != "" && datas[i]["completeanalysis"] == "completeanalysis2" ||datas[i]["completeanalysis"] == "completeanalysis3")
                        //     && (datas[i]["remark"] == null || datas[i]["remark"] == "")){
                        //     var str = "第"+(datas[i]["_sortid"] + 1) + "行的备注为必录项，必须有值！";
                        //     Ext.lt.ui.alert(str,function(){
                        //     });
                        //     return false;
                        // }
                    } else if(_isNX) { //宁夏 偏差原因分析：当序时进度预警为红灯时必填；偏差原因说明：当“偏差原因分析”非空时，必填；
                        if(_isdisplay == 1 && datas[i]["warn"] == "red" && (!datas[i].deviationanalysis || datas[i].deviationanalysis == "")) {
                            var str = "第" + (datas[i]["_sortid"] + 1) + "行的偏差原因为必录项，必须有值！";
                            Ext.lt.ui.alert(str,function(){
                            });
                            return false;
                        }
                        if((datas[i]["deviationanalysis"] != "" && datas[i]["deviationanalysis"] != null) && (datas[i]["otherreasons"] == null || datas[i]["otherreasons"] == "")){
                            var str = "第"+(datas[i]["_sortid"] + 1) + "行的原因说明为必录项，必须有值！";
                            Ext.lt.ui.alert(str,function(){
                            });
                            return false;
                        }
                    } else {
                        //广西审核定义控制
                        if (!_isGX && _isdisplay == 1 && (datas[i]["warn"] == "red"||datas[i]["warn"] == "yellow")&& (!datas[i].deviationanalysis || datas[i].deviationanalysis == "")) {
                            var str = "第" + (datas[i]["_sortid"] + 1) + "行的偏差原因为必录项，必须有值！";
                            Ext.lt.ui.alert(str,function(){
                            });
                            return false;
                        }
                    }
                }
        }
        return true;
    }

    /**
     *新增根据指标偏差度校验提示
     * @returns {boolean}
     */
    cmp.checkindexval = function (){
        var datas = datatable.getRecordSet().toArray();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if(datas[i].levelno == "3" && datas[i].name != ""){
                var targetvalue = datas[i].targetvalue ? datas[i].targetvalue : 0.00;
                var indexval = datas[i].indexval ? datas[i].indexval : 0.00;
                var deviate = Math.round((parseFloat(indexval) - parseFloat(targetvalue)) / parseFloat(targetvalue) * 10000) / 100.00;
                var computesign = datas[i].computesign;  //deviationanalysis otherreasons
                if ((computesign == "1" && deviate>parseFloat(_indexdevstandard)) && (!datas[i].deviationanalysis || datas[i].deviationanalysis == "" || !datas[i].otherreasons || datas[i].otherreasons == "")) {
                    var str = "第" + (datas[i]["_sortid"] + 1) + "行的当前完成值过于大于年度指标值，需填写偏差分析和说明！";
                    Ext.lt.ui.alert(str,function(){
                    });
                    return false;
                }
                if ((computesign == "3" && parseFloat(indexval) > parseFloat(targetvalue)) && (!datas[i].deviationanalysis || datas[i].deviationanalysis == "" || !datas[i].otherreasons || datas[i].otherreasons == "")) {
                    var str = "第" + (datas[i]["_sortid"] + 1) + "行的当前完成值大于年度指标值，需填写偏差分析和说明！";
                    Ext.lt.ui.alert(str,function(){
                    });
                    return false;
                }
            }
        }
        return true;
    }

    cmp.save = function (){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        if (!cmp.checkall()) return false;//先校验
        if( _ishebei == 1){
            if (!cmp.checkindexval()) return false;
        }
        var params = {};
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        params.datas = datas;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.proguid = _proguid;
        params.taskguid = _taskguid;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "savePrjIndex", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
        var cols = data.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if (col["colcode"] == "computesign") {
                col.fn = function (l, c, d, val) {
                    var computesignstr = "";
                    for (var i = 0; i < _signs.size(); i++) {
                        if (d.computesign == _signs[i].guid) {
                            computesignstr = _signs[i].name;
                        }
                    }
                    return "<font style=\"margin-left:10px;\">" + computesignstr + "</font>";
                }
            }
            if(col["colcode"]=="targetvalue"){ //目标值构建符号和单位
                col.fn = function(l,c,data,val){
                    if(data.computesign == "6" || data.computesign == "7" || data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1"){
                        var targetvalue = !data.targetvalue? "" : data.targetvalue;
                        return "<font style=\"margin-left:10px;\">" + targetvalue+"</font>";
                    } else {
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data.meterunit){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.targetvalue ? computesignstr + unit :computesignstr + data.targetvalue + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
            }
            if(col["colcode"]=="indexval"){
                upcols.push(col["colcode"]);
                //处理指标值，计量单位合并显示
                col.fn = function(l,c,data,col){
                    if(data.computesign == "6" || data.computesign == "9" || data.computesign == "7" || data.computesign == "10"){ //定性
                        // var indexvalue = !data.indexval? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + col+"</font>";
                    }else if(_ismergeindex != "1"){ //不合并
                        var indexvalue = !data.indexval? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">"+indexvalue+"</font>";
                    } else {//合并
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data.meterunit){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1是2否
                    if (!d.levelno || d.levelno != 3) {
                        return false;
                    }
                    if(_ismarkpro && _ismarkpro =="1" && d.sindex == "11"){
                        return false;
                    }
                    if(_isSx == 1){
                        if (!d.is_deleted || d.is_deleted != 2) {
                            return false;
                        }
                    }
                    if ((d.computesign == "6" || d.computesign == "7" || d.computesign == "9" || d.computesign == "10") && _qualtype == "1") {
                        Ext.lt.pmkpi.doMapper(_indexvaldatas,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.indexval != undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                        return;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != '7' && d.computesign != '9' && d.computesign != '10'){
                        if (!d.indexval || d.indexval == "") {
                            d.warn = '';
                            d.deviate = '';
                            return false;
                        }
                        if(!checkReferencepole(d.indexval)){
                            d.indexval = '';
                            d.warn = '';
                            return false;
                        }
                    }
                    Ext.lt.pmkpi.warn(d);
                    var parent_sel_rows = datatable.getRecordset().query({guid:d.guid});
                    var parent_sel_obj = parent_sel_rows[0];
                    var _sortid = parent_sel_obj._sortid;
                    if(d.computesign != '6' && d.computesign != '7' && d.computesign != '9' && d.computesign != '10'){
                        if(d.indexval == '0' || d.targetvalue == '0'){
                            parent_sel_obj["indexcompletion"] = 0;
                        }else{
                            parent_sel_obj["indexcompletion"] = Math.round(d.indexval / d.targetvalue * 10000) / 100.00 + "%";
                        }
                    }
                    datatable.reflash(_sortid);
                }
                col.cseditfn = function (i, j, rs, style) {
                    if (_ismarkpro && _ismarkpro =="1" && rs.sindex == "11") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
            }
            if(col["colcode"] == 'completeanalysis'){//完成可能性分析
                col.oneditend = function (table, el, l, c, d) {
                    if(_istianjin){
                        cmp.compwarn(d);
                    }
                }
            }
            if(col["colcode"]=="warn"){ //目标值构建符号和单位
                _isdisplay = col.isvisiable;
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.warn? "" : data.warn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }

            if(col["colcode"]=="file"){
                col.style = " text-align:center;";
                col.fn = function(l, c, data, val){
                    var name = "上传附件"
                    if (_viewtype == "query") {
                        name = "查看附件";
                    }
                    var html = "";
                    if(data.isleaf == 1){
                        html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
                    }
                    return html;
                }
                col.onclick = function(td, el, l, c, d) {
                    if (d.isleaf != 1) {
                        return;
                    }
                    var params = {};
                    params.mainguid = d.guid + _mainguid;
                    params.filetype = _bustype + "traceindexfile";
                    params.viewtype = _viewtype;
                    params.queryYear = _queryYear;
                    params.queryProvince = _queryProvince;
                    if (isGreyStyle()) {
                        parent.window.Ext.lt.pmkpi.newfilePanelInit(params,Ext.lt.pmkpi.setFileName);
                    }else{
                        var url = '/pmkpi/file/index.page';
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
                    }
                };
            }

            //山西环境
            //1如果年初指标（NCINDEXVAL）有值，调整后指标(年度指标值 TARGETVALUE)无值的情况下全年指标预计完成情况(COMPLETEANALYSCON)不应该可以填写
            if(_isSx == 1){
                if(col["colcode"]=="completeanalyscon"){
                    upcols.push(col["colcode"]);
                    col.oneditstart = function(table,el,l,c,d){
                        //是否可编辑
                        if (!d.levelno || d.levelno != 3) {
                            return false;
                        }
                        if(_isSx == 1){
                            if (!d.is_deleted || d.is_deleted != 2) {
                                return false;
                            }
                        }
                        if(d.ncindexval != null && (d.targetvalue == null || d.targetvalue == "")){
                            return false;
                        }
                    }
                }
            }

            if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check" && col["colcode"] != "file") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
        if (_viewtype != 'query') {
            for(var i=0; i<cols.length; i++){
                if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                    var iscol = false;
                    for (var j=0; j<upcols.length; j++) {
                        if (cols[i]["colcode"] == upcols[j]) {
                            iscol = true;
                            break;
                        }
                    }
                    if (!iscol) {
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            //是否可编辑
                            if (!d.levelno || d.levelno != 3) {
                                return false;
                            }
                            if(_isSx == 1){
                                if (!d.is_deleted || d.is_deleted != 2) {
                                    return false;
                                }
                            }
                        }
                    }
                }
            }
        }
    });

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.levelno != 3){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    /**
     * 山西(查看预警规则)
     */
    warnrules = function(){
        //弹出预警规则
        var alertmsg = '数量、经济效益、社会效益、生态效益、可持续影响指标、满意度指标  \n' +
            '一、正向指标(＝、≥、＞)  \n' +
            '注:标准值 = 年度指标值*(月份/12)\n' +
            '1.实际完成值＜标准值*60%,红灯\n' +
            '2.标准值*60%≤实际完成值＜标准值*80%,黄灯\n' +
            '3.标准值*80%≤实际完成值＜标准值*120%,绿灯\n' +
            '4.标准值*120%≤实际完成值,蓝灯\n\n' +
            //'\n' +
            '二、反向指标(＜、≤)\n' +
            '1.实际完成值在范围内,绿灯\n' +
            '2.实际完成值在范围外,红灯\n\n' +
            //'\n' +
            '三、定性指标\n' +
            '1.实际完成值为\'达到预期目标\',绿灯\n' +
            '2.实际完成值为\'部分达到预期目标,并且具备一定效果\',黄灯\n' +
            '3.实际完成值为\'未达到预期目标\',红灯\n\n' +

            '质量、时效、成本指标  \n' +
            '一、正向指标(＝、≥、＞)和反向指标(＜、≤)  \n' +
            '1.实际完成值在范围内,绿灯\n' +
            '2.实际完成值在范围外,红灯\n\n' +
            //'\n' +
            '二、定性指标\n' +
            '1.实际完成值为\'达到预期目标\',绿灯\n' +
            '2.实际完成值为\'部分达到预期目标,并且具备一定效果\',黄灯\n' +
            '3.实际完成值为\'未达到预期目标\',红灯';
        Ext.lt.ui.alert(alertmsg,function(){
        });
    }

    Ext.lt.pmkpi.warn = function (d){
        var params = {};
        if (d.computesign == "1" || d.computesign == "2") {
            params.warmtype = "positiveindex";
        } else if (d.computesign == "3") {
            if (d.targetvalue && d.targetvalue == 0) {
                params.warmtype = "traceindexequalzero";
            } else {
                params.warmtype = "positiveindex";
            }
        } else if (d.computesign == "4") {
            params.warmtype = "reverselessindex";
        } else if(d.computesign == "5"){
            params.warmtype = "reverseindex";
        }else {
            params.warmtype = "qualitativeindex";
        }
        params.taskguid = _taskguid;
        params.taskstage = _taskstage;
        params.indexval = d.indexval; //当前完成值
        params.targetvalue = d.targetvalue; //年度指标值
        params.mainguid = d.mainguid;
        params.findex = d.findex;
        params.sindex = d.sindex;
        var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
        var parent_sel_rows = datatable.getRecordset().query({guid:d.guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["warn"] = warndata;
        //deviate
        parent_sel_obj["deviate"] = warndata;
        datatable.reflash(_sortid);
    }

    cmp.compwarn = function (d){//天津，计算全年预计完成情况偏离度
        var params = {};
        params.warmtype = "tracecomplateindex";
        params.completeanalysis = d.completeanalysis;
        var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
        var parent_sel_rows = datatable.getRecordset().query({guid:d.guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["compdeviate"] = warndata;
        datatable.reflash(_sortid);
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        var params = {};
        params.data = datatable.getRecordSet().toArray();
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    //导入
    cmp.impdata = function (btn) {
        var btnconfig = eval('(' + btn.config + ')');
        _impguid = createUUID().replace(/-/g, '');
        var params = {};
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.proguid = _proguid; //项目绩效目标
        params.procode = _procode; //项目code
        params.bustype = _bustype;
        params.agencyguid = _saveAgency;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        params.impexpcode = btnconfig[_bustype];
        params.beanid = "pmkpi.perfprotrace.indextarget.ProIndexTargetBOTX";
        params.expfilename = btnconfig[_bustype + "expname"];
        params.bustype = _bustype;
        params.impguid = _impguid;
        params.ismarkpro = _ismarkpro;
        params.taskguid = _taskguid;
        params.taskstage = _taskstage;
        impexp.imp(params, function (){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.ui.alert("导入成功！", function () {
            });
            parent.Ext.lt.pmkpi.impsucess();
        });
    }

    Ext.lt.pmkpi.impsucess = function () {
        var params = {};
        params.impguid = _impguid;
        var datas = Ext.lt.RCP.asyncall(service , "impDatas", params);
        if (datas.length > 0) {
            var filterdatas = datatable.getRecordSet().query({isleaf: 1});
            datatable.removeData(filterdatas);
            var indexdatas = datatable.getRecordSet().toArray();
            datatable.setDatas(datas.concat(indexdatas));
            setTimeout(function(){
                if ((_ismarkpro && _ismarkpro == "1") || _isNX) {
                    var quantityubdex = datatable.getRecordset().query({sindex:"11"});
                    for (var i=0;i<quantityubdex.length;i++) {
                        var d = quantityubdex[i];
                        if (!d.warn && d.indexval != undefined && d.indexval != "") {
                            Ext.lt.pmkpi.warn(d);
                        }
                    }
                }
            },500);
        }
    }

    return cmp;
}

/**
 * 列表附件名称显示进行刷新
 * @param filenames
 * @param billguid
 */
Ext.lt.pmkpi.setFileName = function (filenames, billguid){
    billguid = billguid.substr(0, billguid.length -_mainguid.length);
    var parent_sel_rows = datatable.getRecordset().query({guid:billguid});
    var parent_sel_obj = parent_sel_rows[0];
    var _sortid = parent_sel_obj._sortid;
    parent_sel_obj["filename"] = filenames;
    datatable.reflash(_sortid);
}